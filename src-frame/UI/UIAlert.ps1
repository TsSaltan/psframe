class UIAlert {
    <##
     # @url https://docs.microsoft.com/en-us/dotnet/api/system.windows.messageboximage?view=netframework-4.8
     # None    
     # Error
     # Information
     # Question    
     # Warning 
     # Prompt (prompt type using only OKCancel buttons)
     #>
    hidden [string] $type = 'None';

    <##
     # @url https://docs.microsoft.com/en-us/dotnet/api/system.windows.messageboxbutton?view=netframework-4.8
     # OK   
     # OKCancel  
     # YesNo  
     # YesNoCancel
     #>
    hidden [string] $buttons = 'OK';

    hidden [string] $message = $null;
    hidden [string] $title = $null;

    UIAlert([string] $message){
        $this.message = $message;
    }

    UIAlert([string] $message, [string] $title){
        $this.message = $message;
        $this.title = $title;
    }

    UIAlert([string] $message, [string] $title, [string] $buttons){
        $this.message = $message;
        $this.title = $title;
        if($buttons -eq 'Prompt' -or $buttons -eq 'prompt'){
            $this.type = 'Prompt';
            $this.buttons = 'OKCancel';
        } else {            
            $this.buttons = $buttons;
        }
    }

    UIAlert([string] $message, [string] $title, [string] $buttons, [string] $type){
        $this.message = $message;
        $this.title = $title;
        $this.buttons = $buttons;
        $this.type = $type;
    }

    [string] show([string] $defValue){
        if($this.type -eq 'Prompt'){
            return prompt $this.message $this.title $defValue;
        } else {
            return alert $this.message $this.title $this.buttons $this.type;
        }
    }

    [string] show(){
        return $this.show($null);
    }

    static [string] message([string] $message, [string] $title, [string] $buttons){
        $alert = new UIAlert($message, $title, $buttons, 'None');
        return $alert.show();
    }
    
    static [string] message([string] $message, [string] $title){
        $alert = new UIAlert($message, $title, 'OK', 'None');
        return $alert.show();
    }

    static [string] message([string] $message){
        $alert = new UIAlert($message, 'Message', 'OK', 'None');
        return $alert.show();
    }

    static [string] error([string] $message, [string] $title, [string] $buttons){
        $alert = new UIAlert($message, $title, $buttons, 'Error');
        return $alert.show();
    }

    static [string] error([string] $message, [string] $title){
        $alert = new UIAlert($message, $title, 'OK', 'Error');
        return $alert.show();
    }

    static [string] error([string] $message){
        $alert = new UIAlert($message, 'Error', 'OK', 'Error');
        return $alert.show();
    }

    static [string] warn([string] $message, [string] $title, [string] $buttons){
        $alert = new UIAlert($message, $title, $buttons, 'Warning');
        return $alert.show();
    }

    static [string] warn([string] $message, [string] $title){
        $alert = new UIAlert($message, $title, 'OK', 'Warning');
        return $alert.show();
    }

    static [string] warn([string] $message){
        $alert = new UIAlert($message, 'Warning', 'OK', 'Warning');
        return $alert.show();
    }

    static [string] info([string] $message, [string] $title, [string] $buttons){
        $alert = new UIAlert($message, $title, $buttons, 'Information');
        return $alert.show();
    }

    static [string] info([string] $message, [string] $title){
        $alert = new UIAlert($message, $title, 'OK', 'Information');
        return $alert.show();
    }

    static [string] info([string] $message){
        $alert = new UIAlert($message, 'Information', 'OK', 'Information');
        return $alert.show();
    }

    static [string] question([string] $message, [string] $title, [string] $buttons){
        $alert = new UIAlert($message, $title, $buttons, 'Question');
        return $alert.show();
    }

    static [string] question([string] $message, [string] $title){
        $alert = new UIAlert($message, $title, 'OK', 'Question');
        return $alert.show();
    }

    static [string] question([string] $message){
        $alert = new UIAlert($message, 'Question', 'OK', 'Question');
        return $alert.show();
    }

    static [string] input([string] $message, [string] $title, [string] $value){
        $alert = new UIAlert($message, $title, 'OK', 'Prompt');
        return $alert.show($value);
    }

    static [string] input([string] $message, [string] $title){
        $alert = new UIAlert($message, $title, 'OK', 'Prompt');
        return $alert.show();
    }

    static [string] input([string] $message){
        $alert = new UIAlert($message, 'Prompt', 'OK', 'Prompt');
        return $alert.show();
    }
}

function alert([string] $message, [string] $title = 'Message', [string] $buttons = 'OK', [string] $type = 'None'){
    return [System.Windows.Forms.MessageBox]::Show($message, $title, $buttons, $type);
}

function prompt([string] $message, [string] $title = 'Message', [string] $value = ''){
    return [Microsoft.VisualBasic.Interaction]::InputBox($message, $title, $value);
}