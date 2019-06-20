<#
 # Все объекты, сдержащие текст, должны наследоваться от этого объекта
 #>
class UISelected : UILabeled {

    <# abstract #> UISelected() {
        $type = $this.getType();
        if ($type -eq [UISelected]){
            throw ("[$type] Abstract class must be inherited");
        }
    }  

    setChecked([bool] $value){
        $this.object.checked = $value;
    } 

    [bool] getChecked(){
        return $this.object.checked;
    } 

    [bool] isChecked(){
        return $this.getChecked();
    } 

}