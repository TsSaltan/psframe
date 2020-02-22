<# 
 #  Graphic user interface 
 #>

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

[System.Windows.Forms.Application]::EnableVisualStyles();



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
