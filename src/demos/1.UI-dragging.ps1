# Your script's code here

$form = new UIForm;
$form.setTitle('UI draggable elements');
$form.setSize(520, 400);
$form.setResizeGrip($false);
$form.setBorderStyle('FixedDialog');
$form.setMaximizeBox($false);
$form.setMinimizeBox($false);

$font = [UIFont]::new('Arial', 10);
$font.setBold($true);

# Draggable element
# For enable dragging use
# $label.set('AllowDrop', $true);

$label = new UILabel;
$label.setText('Cannot drag');
$label.set('backColor', '#ff2222');
$label.setPos(20, 20);
$label.setSize(100, 50);
$label.setAnchor('Top, Left');
$label.setAutoSize($false);
$label.setFont($font);
$label.useParentDragBounds($true);
$label.setParentDragPadding(15, 10, 10, 10);

$checkBox = new UICheckbox;
$checkBox.setText('Dragging');
$checkBox.on('click', {
    if($checkBox.isChecked()){
        $label.setDraggable($true);
        $label.setCursor('SizeAll');
        $label.set('backColor', '#22aa22');
        $label.setText('Drag me!');
    } else {
        $label.setDraggable($false);
        $label.setCursor('Arrow');
        $label.set('backColor', '#ff2222');
        $label.setText('Cannot drag');
    }
}.getNewClosure());

$checkBox.setPos(10, 10);
$form.add($checkBox);

$panel = new UIPanel;
$panel.setPos(10, 50);
$panel.setAutoSize($false);
$panel.setSize(500, 300);
$panel.setText('Drag area');
$panel.add($label);

$form.add($panel);

[Demo]::add($form);