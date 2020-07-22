#
# @todo
#
class Net {
    static Trace([string] $address, [int] $timeoutMs, [int] $maxTTL, [int] $bufferLength, [int] $hops, [ScriptBlock] $callback) {
        <#param (
          [parameter(mandatory=$true)]  [string]    $address,
          [parameter(mandatory=$false)] [int]       $timeoutMs = 5000,
          [parameter(mandatory=$false)] [int]       $maxTTL = 128,
          [parameter(mandatory=$false)] [int]       $bufferLength = 32
        )#>

        $ping = new-object System.Net.NetworkInformation.Ping 
        $byteString = "*".PadRight($bufferLength, "*")
        $message = [System.Text.Encoding]::Default.GetBytes($byteString) 
        $dontfragment = $false

        $sSuccess = [System.Net.NetworkInformation.IPStatus]::Success
        $sTimedOut = [System.Net.NetworkInformation.IPStatus]::TimedOut

        for ($ttl=1; $ttl -le $maxTTL; $ttl++) {
            $addr = '*'
            $dnsName = '*'
            $trips = @();
            $success = $false
            $pingOptions = new-object System.Net.NetworkInformation.PingOptions($ttl, $dontfragment)  

            for ($hop=0; $hop -lt $hops; $hop++) {
                $ts_a = timestamp_ms ;
                $reply = $ping.Send($address, $timeoutMs, $message, $pingOptions);
                $ts_b = timestamp_ms ;

                # detecting dns name (if avaliable)
                if($reply.Status -ne $sTimedOut) {
                    $addr = $reply.Address
                    try {
                        $dns = [System.Net.Dns]::GetHostByAddress($addr)
                        $dnsName = "$addr ($($dns.HostName))"
                    } catch {
                        $dnsName = $addr
                    }
                } 

                # Get RTT or calculate it if unavaliable
                if($reply.Status -eq $sSuccess){
                    $success = $true
                    $rtt = @{
                        int = $reply.RoundtripTime;
                        string = "$($reply.RoundtripTime) ms";
                    }

                } elseif($reply.Status -eq $sTimedOut) {
                    $rtt = @{
                        int = $timeoutMs;
                        string = "> $($timeoutMs) ms";
                    }
                } else {
                    $rtt = @{
                        int = $ts_b - $ts_a;
                        string = "~ $($ts_b - $ts_a) ms";
                    }
                }

                $trips += @{
                    Status =  $reply.Status;
                    RTT = $rtt;
                }
            }

            Invoke-Command -ScriptBlock $callback -ArgumentList $ttl, $addr, $dnsName, $trips

            if($success) {break}
        }
    } 
}