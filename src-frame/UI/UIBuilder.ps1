class UIBuilder {
    hidden [object] $html;

    UIBuilder([string] $formFile){
        $this.html = new-object -com "HTMLFile";
        $content = File::read($formFile);
        $this.html.IHTMLDocument2_write($content);

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
                Write-host "[$className]::set(" $attrib.name ", " $attrib.value " )"
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