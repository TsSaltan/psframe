<# 
 # PowerShell Framework
 # by tssaltan
 #
 # Required PS version: 3.0
 # Framework version: 1.0.2-dev
 #>
New-Variable -Name 'PSFrameVersion' -Value '1.0.2-dev' -Option Constant

Set-Alias -Name new -Value New-Object
Set-Alias -Name wait -Value Start-Sleep

function dump($object){
    $object | Select-Object -Property *
}

function timestamp(){
    $time = Get-Date -uFormat %s
    $sec,$ms = $time.split(',')
    return $sec;
}

function hash($string, $method){
    return $string | Get-Hash -Algorithm $method
}