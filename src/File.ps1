class File {
    static [bool] exists([string] $path){
        return Test-Path -Path $path;
    }

    static [string] read([string] $path){
        return Get-Content -Path $path -Raw;
    }

    static write([string] $path, $data){
        $data | Set-Content -Path $Path;
    }

    static add([string] $path, $data){
        $data | Add-Content -Path $Path;
    }
<#
    static readJson([string] $path){
        return [File]::read($path) | ConvertFrom-Json;
    }

    static writeJson([string] $path, $data){
        [File]::add($path, ($data | ConvertTo-Json));
    }#>
}