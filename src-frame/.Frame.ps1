<# 
 # PowerShell Framework
 # by tssaltan
 #
 # Required PS version: 3.0
 # Framework version: 1.2-dev
 #>
New-Variable -Name 'PSFrameVersion' -Value '1.2-dev' -Option Constant

Set-Alias -Name new -Value New-Object
Set-Alias -Name wait -Value Start-Sleep

function dump($object){
    $object | Select-Object -Property *
}

function timestamp(){
    return [Math]::Round((Get-Date).ToFileTime() / 10000000 - 11644473600)
}

function timestamp_ms(){
    return [Math]::Round((Get-Date).ToFileTime() / 10000 - 11644473600000)
}