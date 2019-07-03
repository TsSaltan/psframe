$myAppName = 'hello world';
$app = new-object App($myAppName);
$app.onStart({
    write-host '[1] Hello world!';
    start-sleep 10
    write-host '[1] After 5s';
});




$start = timestamp
[App]::start()
$end = timestamp

write-host ($end-$start) sec