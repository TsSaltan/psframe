class Demo {
    static hidden [object] $demoForms = @();

    static add([UIForm] $form){
        [Demo]::demoForms += $form
    }
}