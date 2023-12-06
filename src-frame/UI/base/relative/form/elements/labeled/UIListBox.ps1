<#
 # 
 #>
 
class UIListBox : UILabeled {

    UIListBox() {
        $this.constructObject('ListBox');
        $this.setRelatives($false, $true);
    }   

    addItem([string] $text){
        $this.object.Items.Add($text);
    }

    setAllowSelection([bool] $selection){
        $this.object.AllowSelection = $selection;
    }

    [string] getSelectedItem(){
        return $this.object.SelectedItem;
    }

    scrollBottom(){
        $visibleitems = $this.object.items.count - ($this.object.clientsize.height / $this.object.itemheight) + 1;
        $this.object.topIndex = ($visibleitems,0 | Measure -Max).Maximum;
        # $this.object.topIndex = $selection;
    }

}