<#
 # Все объекты, сдержащие текст, должны наследоваться от этого объекта
 #>
 
<# abstract #> class UILabeled : UIElement {

    UILabeled() {
        $type = $this.getType();
        if ($type -eq [UILabeled]){
            throw "[AbstractError] Abstract class '$type' must be inherited";
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