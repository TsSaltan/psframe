$form = new UIForm;
$form.setTitle('COM devices');

$devBox = new UILabel;
$devBox.setSize(500, 500);
$devBox.setPos(10, 10);

$form.add($devBox);

[Demo]::add($form);

$form.on('shown', {
    $ports = "";  
    $devices = [COM]::getPorts();
    foreach ($device in $devices){
        $ports += "[{0}]`n" -f $device['port'];
        $ports += "- {0}`n" -f $device['name'];
        $ports += "- {0}`n" -f $device['description'];
        $ports += "- {0}`n" -f $device['manufacturer'];
        $ports += "`n";
    }
    
    $devBox.setText($ports); 
});