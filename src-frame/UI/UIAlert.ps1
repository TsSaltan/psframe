class UIAlert {
    <##
     # @url https://docs.microsoft.com/en-us/dotnet/api/system.windows.messageboximage?view=netframework-4.8
     # Asterisk   64  The message box contains a symbol consisting of a lowercase letter i in a circle.
     # Error   16  The message box contains a symbol consisting of white X in a circle with a red background.
     # Exclamation 48  The message box contains a symbol consisting of an exclamation point in a triangle with a yellow background.
     # Hand    16  The message box contains a symbol consisting of a white X in a circle with a red background.
     # Information 64  The message box contains a symbol consisting of a lowercase letter i in a circle.
     # None    0   The message box contains no symbols.
     # Question    32  
     # The message box contains a symbol consisting of a question mark in a circle. The question mark message icon is no longer recommended because it does not clearly represent a specific type of message and because the phrasing of a message as a question could apply to any message type. In addition, users can confuse the question mark symbol with a help information symbol. Therefore, do not use this question mark symbol in your message boxes. The system continues to support its inclusion only for backward compatibility.
     # Stop    16  The message box contains a symbol consisting of white X in a circle with a red background.
     # Warning 48  The message box contains a symbol consisting of an exclamation point in a triangle with a yellow background.
     #>
    hidden [string] $type = 'None';

    <##
     # @url https://docs.microsoft.com/en-us/dotnet/api/system.windows.messageboxbutton?view=netframework-4.8
     # OK   0   The message box displays an OK button.
     # OKCancel    1   The message box displays OK and Cancel buttons.
     # YesNo   4   The message box displays Yes and No buttons.
     # YesNoCancel 3   The message box displays Yes, No, and Cancel buttons.
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
        $this.buttons = $buttons;
    }

    UIAlert([string] $message, [string] $title, [string] $buttons, [string] $type){
        $this.message = $message;
        $this.title = $title;
        $this.buttons = $buttons;
        $this.type = $type;
    }

    [string] show(){
        return alert $this.message $this.title $this.buttons $this.type
    }

    static [string] message([string] $message, [string] $title, [string] $buttons){
        $alert = new UIAlert($message, $title, $buttons, 'None');
        return $alert.show();
    }
    
    static [string] message([string] $message, [string] $title){
        return [UIAlert]::message($message, $title, 'OK');
    }

    static [string] message([string] $message){
        return [UIAlert]::message($message, 'Message', 'OK');
    }

    static [string] error([string] $message, [string] $title, [string] $buttons){
        $alert = new UIAlert($message, $title, $buttons, 'Error');
        return $alert.show();
    }

    static [string] error([string] $message, [string] $title){
        return [UIAlert]::message($message, $title, 'OK');
    }

    static [string] error([string] $message){
        return [UIAlert]::message($message, 'Message', 'OK');
    }

    <# @todo aliases for next functions without arguments #>
    static [string] warning([string] $message, [string] $title = 'Message', [string] $buttons = 'OK'){
        $alert = new UIAlert($message, $title, $buttons, 'Warning');
        return $alert.show();
    }

    static [string] warn([string] $message, [string] $title = 'Message', [string] $buttons = 'OK'){
        $alert = new UIAlert($message, $title, $buttons, 'Warning');
        return $alert.show();
    }

    static [string] information([string] $message, [string] $title = 'Message', [string] $buttons = 'OK'){
        $alert = new UIAlert($message, $title, $buttons, 'Information');
        return $alert.show();
    }

    static [string] info([string] $message, [string] $title = 'Message', [string] $buttons = 'OK'){
        $alert = new UIAlert($message, $title, $buttons, 'Information');
        return $alert.show();
    }

    static [string] question([string] $message, [string] $title = 'Message', [string] $buttons = 'OK'){
        $alert = new UIAlert($message, $title, $buttons, 'Question');
        return $alert.show();
    }

    static [string] input([string] $message, [string] $title = 'Message', [string] $value = ''){
        return prompt $message $title $value;
    }
}

function alert([string] $message, [string] $title = 'Message', [string] $buttons = 'OK', [string] $type = 'None'){
    return [System.Windows.Forms.MessageBox]::Show($message, $title, $buttons, $type);
}

function prompt([string] $message, [string] $title = 'Message', [string] $value = ''){
    return [Microsoft.VisualBasic.Interaction]::InputBox($message, $title, $value);
}