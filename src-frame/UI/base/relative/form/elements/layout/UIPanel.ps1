<#
 # Текст
 #>
class UIPanel : UILabeled {
    UIPanel() {
        $this.constructObject('Panel');
        $this.setRelatives($true, $true);
    }    
}