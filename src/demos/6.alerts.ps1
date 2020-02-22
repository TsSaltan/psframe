$alertsForm = new UIForm;
$alertsForm.setTitle('Alerts');

$abtn1 = new UIButton('Type: None; Button: YesNo');
$abtn1.setPos(5, 5);
$abtn1.setAutosize($true);
$abtn1.on('click', {
    write-host([UIAlert]::message( "Hello world!", "Alert title"));
});
$alertsForm.add($abtn1);


$abtn3 = new UIButton('Type: Warning; Button: OK');
$abtn3.setPos(5, 55);
$abtn3.setAutosize($true);
$abtn3.on('click', {
    write-host([UIAlert]::warning( "Hello world!", "Alert title", "OK"));
});
$alertsForm.add($abtn3);

$abtn4 = new UIButton('Type: Error; Button: OKCancel');
$abtn4.setPos(5, 55+25);
$abtn4.setAutosize($true);
$abtn4.on('click', {
    write-host([UIAlert]::error( "Hello world!", "Alert title", "OKCancel"));
});
$alertsForm.add($abtn4);

$abtn2 = new UIButton('Type: info; Button: YesNoCancel');
$abtn2.setPos(5, 30);
$abtn2.setAutosize($true);
$abtn2.on('click', {
    write-host([UIAlert]::info( "Hello world!", "Alert title", "YesNoCancel"));
});
$alertsForm.add($abtn2);

$abtn5 = new UIButton('Type: question; Button: YesNoCancel');
$abtn5.setPos(5, 105);
$abtn5.setAutosize($true);
$abtn5.on('click', {
    write-host([UIAlert]::question( "Hello world!", "Alert title", "YesNoCancel"));
});
$alertsForm.add($abtn5);

$abtn6 = new UIButton('Type: input');
$abtn6.setPos(5, 130);
$abtn6.setAutosize($true);
$abtn6.on('click', {
    write-host([UIAlert]::input( "Hello world!", "Alert title"));
});
$alertsForm.add($abtn6);

[Demo]::add($alertsForm);
