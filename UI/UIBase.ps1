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
            throw ("[$type] Abstract class must be inherited");
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