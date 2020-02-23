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
    $global:mouseTimer = new Timer({
        $pos = [System]::getCursorPos();
        $cpLabel.setText('Cursor position:' + $pos.X + ' x ' + $pos.Y);
    }, 50);
});

$form.on('FormClosed', {
    $mouseTimer.stop();
});