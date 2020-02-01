$form = new UIForm;
$form.setTitle('Animated resource image');
$form.setSize(420, 360);
$form.setMinimizeBox($false);
$form.setMaximizeBox($false);
$form.setBackgroundColor('#c4ebe8');

$preloader = new UIPictureBox;
$preloader.setPos(10, 10);
$preloader.setSize(400, 300);
#$preloader.setAutoSize($true);
$preloader.loadImage('res/preloader.gif'); # 400 x 300 px
$preloader.setAnchors($true, $true, $true, $true);

$form.add($preloader);

[Demo]::add($form);

$form.on('shown', {
    $global:sizeTimer = new-object Timer({
        $size = $form.getSize();
        $form.setTitle('[' + $size.width + 'x' + $size.height + '] Animate resource image');
    }, 150);
});

$form.on('FormClosed', {
    $sizeTimer.stop();
});