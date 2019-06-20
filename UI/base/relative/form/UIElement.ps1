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

    <##
     # Активировано ли перетаскивание объекта
     #>
    hidden [bool] $drag = $false;

    <##
     # Добавлены ли события для управления перетаскиванием
     #>
    hidden [bool] $dragEvents = $false;

    <##
     # Включено ли ограничение для перетаскивания (не дальше родительского элемента)
     #>
    hidden [bool] $dragLimit = $false;

    <##
     # Отступы внутри родителя, если есть ограничение
     #>
    hidden [object] $dragPadding = @{
        top = 0; left = 0; right = 0; bottom = 0
    };

    <##
     # Начато ли перетаскивание
     #>
    hidden [bool] $dragging = $false;

    <##
     # Последняя координата мыши при перетаскивании
     #>
    hidden [object] $dragMouse;


    <##
     # Включить/выключить возможность перетаскивать объект
     #>
    setDraggable([bool] $drag){
        $this.drag = $drag;
        $script:that = $this; # Таким образом можно передать переменные внутрь callback-функции

        if($drag -and $this.dragEvents -eq $false){
            $this.dragEvents = $true;
            $this.on('MouseDown', {
                if($that.drag){
                    $pos = getCursorPos
                    $that.dragging = $true;
                    $that.dragMouse = $pos;
                }
            });

            $this.on('MouseMove', {
                if($that.drag -and $that.dragging){
                    $pos = getCursorPos
                    $currentPos = $that.getPos();
                    
                    if($that.dragLimit -eq $null){
                        $currentX = $currentPos.X + $pos.X - $that.dragMouse.x;
                        $currentY = $currentPos.Y + $pos.Y - $that.dragMouse.y;
                    } else {
                        $parentSizes = $that.getParent().getSize();
                        $currentSizes = $that.getSize();

                        $currentX = [math]::min([math]::max($that.dragPadding.left, $currentPos.x + $pos.x - $that.dragMouse.x), $parentSizes.width - $currentSizes.width - $that.dragPadding.right);
                        $currentY = [math]::min([math]::max($that.dragPadding.top, $currentPos.y + $pos.y - $that.dragMouse.y), $parentSizes.height - $currentSizes.height - $that.dragPadding.bottom);
                    }

                    $that.setPos($currentX, $currentY);
                    $that.dragMouse = $pos;
                }
            });


            $this.on('MouseUp', { 
                if($that.dragging){
                    $that.dragging = $false 
                }
            })
        }
    }

    <##
     # Ограничить перетаскивания родителем (не резрешить перетаскивать за пределы родителя)
     #>
    useParentDragBounds([bool] $limit){
        $this.dragLimit = $limit;
    }

    <##
     # Установить размеры отступов от границ родителя (если перетаскивание ограничено границами родителя)
     #>
    setParentDragPadding([int] $padding){
        $this.dragPadding = @{
            top = $padding; left = $padding; right = $padding; bottom = $padding
        };
    }

    setParentDragPadding([int] $paddingW, [int] $paddingH){
        $this.dragPadding = @{
            top = $paddingH; left = $paddingW; right = $paddingW; bottom = $paddingH
        };
    }

    setParentDragPadding([int] $paddingTop, [int] $paddingRight, [int] $paddingBottom, [int] $paddingLeft){
        $this.dragPadding = @{
            top = $paddingTop; left = $paddingLeft; right = $paddingRight; bottom = $paddingBottom
        };
    }
}