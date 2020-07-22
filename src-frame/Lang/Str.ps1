class Str {
    static [string] repeat([string] $string, [int] $num){
        return "$string" * $num
    }

    static [string] hash([string] $string, [string] $method){
        return $string | Get-Hash -Algorithm $method
    }
}