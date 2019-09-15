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
        $lockPath = $this.getParentDir() + '\' + $this.name + '.lock';
        try {
            [Log]::setLogFile($this.getParentDir() + '\' + $this.name);
            info("[App] Application '" + $this.name + "' starting...");
            info("[App] Script path: " + $this.getScriptPath() );
            Invoke-Command -ScriptBlock $this.onBeforeStart;

            if($this.single){
                try {
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
            # $_.Exception.Message
            error("[App] Catched exception: " + $_.Exception);
            Invoke-Command -ScriptBlock $this.onError -ArgumentList $_.Exception;
            break;
        } finally {
            info("Application '" + $this.name + "' finished.");
        }
    }
}


