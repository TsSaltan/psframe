class UIBuilder {
    hidden [object] $html;

    UIBuilder() {
        $this.html = new-object -com "HTMLFile";   
    }

    loadFile([string] $formFile){
        $content = File::read($formFile);
        $this.html.IHTMLDocument2_write($content);
    }
    
    loadString([string] $xml){
        $this.html.IHTMLDocument2_write($xml);
    }


    build() {
        $this.html.forms | Foreach-object {
            $this.createUIObject($_);
        }
    }

    [object] createUIObject([object] $object){
        $className = "UI{0}" -f $object.nodeName
        $ui = new-object "$className"

        $object.attributes | Foreach-Object {
            $attrib = $_;
            if($attrib.specified){
                $ui.set($attrib.name, $attrib.value);
            }
        }

        $object.children | Foreach-Object {
            if($_.nodeName -eq "BODY"){
                $_.children | Foreach-Object {
                    $child = $this.createUIObject($_);
                    $ui.add($child);
                }
            }
        }

        if($object.textContent.length -gt 0){
            $ui.set('text', $object.textContent);
        }

        return $ui;
    }
}