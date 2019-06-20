# Your script's code here



Write-host "before start ... /// "



$form = new UIForm;
$form.setTitle('meow');
$form.setSize(700, 500);

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
#$form.add($label);

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

$panel = new UIPanel
$panel.setPos(150, 50);
$panel.setAutoSize($false);
$panel.setSize(500, 300);
$panel.setText('Hello World!');
$panel.add($label);
$label.useParentDragBounds($true);
$label.setParentDragPadding(15, 10, 10, 10);
$form.add($panel);

$select = new UISelectBox;
$select.setPos(5, 50);
$select.addItems(@('a', 'b','c','MeOw'));
$select.setSelectedIndex(0);
$select.setBoxHeight(150);

$form.add($select);

var_dump($select.object);
$form.show();