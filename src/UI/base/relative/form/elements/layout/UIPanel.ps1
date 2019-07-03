<#
 # Текст
 #>
class UIPanel : UILabeled {
    UIPanel() {
        $this.constructObject('GroupBox');
        $this.setRelatives($true, $true);
    }    
}