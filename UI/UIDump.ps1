class UIDump {
    [UIBase] $object;
    [xml] $xml;

    UIDump([UIBase] $object){
        $this.object = $object;
        $this.xml = New-Object System.Xml.XmlDocument;
        $dec = $this.xml.CreateXmlDeclaration("1.0", "UTF-8", $null);
        $this.xml.AppendChild($dec) | Out-Null ;
    }

    # [string] dumpXml(){
    dumpXml(){
        $text = $this.getObjectXml($this.object);

    }

    getObjectXml([UIBase] $object){
        $root = $this.xml.createNode("element", $object.getObjectType(), $null);
    }

    # @todo
}