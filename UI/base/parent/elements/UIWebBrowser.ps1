class UIWebBrowser : UIFormElement {
    UIWebBrowser() {
        $this.constructObject('WebBrowser');
    }    

    navigate([string] $url){
        $this.object.navigate($url);
    }

    setUrl([string] $url){
        $this.object.URL = $url;
    }

    setContextMenu([bool] $menu){
        $this.object.isWebBrowserContextMenuEnabled = $menu;
    }
}