# PowerShell Framework
Version: **2.0-dev**

## Structure and building
Your project may be located at another directory

- Put your project's code at **/src/** directory.
- Put your resources to **/res/** directory.
- For building execute `build` command
- After building your project will be compilled to **/build/** directory.
- Command `build -launch` launch project after building

## Features
### Syntax sugar
#### Adapting static methods
```PowerShell
Class::Method('arg1')
# Will be replaced to 
[Class]::Method('arg1')
```

#### Object constructor
```PowerShell
 $object = new ObjectClassName
# Will be replaced to 
 $object = New-Object ObjectClassName
```

### Forms structure at XML
Form structure (xml/html) format:
```html
<form title="My Form" width="250" height="500" id="testForm">
    <label id='lab' x='5' y='16'>Hello world!</label>
    <button id='btn' x='120' y='150'>ButtonASD</button>
</form>
```

PS code:
```PowerShell
$builder = new UIBuilder;
$builder.loadFile("./res/file.xml");
$builder.build();

$form = ui("testForm")
$form.show();
# form will be showned
```

