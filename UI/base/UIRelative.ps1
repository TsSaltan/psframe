<##
 # Функционал для родительских элементов,
 # которые могут содержать в себе дочерние элементы
 #>
 
<# abstract #> class UIRelative : UIBase {
    UIRelative() {
        $type = $this.getType();
        if ($type -eq [UIRelative]){
            throw ("[AbstractError] Abstract class '$type' must be inherited");
        }
    }

    setRelatives([bool] $parent, [bool] $children){
        $this.setParentRole($parent);
        $this.setChildrenRole($children);
    }

    <#
     # Возможность объекта быть родителем
     #>
    hidden [bool] $parentRole = $false;

    setParentRole([bool] $value){
        $this.parentRole = $value;
    }

    hidden [UIBase[]] $children = @();

    add([UIBase] $children){
        if(!$this.parentRole){
            throw "[RelativeError] Object #" + $this.id + " is not a parent!";
        }

        $this.children += $children;
        $cObj = $children.getObject();
        $this.object.controls.addRange(@( $cObj ));
        $children.setParent($this);
    }

    [UIBase[]] getChildren(){
        if(!$this.parentRole){
            throw "[RelativeError] Object #" + $this.id + " is not a parent!";
        }

        return $this.children;
    }

    <#
     # Возможность объекта быть "ребёнком"
     #>
    hidden [bool] $childrenRole = $true;
    setChildrenRole([bool] $value){
        $this.childrenRole = $value;
    }

    hidden [UIBase] $parent;

    setParent([UIBase] $parent){
        if(!$this.childrenRole){
            throw "[RelativeError] Object #" + $this.id + " is not a children!";
        }
        $this.parent = $parent;
    }

    [UIBase] getParent(){
        if(!$this.childrenRole){
            throw "[RelativeError] Object #" + $this.id + " is not a children!";
        }
        return $this.parent;
    }
}