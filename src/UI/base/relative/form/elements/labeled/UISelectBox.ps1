<##
 # После с выпадающими вариантами
 #>
 
class UISelectBox: UILabeled {
    UISelectBox() {
        $this.constructObject('ComboBox');
        # $this.setRelatives($true, $true);
    }    

    addItems([array] $items){
        foreach ($item in $items) {
            $this.addItem($item.toString());
        }
    }

    addItem([string] $item){
        $this.object.items.add($item);
    }

    [object] getItems(){
        return $this.object.items;
    }

    [string] getSelectedItem(){
        return $this.object.selectedText;
    }

    setSelectedIndex([int] $index){
        $this.object.selectedIndex = $index;
    }

    [int] getSelectedIndex(){
        return $this.object.selectedIndex;
    }

    setBoxHeight([int] $height){
        $this.object.DropDownHeight = $height;
    }

    setDroppedDown([bool] $value){
        $this.object.droppedDown = $value;
    }
}