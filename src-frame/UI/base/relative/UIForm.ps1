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

    [string] getTitle(){
        return $this.object.text;
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

    <##
     # Отображать [все] кнопки свернуть/развернуть/закрыть
     #>
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