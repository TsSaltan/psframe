<#
 # Notify types: Error, Info, None, Warning
 #>
class UINotify {
    hidden [object] $notify;

    hidden __createObject([string] $message, [string] $title, [UIIcon] $icon, [string] $type){
        $this.notify = New-Object System.Windows.Forms.NotifyIcon ;
        $this.notify.Icon = $icon.getIcon();
        $this.notify.BalloonTipIcon = $type;
        $this.notify.BalloonTipText = $message;
        $this.notify.BalloonTipTitle = $title;
    }

    [object] getObject(){
        return $this.notify;   
    }

    UINotify([string] $message, [string] $title, [UIIcon] $icon, [string] $type){
        $this.__createObject($message, $title, $icon, $type);
    }

    UINotify([string] $message, [string] $title, [UIIcon] $icon){
        $this.__createObject($message, $title, $icon, 'None');
    }

    UINotify([string] $message, [string] $title){
        $this.__createObject($message, $title, [UIIcon]::getDefault(), 'None');
    }

    show([int] $msec){
        $this.notify.Visible = $true
        $this.notify.ShowBalloonTip($msec);
    }

    show(){
        $this.show(5000);
    }

    hide(){
        $this.notify.dispose();
    }

    static [object] message([string] $message, [string] $title, [UIIcon] $icon){
        $trayNotify = new UINotify($message, [string] $title, [UIIcon] $icon, 'None');
        $trayNotify.show();
        return $trayNotify;
    }

    static [object] message([string] $message, [string] $title){
        $trayNotify = new UINotify($message, [string] $title, [UIIcon]::getDefault(), 'None');
        $trayNotify.show();
        return $trayNotify;
    }

    static [object] warn([string] $message, [string] $title, [UIIcon] $icon){
        $trayNotify = new UINotify($message, [string] $title, [UIIcon] $icon, 'Warning');
        $trayNotify.show();
        return $trayNotify;
    }

    static [object] warn([string] $message, [string] $title){
        $trayNotify = new UINotify($message, [string] $title, [UIIcon]::getDefault(), 'Warning');
        $trayNotify.show();
        return $trayNotify;
    }

    static [object] info([string] $message, [string] $title, [UIIcon] $icon){
        $trayNotify = new UINotify($message, [string] $title, [UIIcon] $icon, 'Info');
        $trayNotify.show();
        return $trayNotify;
    }

    static [object] info([string] $message, [string] $title){
        $trayNotify = new UINotify($message, [string] $title, [UIIcon]::getDefault(), 'Info');
        $trayNotify.show();
        return $trayNotify;
    }

    static [object] error([string] $message, [string] $title, [UIIcon] $icon){
        $trayNotify = new UINotify($message, [string] $title, [UIIcon] $icon, 'Error');
        $trayNotify.show();
        return $trayNotify;
    }

    static [object] error([string] $message, [string] $title){
        $trayNotify = new UINotify($message, [string] $title, [UIIcon]::getDefault(), 'Error');
        $trayNotify.show();
        return $trayNotify;
    }
}