<# 
 # PowerShell Framework
 # by tssaltan
 #
 # Required PS version: 3.0
 # Framework version: 1.0-dev
 #>
New-Variable -Name 'PSFrameVersion' -Value '1.0-dev' -Option Constant

function echo($data){
    Write-host $data
}

function dump($object){
    $object | Select-Object -Property *
}

function new([string] $className){
    return New-Object $className
}

function timestamp(){
    $time = Get-Date -uFormat %s
    $sec,$ms = $time.split(',')
    return $sec;
}

function getCursorPos(){
    Add-Type -TypeDefinition @'
        using System.Windows.Forms;
        using System.Drawing;
        public class UICursor {
            public static Point getPos(){
               return Cursor.Position;                }
        }
'@  -ReferencedAssemblies 'System.Windows.Forms.dll','System.Drawing.dll'    

    return [UICursor]::getPos()
}

function hash($string, $method){
    return $string | Get-Hash -Algorithm $method
}