$appTitle = "Demos";

$demoForm = new UIForm;
$demoForm.setTitle($appTitle);

$demoLabel = new UILabel;
$demoLabel.setText("Select demo:");
$demoLabel.setPos(10, 10);
$demoForm.add($demoLabel);

$app = new App;
$app.setName($appTitle);
$app.singleRun($true);
$app.start({
    $startX = 50;
    $startY = 35;
    $formHeight = 100;
    $stepY = 25;

    foreach ($form in [Demo]::demoForms){
        $item = new UIButton;
        $item.setText($form.getTitle());
        $item.on('click', {
            $form.show();
        }.getNewClosure()); # getNewClosure() fix rewrite var
        $item.setPos($startX, $startY);
        $item.setSize(150, $stepY);
        $demoForm.add($item);

        $startY+=$stepY;
        $formHeight+=$stepY;
    }

    $demoForm.setSize(270, $formHeight);
    $demoForm.show();
});

$app.error({
    $alert = new UIAlert($_, '[Error]', 'OK', 'Error');
    $alert.show();
});

$app.launch();