class Log {
    static [string] $logFile = 'app.log'
    static [bool] $writeFile = $true;
    static [bool] $writeHost = $true;
    static [int] $writeLevel = -1;

    static setLogFile([string] $filename){
        [Log]::logFile = $filename.toLower() + '.log';
    }

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
            $color = 'White';
            $color = 'DarkGray';
            $type = 'Debug';
            switch ($level) {
                1 { 
                    $color = 'Green' 
                    $type = 'Info'
                }

                2 { 
                    $color = 'Cyan' 
                    $type = 'Notice'
                }

                3 { 
                    $color = 'Yellow' 
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
                $fmessage = "[$date] [$type]`t$message";
                [File]::add([Log]::logFile, $fmessage);
            }
        }
    }

    static add([string] $type, [string] $message, [int] $level){
        [Log]::add("[$type] $message", $level);
    }

    static text([string] $message){
        [Log]::add($message, 0)
    }

    static info([string] $message){
        [Log]::add($message, 1)
    }

    static notice([string] $message){
        [Log]::add($message, 2)
    }

    static warning([string] $message){
        [Log]::add($message, 3)
    }

    static error([string] $message){
        [Log]::add($message, 4)
    }
}

