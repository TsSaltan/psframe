<# 
 #
 #>

class App {
    static hidden [HashTable] $apps = @{};
    hidden [string] $name;

    App([string] $name){
        $this.name = $name;

    
        [App]::apps[$this.name] = @{
            isStarted = $false;
            onStart = $null;
            singleRun = $false;
        };
    }

    onStart([ScriptBlock] $callback){
        [App]::apps[$this.name]['onStart'] = $callback;
    }

    singleRun([bool] $value){
        [App]::apps[$this.name]['singleRun'] = $value;
    }


    [string] static start(){
        foreach($key in [App]::apps.Keys){
            if([App]::apps[$key]['onStart'] -ne $null){
                $callback = [App]::apps[$key]['onStart'];
                $single = [App]::apps[$key]['singleRun'];
                $id = hash($key, 'MD5');

                if($single){
                    $tmpFile = '.lock';
                }

                Write-host "[Job] Starting $key ..."
                Start-Job -scriptblock $callback
            }
        }

        Get-Job | Wait-Job 
        return Get-Job | Receive-Job 
    }
}


