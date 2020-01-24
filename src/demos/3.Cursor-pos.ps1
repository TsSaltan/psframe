# Your script's code here

$form = new UIForm;
$form.setTitle('Cursor position');
$form.setSize(300, 150);
$form.setMinimizeBox($false);
$form.setMaximizeBox($false);

$cpLabel = new UILabel;
$cpLabel.setText('Cursor position:');
$cpLabel.setPos(10, 10);
$cpLabel.setAutoSize($true);
$form.add($cpLabel);

[Demo]::add($form);

$form.on('shown', {
    $timer1 = New-Object System.Windows.Forms.Timer
    $timer1.Interval = 100 
    $timer1.add_Tick({
        $pos = [System]::getCursorPos();
            $cpLabel.setText('Cursor position:' + $pos.X + ' x ' + $pos.Y);
    })
    $timer1.Start();
});