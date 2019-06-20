class UIIcon {
    hidden [object] $icon ;
    
    UIIcon([string] $file){
        $ext = [System.IO.Path]::GetExtension($file);
        if($ext -eq ".ico"){
            $this.icon = New-Object System.Drawing.Icon($file);
        } else {
            $this.icon = UIExtractIcon($file);
        }
    }

    [object] getIcon(){
        return $this.object;
    }
}

function UIExtractIcon([string] $path){
    Add-Type -AssemblyName System.Drawing;
    return [System.Drawing.Icon]::ExtractAssociatedIcon($file);
}