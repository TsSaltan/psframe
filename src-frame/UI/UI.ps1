<# 
 #  Graphic user interface 
 #>

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

[System.Windows.Forms.Application]::EnableVisualStyles();


class UICollection {
    hidden static [object] $objects = @{};

    static setObject([string] $id, [object] $object){
        [UICollection]::objects[$id] = $object;
    }

    [object] static getObject([string] $id){
        return [UICollection]::objects[$id];
    }   

    static replaceId([string] $idFrom, [string] $idTo){
        [UICollection]::objects[$idTo] = [UICollection]::objects[$idFrom];
        [UICollection]::objects.PSObject.Properties.Remove($idFrom);
    }
}

function ui($objId){
    return [UICollection]::getObject($objId);
}

<#
 - GUI - 

 UIFont +
 UIIcon +
 
 UIBase +
 - UIParent +
 | - UIForm +
 | - UILayout
 | | - UIHScrollBar
 | | - UIVScrollBar
 | | - UIMenu
 | | | - UIMainMenu
 | | | - UIMenuItem
 | | - UITab
 | | | - UITabControl
 | | | - UITabPage
 | | - UIList
 | | | - UIListView
 | | | - UIListViewItem
 | | - UITree
 | | | - UITreeView

 - UIControl +
 | - UILabel +
 | | - UIButton  +
 | | - UITextBox  +
 | | - UICheckBox + 
 | | - UIRadioButton +

#>
