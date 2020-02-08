class COM {
    static [object] getPorts(){
        $query = "Select * From `Win32_PnPEntity` Where `PNPClass` = 'Ports'";
        return [COM]::getPortsFromQuery($query);
    }

    static [object] findPorts([string] $deviceName){
        $query = "Select * From `Win32_PnPEntity` Where `PNPClass` = 'Ports' And `Name` like '%{0}%'" -f $deviceName
        return [COM]::getPortsFromQuery($query);
    }

    hidden static [object] getPortsFromQuery([string] $query){
        $ports = @();

        $devices = Get-WmiObject -Query "$query";
        foreach ($device in $devices){
            $port = @{};

            if($device['Caption'] -match 'COM\d+'){
                $port['port'] = $matches[0];
            }

            $port['name'] = $device['Name'];
            $port['description'] = $device['Description'];
            $port['id'] = $device['DeviceID'];
            $port['manufacturer'] = $device['Manufacturer'];
            $port['service'] = $device['Service'];

            $ports += $port;
        }

        return $ports;
    }

    hidden [object] $com;

    COM([string] $port, [int] $baud){
        $this.com = new-Object System.IO.Ports.SerialPort $port, $baud, 'None', 8, 'one'
    }

    setTimeout([int] $readTimeout, [int] $writeTimeout){
        $this.com.ReadTimeout = $readTimeout;
        $this.com.WriteTimeout = $writeTimeout;
    }

    setTimeout([int] $timeout){
        $this.com.ReadTimeout = $timeout;
        $this.com.WriteTimeout = $timeout;
    }

    setDtr([bool] $dtr){
        if($dtr){
            $this.com.DtrEnable = "true"
        } else {
            $this.com.DtrEnable = "false"
        }
    }

    [string] getPortName(){
        return $this.com.PortName;
    }

    open(){
        $this.com.open();
    }

    close(){
        if($this.isOpen()){
            $this.com.close();
        }
    }

    [bool] isOpen(){
        return $this.com.isOpen;
    }

    [string] read(){
        return $this.com.ReadLine();
    }

    write([string] $line){
        $this.com.WriteLine($line);
    }
}