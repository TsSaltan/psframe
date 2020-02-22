<#
 # Кнопка
 #>
 
class UIButton: UILabeled {
    UIButton() {
        $this.constructObject('Button');
    } 

    UIButton([string] $text) {
        $this.constructObject('Button');
        $this.setText($text);
    }    
}