<##
 # Изображение
 #>
 
class UIPictureBox: UILabeled {
    UIPictureBox() {
        $this.constructObject('PictureBox');
    }    

    loadImage([string] $path){
        $this.object.load($path);
    }

    <#
     # @param string $mode
     #              AutoSize - The PictureBox is sized equal to the size of the image that it contains.
     #              CenterImage - The image is displayed in the center if the PictureBox is larger than the image. If the image is larger than the PictureBox, the picture is placed in the center of the PictureBox and the outside edges are clipped.
     #              Normal - The image is placed in the upper-left corner of the PictureBox. The image is clipped if it is larger than the PictureBox it is contained in.
     #              StretchImage - The image within the PictureBox is stretched or shrunk to fit the size of the PictureBox.
     #              Zoom - The size of the image is increased or decreased maintaining the size ratio.
     #>
    setSizeMode([string] $mode){
        $this.object.sizeMode = $mode;
    }

    [string] getSizeMode(){
        return $this.object.sizeMode;
    }
}