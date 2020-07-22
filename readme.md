# PowerShell Framework
Version: **1.0-dev**

## Directories structure
Framework code located at **/src-frame/** directory.
Put your project's code located at **/src/** directory. *(Remove demo scripts)*
Put your resources to **/res/** directory.
After building your project will be compilled to **/build/** directory.

## Features
Adapting static methods syntax:
```PowerShell
Class::Method('arg1')
# Will be replaced to 
[Class]::Method('arg1')
```