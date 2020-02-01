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
}