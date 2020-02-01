class Timer {
    [object] $timer;
    [string] $id;
    [ScriptBlock] $callback;

    hidden static [int] $timers = 0;

    hidden setId(){
        $this.id = "timer_{0}" -f [Timer]::timers;
        [Timer]::timers++;
    }

    Timer() {
        $this.timer = New-Object System.Windows.Forms.Timer;
        $this.setId();
    }  

    Timer([ScriptBlock] $callback, [int] $ms) {
        $this.timer = New-Object System.Windows.Forms.Timer;
        $this.setId();
        $this.setInterval($ms);
        $this.setCallback($callback);
        $this.start();
    }

    [string] getId(){
        return $this.id;
    }

    setInterval([int] $ms){
        $this.timer.interval = $ms;
    }

    setCallback([ScriptBlock] $callback){ 
        $this.timer.add_Tick($callback);
    }

    start(){
        $this.timer.start();
    }

    stop(){
        $this.timer.stop();
    }
}