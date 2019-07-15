class Log {
    static [string] $logFile = 'app.log'
    static [bool] $writeFile = $true;
    static [bool] $writeHost = $true;
    static [int] $writeLevel = 0;

    <##
     # Levels
     # 0 - debug
     # 1 - info
     # 2 - notice
     # 3 - warning
     # 4 - error
     #>
    static add([string] $message, [int] $level){
        if($level -gt [Log]::writeLevel){
            $color = 'Gray';
            $type = 'Debug';
            switch ($level) {
                1 { 
                    $color = 'Blue' 
                    $type = 'Info'
                }

                2 { 
                    $color = 'Yellow' 
                    $type = 'Notice'
                }

                3 { 
                    $color = 'Orange' 
                    $type = 'Warning'
                }

                4 { 
                    $color = 'Red' 
                    $type = 'Error'
                }
            }

            if([Log]::writeHost){
                Write-Host $message -ForegroundColor $color
            }

            if([Log]::writeFile){
                $date = Get-Date -uFormat "%Y-%m-%d %H:%M:%S";
                $fmessage = "[$date] [$type] $message";
                [File]::add([Log]::logFile, $fmessage);
            }
        }
    }
}

function log($message){
    [Log]::add($message, 0)
}

function info($message){
    [Log]::add($message, 1)
}

function notice($message){
    [Log]::add($message, 2)
}

function warning($message){
    [Log]::add($message, 3)
}

function error($message){
    [Log]::add($message, 4)
}