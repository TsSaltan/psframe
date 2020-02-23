<# 
 #
 #>

class App {
    hidden [string]        $name;
    hidden [bool]          $single = $false;
    hidden [bool]          $started = $false;
    hidden [ScriptBlock]   $onBeforeStart = {};
    hidden [ScriptBlock]   $onStart = {};
    hidden [ScriptBlock]   $onError = {};
    hidden $lockFile;

    App([string] $name){
        $this.setName($name);
    }

    App(){
        $this.setName($this.getScriptName());
    }

    [string] getScriptPath(){
        return $PSCommandPath;
    }

    [string] getResourcePath(){
        return $this.getParentDir() + '\res';
    }

    [string] getResourcePath([string] $filename){
        return $this.getParentDir() + '\res\' + $filename;
    }

    [string] getScriptName(){
        return (Get-Item $PSCommandPath ).Basename;
    }

    [string] getParentDir(){
        return Split-Path -Parent $PSCommandPath;
    }

    beforeStart([ScriptBlock] $callback){
        $this.onBeforeStart = $callback;
    }

    start([ScriptBlock] $callback){
        $this.onStart = $callback;
    }

    error([ScriptBlock] $callback){
        $this.onError = $callback;
    }

    singleRun([bool] $value){
        $this.single = $value;
    }

    setName([string] $name){
        $pattern = '[^a-zA-Z0-9_]';
        $this.name = $name -replace $pattern, '-';
    }

    launch(){
        $lockPath = $this.getParentDir() + '\' + $this.name.toLower() + '.lock';
        try {
            [Log]::setLogFile($this.getParentDir() + '\' + $this.name);
            [Log]::add("App", "Application '" + $this.name + "' was started", 1);
            [Log]::add("App", "Script path: " + $this.getScriptPath(), 0);
            Invoke-Command -ScriptBlock $this.onBeforeStart;

            if($this.single){
                try {
                    [Log]::add("App", "Lock file: " + $lockPath, 0);
                    $this.lockFile = [System.IO.File]::Open($lockPath, "OpenOrCreate", "Write", "None");
                } catch [System.Management.Automation.MethodInvocationException] {
                    throw "Application already started";
                }
            }

            Invoke-Command -ScriptBlock $this.onStart;
            
            if($this.single){
                $this.lockFile.close();
                [System.IO.File]::Delete($lockPath);
            }

        } catch {
            [Log]::add("App", "Catched exception: " + $_.Exception, 4);
            Invoke-Command -ScriptBlock $this.onError -ArgumentList $_.Exception;
            break;
        } finally {
            [Log]::add("App", "Application finished", 1);
        }
    }
}


