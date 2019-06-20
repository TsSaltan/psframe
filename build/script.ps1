# Script builder 
 
# [Builder] Import frame ; 
<# 
 # PowerShell Framework
 # by tssaltan
 #
 # Required PS version: 3.0
 # Framework version: 0.1-dev
 #>

function echo($data){
    Write-host $data
}

function new([string] $className){
    return New-Object $className
}

function getCursorPos(){
    Add-Type -TypeDefinition @'
        using System.Windows.Forms;
        using System.Drawing;
        public class UICursor {
            public static Point getPos(){
               return Cursor.Position;                }
        }
'@  -ReferencedAssemblies 'System.Windows.Forms.dll','System.Drawing.dll'    

    return [UICursor]::getPos()
} 
# [Builder] Import UI ; 
<# 
 #  Graphic user interface 
 #>

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

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
 
# [Builder] Import UIBase ; 
<##
 # Базовый функционал для всех элементов
 #>

<# abstract #> class UIBase {
    hidden [object] $object;
    static [int] $itemCounter = 0;
    [string] $id;

    constructObject([string] $objectName){
        Add-Type -AssemblyName System.Windows.Forms;
        $this.object = New-Object System.Windows.Forms.$objectName;
        $number = ++[UIBase]::itemCounter
        $this.setId("$objectName{0}" -f $number)
    }

    UIBase() {
        $type = $this.getType();
        if ($type -eq [UIBase]){
            throw "[AbstractError] Abstract class '$type' must be inherited";
        }
    }

    [string] getId(){
        return $this.id;
    }

    setId([string] $id){
        $this.id = $id;
    }

    set([string] $key, $value){
         if($key -eq "id"){
            $this.setId($value);
        } else {
            $this.object.$key = $value;
        }
    }

    [object] get([string] $key){
        if($key -eq "id"){
            return $this.getId();
        }
        return $this.object.$key;
    }

    setWidth([int] $width){
        $this.object.width = $width;
    }

    setHeight([int] $height){
        $this.object.height = $height;
    }

    setSize([int] $width, [int] $height){
        $this.setWidth($width);
        $this.setHeight($height);
    }

    setAutoSize([bool] $size){
        $this.object.autoSize = $size;
    }

    setPos([int] $x, [int] $y){
        $this.object.location = New-Object System.Drawing.Point($x, $y);
    }

    [object] getPos(){
        return $this.object.location;
    }

    setAnchors([bool] $top, [bool] $right, [bool] $bottom, [bool] $left){
        $anchors = @();
        if($top){$anchors += 'Top';}
        if($right){ $anchors += 'Right';}
        if($bottom){ $anchors += 'Bottom';}
        if($left){ $anchors += 'Left';}
        $this.object.anchor = [system.String]::Join(", ", $anchors);
    }

    setAnchor([string] $anchor){
        $this.object.anchor = $anchor;
    }

    setBackgroundColor([string] $color){
        $this.object.backColor = $color;
    }

    <##
     # - AppStarting
     # - Arrow
     # - Cross
     # - Default
     # - Hand
     # - Help
     # - HSplit
     # - IBeam
     # - No
     # - NoMove2D
     # - NoMoveHoriz
     # - NoMoveVert
     # - PanEast
     # - PanNE
     # - PanNorth
     # - PanNW
     # - PanSE
     # - PanSouth
     # - PanSW
     # - PanWest
     # - SizeAll
     # - SizeNESW
     # - SizeNS
     # - SizeNWSE
     # - SizeWE
     # - UpArrow
     # - VSplit
     # - WaitCursor
     #>
    setCursor([string] $cursor){
        $this.object.cursor = $cursor;
    }

    # hidden $callbacks = @{};

    on([string] $eventName, [object] $callback){
        $method = "Add_{0}" -f $eventName
        $this.object.$method($callback)
            <#
        $this.callbacks.$method = $callback


        # Таким образом можно передать переменные внутрь callback-функции
        $script:that = $this;

        $this.object.$method({
            #write-host $_
            Write-Host ($_ | Format-List | Out-String)
            # Invoke-Command -ScriptBlock $that -ArgumentList $that
        });#>
    }

    [object] getObject() {
        return $this.object;
    }

    [string] getClassName() {
        $names = $this.object.AccessibilityObject.Owner.toString() -split ','
        return $names[0];
    }

    [string] getObjectType(){
        $names = $this.getClassName() -split 'Forms.'
        return $names[1];
    }
} 
# [Builder] Import UIDump ; 
class UIDump {
    [UIBase] $object;
    [xml] $xml;

    UIDump([UIBase] $object){
        $this.object = $object;
        $this.xml = New-Object System.Xml.XmlDocument;
        $dec = $this.xml.CreateXmlDeclaration("1.0", "UTF-8", $null);
        $this.xml.AppendChild($dec) | Out-Null ;
    }

    # [string] dumpXml(){
    dumpXml(){
        $text = $this.getObjectXml($this.object);

    }

    getObjectXml([UIBase] $object){
        $root = $this.xml.createNode("element", $object.getObjectType(), $null);
    }

    # @todo
} 
# [Builder] Import UIFont ; 
class UIFont {
    [string] $face      = 'Arial';
    [int]    $size      = 10;
    [bool]   $bold      = $false;
    [bool]   $italic    = $false;
    [bool]   $strikeout = $false;
    [bool]   $underline = $false;

    UIFont([string] $face){
        $this.face = $face;
    }

    UIFont([string] $face, [int] $size){
        $this.face = $face;
        $this.size = $size;
    }

    setFace([string] $face){
        $this.face = $face;
    }

    setSize([int] $size){
        $this.size = $size;
    }

    setBold([bool] $bold){
        $this.bold = $bold;
    }

    setItalic([bool] $italic){
        $this.italic = $italic;
    }

    setStrikeout([bool] $strikeout){
        $this.strikeout = $strikeout;
    }

    setUnderline([bool] $underline){
        $this.underline = $underline;
    }

    [string] getFont(){
        $styles = @();
        if($this.bold){ $styles += 'Bold' }
        if($this.italic){ $styles += 'Italic' }
        if($this.strikeout){ $styles += 'Strikeout' }
        if($this.underline){ $styles += 'Underline' }

        return "{0},{1},style={2}" -f $this.face, $this.size, [system.String]::Join(", ", $styles);
    }
} 
# [Builder] Import UIIcon ; 
class UIIcon {
    hidden [object] $icon ;
    
    UIIcon([string] $file){
        $ext = [System.IO.Path]::GetExtension($file);
        if($ext -eq ".ico"){
            $this.icon = New-Object System.Drawing.Icon($file);
        } else {
            $this.icon = UIExtractIcon($file);
        }
    }

    [object] getIcon(){
        return $this.object;
    }
}

function UIExtractIcon([string] $path){
    Add-Type -AssemblyName System.Drawing;
    return [System.Drawing.Icon]::ExtractAssociatedIcon($file);
} 
# [Builder] Import UIRelative ; 
<##
 # Функционал для родительских элементов,
 # которые могут содержать в себе дочерние элементы
 #>
 
<# abstract #> class UIRelative : UIBase {
    UIRelative() {
        $type = $this.getType();
        if ($type -eq [UIRelative]){
            throw "[AbstractError] Abstract class '$type' must be inherited";
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
# [Builder] Import UIForm ; 
<##
 # Графическая форма
 #>
 
class UIForm : UIRelative {

    UIForm() {
        $this.constructObject('Form');
        $this.setRelatives($true, $false);
    }

    setTitle([string] $title){
        $this.object.text = $title;
    }

    setMaxSize([int] $width, [int] $height){
        $this.object.maximumSize = New-Object System.Drawing.Size($width, $height);
    }

    setMinSize([int] $width, [int] $height){
        $this.object.minimumSize = New-Object System.Drawing.Size($width, $height);
    }

    <##
     # Режим автоматического размера:
     # - GrowOnly - разрешает ужимать размер формы, если в этой области нет элементов управления, 
     # но не меньше, чем указанов параметрах Width и Height
     #
     # - GrowAndShrink —  разрешает ужимать размер формы, если в этой области нет элементов управления, 
     # игнорируя параметры Width и Height 
     # но не меньше чем MinimumSize, при этом форма не будет растягиваться по требованию пользователя, но форму можно будет развернуть на всё окно.
     #>
    setAutoSizeMode([string] $mode){
        $this.object.autoSizeMode = $mode;
    }

    <##
     # Изменить стиль рамки окна
     # - Fixed3D — Фиксированная трехмерная граница. Форме запрещено менять размер, однако её можно развернуть на весь экран или свернуть.
     # - FixedDialog — Толстая фиксированная граница в диалоговом окне-стиля. Запрещено менять размер. Однако иконка в левой верхней части окна не отображается.
     # - FixedSingle — фиксированная, одностроковая граница.
     # - FixedToolWindow — Граница окна инструментов, которое нельзя изменить. Окно инструментов не отображается в панели задач или в окно, которое появляется при нажатии пользователем клавиши ALT+TAB
     # - None — Форма без рамки. Она не умеет изменять размер, и свёртываться в панель задач, но её можно развернуть.
     # - Sizable — Граница с изменяемыми размерами. Данная форма может изменять размер, разворачиваться и сворачиваться в панель задач.
     # - SizableToolWindow — Окно может изменять размер окна, разворачивать окно на всё окно, сворачивать в панель задач. Однако кнопки MaximizeBox и MinimizeBox не отображаются. Не отображается в панели задач однако окно появляется при нажатии клавиш ALT+TAB.
     #>
    setBorderStyle([string] $style){
        $this.object.formBorderStyle  = $style;
    }

    setControlBox([bool] $view){
        $this.object.controlBox = $view;
    }

    setMaximizeBox([bool] $view){
        if($view){
            $this.setControlBox($view);
        }
        $this.object.maximizeBox = $view;
    }

    setMinimizeBox([bool] $view){
        if($view){
            $this.setControlBox($view);
        }
        $this.object.minimizeBox = $view;
    }

    setResizeGrip([bool] $view){
        if($view){
            $this.object.sizeGripStyle = 'Show';
        } else {
            $this.object.sizeGripStyle = 'Hide';
        }
    }

    setIcon([bool] $icon){
        $this.object.showIcon = $icon;
    }

    setIcon([string] $path){
        $this.object.showIcon = $true;
        $icon = New-Object UIIcon($path);
        $this.object.icon = $icon.getIcon();
    }

    setIcon([UIIcon] $icon){
        $this.object.showIcon = $true;
        $this.object.icon = $icon.getIcon();
    }

    setOpacity([double] $opacity){
        $this.object.opacity = $opacity;
    }

    <##
     # Состояние окна
     # - Maximized
     # - Minimized
     # - Normal
     #>
    setWindowState([string] $state){
        $this.object.windowState = $state;
    }

    minimize(){
        $this.setWindowState('Minimized');
    }

    maximize(){
        $this.setWindowState('Maximized');
    }

    normal(){
        $this.setWindowState('Normal');
    }

    setTaskbarIcon([bool] $show){
        $this.object.showInTaskbar = $show;
    }

    setAlwaysOnTop([bool] $top){
        $this.object.topMost  = $top;
    }

    setVisible([bool] $visible){
        $this.object.visible  = $visible;
    }

    show(){
        $this.object.showDialog();
    }
} 
# [Builder] Import UIElement ; 
<##
 # Базовый элемент, расположенные на форме
 # Управление расположением объектов на форме, растягивание и т.д.
 ##>

<# abstract #> class UIElement : UIRelative {

    UIElement() {
        $type = $this.getType();
        if ($type -eq [UIElement]){
            throw "[AbstractError] Abstract class '$type' must be inherited";
        }
    }

    <#
     # Drug features
     #>
    hidden [bool] $drag;
    hidden [bool] $dragEvents = $false;
    hidden [bool] $dragging = $false;
    hidden [int] $mouseDragX = -1;
    hidden [int] $mouseDragY = -1;

    setDraggable([bool] $drag){
        $this.drag = $drag;
        # Таким образом можно передать переменные внутрь callback-функции
        $script:that = $this;
        if($drag -and $this.dragEvents -eq $false){
            $this.dragEvents = $true;
            $this.on('MouseDown', {
                $pos = getCursorPos
                if($that.drag){
                    # Write-host "[DOWN !]";
                    $that.dragging = $true;
                    $that.mouseDragX = $pos.X
                    $that.mouseDragY = $pos.Y
                }
            });

            $this.on('MouseMove', {
                if($that.drag -and $that.dragging){
                    $pos = getCursorPos
                    $currentPos = $that.getPos()
                    $that.setPos($currentPos.X + $pos.X - $that.mouseDragX, $currentPos.Y + $pos.Y - $that.mouseDragY)
                    
                    $that.mouseDragX = $pos.X
                    $that.mouseDragY = $pos.Y
                }
            });


            $this.on('MouseUp', { 
                if($that.dragging){
                    # Write-host "[UP !]";
                    $that.dragging = $false 
                }
            })
        }
    }
} 
# [Builder] Import UILabeled ; 
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
# [Builder] Import UISelected ; 
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
# [Builder] Import UIWebBrowser ; 
<#
 # Web-браузер (IE)
 #>

class UIWebBrowser : UIElement {
    UIWebBrowser() {
        $this.constructObject('WebBrowser');
    }    

    navigate([string] $url){
        $this.object.navigate($url);
    }

    setUrl([string] $url){
        $this.object.URL = $url;
    }

    setContextMenu([bool] $menu){
        $this.object.isWebBrowserContextMenuEnabled = $menu;
    }
} 
# [Builder] Import UIButton ; 
<#
 # Кнопка
 #>
 
class UIButton: UILabeled {
    UIButton() {
        $this.constructObject('Button');
    }    
} 
# [Builder] Import UICheckbox ; 
<#
 # Выбор галочкой
 #>
class UICheckBox : UISelected {
    UICheckBox() {
        $this.constructObject('CheckBox');
    }
} 
# [Builder] Import UILabel ; 
<#
 # Текст
 #>
 
class UILabel : UILabeled {
    UILabel() {
        $this.constructObject('Label');
    }    
} 
# [Builder] Import UIRadioButton ; 
class UIRadioButton : UISelected {
    UIRadioButton() {
        $this.constructObject('RadioButton');
    }
} 
# [Builder] Import UITextBox ; 
<##
 # Однострочное поле для ввода текста
 #>
 
class UITextBox: UILabeled {
    UITextBox() {
        $this.constructObject('TextBox');
    }    
} 
# [Builder] Import UIPanel ; 
<#
 # Текст
 #>
class UIPanel : UILabeled {
    UILabel() {
        $this.constructObject('Label');
    }    
} 
 
# [Builder] Import index file ; 
 
# Your script's code here



Write-host "before start ... /// "



$form = new UIForm;
$form.setTitle('meow');
$form.setSize(700, 500);
# $form.setIcon("E:\Downloads\anki-2.1.9-windows.exe");

$font = [UIFont]::new('Arial', 10);
$font.setBold($true);


$label = new UILabel;
$label.setText('Drag me!');
$label.set('backColor', '#ff2222');
$label.setPos(100, 150);
$label.set('AllowDrop', $true);
$label.setSize(100, 50);
$label.setAnchor('Top, Left');
# $label.setAnchors($true, $true, $false, $false);
$label.setAutoSize($false);
$label.setFont($font);
$form.add($label);

$checkBox = new UICheckbox;
$checkBox.setText('Dragging');
$checkBox.on('click', {
    if($checkBox.isChecked()){
        $label.setDraggable($true);
        $label.setCursor('SizeAll');
        $label.set('backColor', '#22aa22');
    } else {
        $label.setDraggable($false);
        $label.setCursor('Arrow');
        $label.set('backColor', '#ff2222');
    }
});
$checkBox.setPos(10, 25);
$form.add($checkBox);

$form.show();