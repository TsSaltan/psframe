# Your script's code here

$form = new UIForm;
$form.setTitle('meow');
$form.setSize(700, 500);

$font = [UIFont]::new('Arial', 10);
$font.setBold($true);


$label = new UILabel;
$label.setText('Drag me!');
$label.set('backColor', '#ff2222');
$label.setPos(100, 150);
# $label.set('AllowDrop', $true);
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

# $checkBox.setWidth(250);

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

# dump($checkBox.object);

$dropLabel = new UILabel;
$dropLabel.setText('Drop on me');
$dropLabel.set('backColor', '#9beaef');
$dropLabel.setPos(10, 100);
$dropLabel.setSize(100, 200);
$dropLabel.setAnchor('Top, Left');
$dropLabel.setAutoSize($false);
$dropLabel.setText($PSCommandPath);

$dropLabel.allowDrop($true);
$dropLabel.on('DragOver', {
    #Event Argument: $_ = [System.Windows.Forms.DragEventArgs]
    if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)){
        $_.Effect = 'Copy'
    }
    else {
        $_.Effect = 'None'
    }
});

$dropLabel.on('DragDrop', {
    #Event Argument: $_ = [System.Windows.Forms.DragEventArgs]
    
    [string[]] $files = [string[]]$_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
    if ($files) {
        $dropLabel.setText($files[0]);
    }
    
});


$form.add($dropLabel);


$app = new App;
$app.setName("My first application");
$app.singleRun($true);
$app.start({
    $form.show();
});
$app.error({
    $result = [System.Windows.Forms.MessageBox]::Show($_, 'Application error', 'Ok', 'Error');
});

$app.launch();