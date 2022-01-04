class UIBuilder {
    hidden [object] $html;

    static fromFile([string] $file){
        $builder = new UIBuilder;
        $builder.loadFile($file);
        $builder.build();
    }

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
        #Log::debug('Creating forms');
        $this.html.forms | Foreach-object {
            #Write-host($local:obj.nodeName + " id: " + $local:obj.getAttribute('id'));
            $this.createUIObject($_);
        }
    }

    [object] createUIObject([object] $object){
        $className = "UI{0}" -f $object.nodeName
        #Log::debug("Create object [$className] id:" + $object.getAttribute('id'));
        $ui = new-object "$className"
        
        $object.attributes | Foreach-Object {
            $attrib = $_;
            if($attrib.specified){
                #Log::debug("[" + $ui.getObjectType() + "]." + $attrib.name + " = " + $attrib.value);
                $ui.set($attrib.name, $attrib.value);
            }
        }
        
        #Log::debug("Text content for [$className] id:" + $object.getAttribute('id') + " = " + $object.textContent + " (" + $object.textContent.length + ")");
        if($object.textContent.length -gt 0){
            #Log::debug("[" + $ui.getObjectType() + "].text = "+ $object.textContent);
            $ui.set('text', $object.textContent);
        } 

        #Log::debug("Finding childs for [$className] id:" + $object.getAttribute('id') + ", count:" + $object.children.length);
        $object.children | Foreach-Object {
            if($_.nodeName -eq "BODY"){
                $_.children | Foreach-Object {
                    $child = $this.createUIObject($_);
                    #Log::debug("[" + $ui.getObjectType() + "].addBody([" + $child.getObjectType() + "] id: " + $child.get('id') + ")");
                    $ui.add($child);
                }
            } else {
                $child = $this.createUIObject($_);
                #Log::debug("[" + $ui.getObjectType() + "].add([" + $child.getObjectType() + "] id: " + $child.get('id') + ")");
                $ui.add($child);
            }
        }

        return $ui;
    }
}