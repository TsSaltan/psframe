<#
 # Класс для работы с сетевыми функциями
 #
 # @method Trace                    Трасировка
 # @param string $address           IP-address or domain name
 # @param int $timeoutMs = 5000     Timeout in ms
 # @param int $maxTTL = 256         Максимальное количество прыжков
 # @param int $bufferLength = 32    Размер буфера
 # @param int $hops = 3             Количество пингов для одного участка
 # @param ScriptBlock $callback     Функция, в которую будут передаваться данные для каждого прыжка
 #                                  Передаваемые аргументы:
 #                                  [int] $hop          Номер прыжка (начиная с 1, максимум - $maxTTL) 
 #                                  [string] $address   IP-адрес текущего прыжка 
 #                                  [string] $dnsName   IP-адрес + если удается определить доменное имя текущего прыжка 
 #                                  [array] $trips      Массив с данными о прыжке
 #                                      @{
 #                                          Status [string|object] Статус пинга
 #                                          RTT = {         Время пинга
 #                                              int         
 #                                              string      в строке добавляются символы > ~ и единицы измерения
 #                                          }
 #                                      } 
 # @example [Net]::Trace('google.com', {
 #      param($hop, $address, $dnsName, $trips)
 #      Write-Host "[#$hop] `t $dnsName"
 #      foreach ($trip in $trips){
 #          Write-Host "`t $($trip.Status) `t $($trip.RTT.string)"
 #      }
 # });
 #>
class Net {
    static Trace([string] $address, [ScriptBlock] $callback) {
        [Net]::Trace($address, 5000, 256, 32, 3, $callback)
    }

    static Trace([string] $address, [int] $timeoutMs, [ScriptBlock] $callback) {
        [Net]::Trace($address, $timeoutMs, 256, 32, 3, $callback)
    }

    static Trace([string] $address, [int] $timeoutMs, [int] $maxTTL, [ScriptBlock] $callback) {
        [Net]::Trace($address, $timeoutMs, $maxTTL, 32, 3, $callback)
    }

    static Trace([string] $address, [int] $timeoutMs, [int] $maxTTL, [int] $bufferLength, [ScriptBlock] $callback) {
        [Net]::Trace($address, $timeoutMs, $maxTTL, $bufferLength, 3, $callback)
    }

    static Trace([string] $address, [int] $timeoutMs, [int] $maxTTL, [int] $bufferLength, [int] $hops, [ScriptBlock] $callback) {

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