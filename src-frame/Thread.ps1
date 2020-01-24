class Thread {
    static [int] $threadNum = 1;

    hidden [ScriptBlock] $func;
    hidden [string] $name;

    Thread([ScriptBlock] $func, [string] $name){
        $this.func = $func;
        $this.name = $name;
    }

    Thread([ScriptBlock] $func){
        $this.func = $func;
        $this.name = "Thread-" + [Thread]::threadNum;
        [Thread]::threadNum++;
    }

    start(){
        Start-Job -Name $this.name -ScriptBlock $this.func
    }

    start([ScriptBlock] $dataReader){
        $this.start()
        $wait = $true;
        do {
            $job = Get-Job -Name $this.name
            $data = $job | Receive-Job
            $data
            if($data.length -gt 0){
                Invoke-Command $dataReader -ArgumentList $data
            }
            if($job.State -ne "Running"){
                $wait = $false;
            } else {
                start-sleep -Milliseconds 250
            }
        } while ($wait);
    }

    stop(){
        Stop-Job -Name $this.name
    }
}