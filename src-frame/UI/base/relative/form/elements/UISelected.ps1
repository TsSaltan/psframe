<#
 # Все объекты, сдержащие возможность выбора, должны наследоваться от этого объекта
 #>

<# abstract #> class UISelected : UILabeled {

    UISelected() {
        $type = $this.getType();
        if ($type -eq [UISelected]){
            throw "[AbstractError] Abstract class '$type' must be inherited";
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