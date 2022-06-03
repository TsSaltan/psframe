class UIBuilder {
    hidden [object] $html;
    hidden [object] $xml;

    static fromFile([string] $file){
        $builder = new UIBuilder;
        $builder.loadFile($file);
        $builder.build();
    }

    UIBuilder() {
        $this.html = new-object -com "HTMLFile";   
    }

    loadFile([string] $formFile){
        #$content = File::read($formFile);
        #$this.html.IHTMLDocument2_write($content);
        $this.xml = Select-Xml -Path $formFile -xpath "/";
    }
    
    loadString([string] $xml){
        $this.html.IHTMLDocument2_write($xml);
    }


    build() {
        #Write-host( 'xml');
       # Write-host( $this.xml );
        $this.xml | ForEach-Object { 

            #Write-host( $_.Node);
            $type = ($_.Node| Get-member)[0].TypeName
            #Write-host('$_.Node is ' + $type );
            $this.createUIObject($_.Node);

            #$_.Node | gm -MemberType property | select Name # Node name = form
            # Write-host( $_.Node | Format-Table | Out-String );
        }
    }

    [object] createUIObject([object] $object){
        $objType = ($object | Get-member)[0].TypeName;
        if($objType -eq "System.Xml.XmlDocument"){
            $nodeProps = ($object | gm -MemberType property | select Name)
            $nodeName = $nodeProps.Name
            $node = $object.$nodeName
        }
        elseif($objType -eq 'System.Xml.XmlElement'){
            $node = $object
            $nodeName = $node.Name
        } else {
            return @{}
        }

        $ui = new-object "UI$nodeName"

        #Write-host('ObjectName: ' + $nodeName);
        #Write-host('Attributes: ');

        $node.Attributes | Foreach-Object {
            $key = $_.toString();
            $value = $node.$key
            #Write-host "$key = $value"
            $ui.set($key, $value);
            # Write-host($_ + ' = ' + $node.Attributes.$_);
        }

        if($node.HasChildNodes){
            #Write-host('Childs: ');
            #Write-Host ($node.ChildNodes | Format-Table | Out-String)

            $node.ChildNodes | Foreach-Object {
                $key = $_.toString();
                $value = $node.$key

                #write-host "* [child-item] $key :"
                #Write-Host ($_ | Format-Table | Out-String)

                if($key -eq "#text"){
                    $ui.setText($_.InnerText);
                }
                elseif($key -ne "#whitespace"){                
                    $child = $this.createUIObject($_);
                    $ui.add($child);
                }
            }
        }

        return $ui;
    }
}