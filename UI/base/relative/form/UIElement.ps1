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