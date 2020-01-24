Add-Type -TypeDefinition @'
        using System.Windows.Forms;
        using System.Drawing;
        public class __SystemCursor {
            public Point getPos(){
               return Cursor.Position;                }
        }
'@  -ReferencedAssemblies 'System.Windows.Forms.dll','System.Drawing.dll'   

class System {
    
    <##
     # Return <X=xpos, Y=ypos>
     #>
    static [array] getCursorPos(){
        $s = New-Object __SystemCursor
        return $s.getPos()
    }
}
