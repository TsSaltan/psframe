class File {
    static [bool] exists([string] $path){
        return Test-Path -Path $path;
    }

    static [string] read([string] $path){
        return Get-Content -Path $path -Raw;
    }

    static write([string] $path, $data){
        [File]::write($path, $data, $true)
    }

    static write([string] $path, $data, [bool] $overwrite){
        if($overwrite){
            $data | Set-Content -Path $Path
        } else {
            $data | Add-Content -Path $Path
        }
    }
}