<##
 # Однострочное поле для ввода текста
 #>
 
class UITextBox: UILabeled {
    UITextBox() {
        $this.constructObject('TextBox');
    }    

    setWordWrap([bool] $value){
        $this.object.WordWrap = $value;
    }
    
    setMultiline([bool] $value){
        $this.object.MultiLine = $value;
    }

    [bool] getMultiline(){
        return $this.object.MultiLine;
    }

    <##
     #
     #  Both (default)      Displays horizontal or vertical scroll bars, or both, only when text exceeds the width or length of the control.
     #  None                Never displays any type of scroll bar.
     #  Horizontal          Displays a horizontal scroll bar only when the text exceeds the width of the control. (For this to occur, the WordWrap property must be set to false.)
     #  Vertical            Displays a vertical scroll bar only when the text exceeds the height of the control.
     #  ForcedHorizontal    Displays a horizontal scroll bar when the WordWrap property is set to false. The scroll bar appears dimmed when text does not exceed the width of the control.
     #  ForcedVertical      Always displays a vertical scroll bar. The scroll bar appears dimmed when text does not exceed the length of the control.
     #  ForcedBoth          Always displays a vertical scrollbar. Displays a horizontal scroll bar when the WordWrap property is set to false. The scroll bars appear grayed when text does not exceed the width or length of the control.
     #>
    setScrollBars([string] $scroll){
        $this.object.ScrollBars = $scroll;
    }
}