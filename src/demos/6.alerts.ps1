$alertsForm = new UIForm;
$alertsForm.setAutoSize($true);
$alertsForm.setTitle('Alerts & notifies');

# alerts 

$abtn1 = new UIButton('Alert | Type: None; Button: YesNo');
$abtn1.setPos(5, 5);
$abtn1.setAutosize($true);
$abtn1.on('click', {
    write-host([UIAlert]::message( "Hello world!", "Alert title"));
});
$alertsForm.add($abtn1);

$abtn3 = new UIButton('Alert | Type: Warning; Button: OK');
$abtn3.setPos(5, 55);
$abtn3.setAutosize($true);
$abtn3.on('click', {
    write-host([UIAlert]::warn( "Hello world!", "Alert title", "OK"));
});
$alertsForm.add($abtn3);

$abtn4 = new UIButton('Alert | Type: Error; Button: OKCancel');
$abtn4.setPos(5, 55+25);
$abtn4.setAutosize($true);
$abtn4.on('click', {
    write-host([UIAlert]::error( "Hello world!", "Alert title", "OKCancel"));
});
$alertsForm.add($abtn4);

$abtn2 = new UIButton('Alert | Type: Information; Button: YesNoCancel');
$abtn2.setPos(5, 30);
$abtn2.setAutosize($true);
$abtn2.on('click', {
    write-host([UIAlert]::info( "Hello world!", "Alert title", "YesNoCancel"));
});
$alertsForm.add($abtn2);

$abtn5 = new UIButton('Alert | Type: Question; Button: YesNoCancel');
$abtn5.setPos(5, 105);
$abtn5.setAutosize($true);
$abtn5.on('click', {
    write-host([UIAlert]::question( "Hello world!", "Alert title", "YesNoCancel"));
});
$alertsForm.add($abtn5);

$abtn6 = new UIButton('Alert | Type: Prompt');
$abtn6.setPos(5, 130);
$abtn6.setAutosize($true);
$abtn6.on('click', {
    write-host([UIAlert]::input( "Hello world!", "Alert title", "Default value"));
});
$alertsForm.add($abtn6);

# notifies 

$nbtn1 = new UIButton('Notify | Type: None;');
$nbtn1.setPos(270, 5);
$nbtn1.setAutosize($true);
$nbtn1.on('click', {
    [UINotify]::message("Hello world!", "Notify title");
});
$alertsForm.add($nbtn1);

$nbtn2 = new UIButton('Notify | Type: Warn;');
$nbtn2.setPos(270, 5+25);
$nbtn2.setAutosize($true);
$nbtn2.on('click', {
    [UINotify]::warn("Hello world!", "Notify title");
});
$alertsForm.add($nbtn2);

$nbtn3 = new UIButton('Notify | Type: Info;');
$nbtn3.setPos(270, 5+25*2);
$nbtn3.setAutosize($true);
$nbtn3.on('click', {
    [UINotify]::info("Hello world!", "Notify title");
});
$alertsForm.add($nbtn3);

$nbtn4 = new UIButton('Notify | Type: Error;');
$nbtn4.setPos(270, 5+25*3);
$nbtn4.setAutosize($true);
$nbtn4.on('click', {
    [UINotify]::error("Hello world!", "Notify title");
});
$alertsForm.add($nbtn4);

[Demo]::add($alertsForm);
