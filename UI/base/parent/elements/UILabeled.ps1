<#
 # Все объекты, сдержащие текст, должны наследоваться от этого объекта
 #>
class UILabeled : UIFormElement {

    <# abstract #> UILabeled() {
        $type = $this.getType();
        if ($type -eq [UILabeled]){
            throw ("[$type] Abstract class must be inherited");
        }
    }  

    setText([string] $text){
        $this.object.text = $text;
    }

    [string] getText(){
        return $this.object.text;
    }

    setFont([string] $font){
        $this.object.font = $font;
    }

    setFont([UIFont] $font){
        $this.object.font = $font.getFont();
    }

    setTextColor([string] $color){
        $this.object.foreColor = $color;
    }
}