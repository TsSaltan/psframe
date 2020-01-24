# Your script's code here

$form = new UIForm;
$form.setTitle('Drag n drop files');
$form.setSize(550, 350);
$form.setMinimizeBox($false);

$label = new UILabel;
$label.setText('Drop files here:');
$label.setPos(10, 10);
$form.add($label);

$dropLabel = new UILabel;
$dropLabel.set('backColor', '#9beaef');
$dropLabel.setPos(10, 50);
$dropLabel.setSize(510, 250);
$dropLabel.setAnchors($true, $true, $true, $true);
$dropLabel.setAutoSize($false);
$dropLabel.setText($PSCommandPath);
$dropLabel.allowDrop($true);
$dropLabel.on('DragOver', {
    #Event Argument: $_ = [System.Windows.Forms.DragEventArgs]
    if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)){
        $_.Effect = 'Copy'
        $dropLabel.set('backColor', '#eefa00');
    }
    else {
        $_.Effect = 'None'
        $dropLabel.set('backColor', '#9beaef');
    }
});

$dropLabel.on('DragDrop', {
    #Event Argument: $_ = [System.Windows.Forms.DragEventArgs]
    $dropLabel.set('backColor', '#4bffaa');
    [string[]] $files = [string[]]$_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
    if ($files) {
        $paths = '';
        foreach($file in $files){
            $paths += $file + "`n";
        }
        
        $dropLabel.setText($paths);
    }
});


$form.add($dropLabel);
[Demo]::add($form);