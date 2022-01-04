<# 
 # PowerShell Framework
 # by tssaltan
 #
 # Required PS version: 3.0
 #>
New-Variable -Name 'PSFrameVersion' -Value '2.0-dev' -Option Constant

Set-Alias -Name new -Value New-Object
Set-Alias -Name wait -Value Start-Sleep

function dump($object){
    return $object | Format-Table | Out-String
}

function timestamp(){
    return [Math]::Round((Get-Date).ToFileTime() / 10000000 - 11644473600)
}

function timestamp_ms(){
    return [Math]::Round((Get-Date).ToFileTime() / 10000 - 11644473600000)
}