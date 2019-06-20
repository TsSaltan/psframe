class UIFont {
    [string] $face      = 'Arial';
    [int]    $size      = 10;
    [bool]   $bold      = $false;
    [bool]   $italic    = $false;
    [bool]   $strikeout = $false;
    [bool]   $underline = $false;

    UIFont([string] $face){
        $this.face = $face;
    }

    UIFont([string] $face, [int] $size){
        $this.face = $face;
        $this.size = $size;
    }

    setFace([string] $face){
        $this.face = $face;
    }

    setSize([int] $size){
        $this.size = $size;
    }

    setBold([bool] $bold){
        $this.bold = $bold;
    }

    setItalic([bool] $italic){
        $this.italic = $italic;
    }

    setStrikeout([bool] $strikeout){
        $this.strikeout = $strikeout;
    }

    setUnderline([bool] $underline){
        $this.underline = $underline;
    }

    [string] getFont(){
        $styles = @();
        if($this.bold){ $styles += 'Bold' }
        if($this.italic){ $styles += 'Italic' }
        if($this.strikeout){ $styles += 'Strikeout' }
        if($this.underline){ $styles += 'Underline' }

        return "{0},{1},style={2}" -f $this.face, $this.size, [system.String]::Join(", ", $styles);
    }
}