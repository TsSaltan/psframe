<# 
 # PowerShell Framework
 # by tssaltan
 #
 # Required PS version: 3.0
 # Framework version: 0.1-dev
 #>

function echo($data){
    Write-host $data
}


function new([string] $className){
    return New-Object $className
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

function getPSFrameVersion