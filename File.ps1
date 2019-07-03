class File {
    static [bool] exists([string] $path){
        return Test-Path -Path $path;
    }

    static [string] read([string] $path){
        return Get-Content -Path $path;
    }


    static write([string] $path, $data){
        $stream = [System.IO.StreamWriter] $path
        $stream.write($data)
        $stream.close()
    }

    write([string] $path, $data){
        $stream = [System.IO.StreamWriter] $path
        $stream.write($data)
        $stream.close()
    }
}


# @todo
function fput($path, $data){
    return Add-Content $path $data
}