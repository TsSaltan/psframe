# PowerShell Framework
Version: **1.0-dev**

## Directories structure
Framework code located at **/src-frame/** directory.
Put your project's code located at **/src/** directory. *(Remove demo scripts)*
Put your resources to **/res/** directory.
After building your project will be compilled to **/build/** directory.

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