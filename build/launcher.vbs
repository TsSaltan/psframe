Set objShell = CreateObject("Wscript.Shell")
strPath = Wscript.ScriptFullName
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(strPath)
strFolder = objFSO.GetParentFolderName(objFile) 
' strPath = "powershell.exe -ExecutionPolicy UnRestricted -File " & strFolder & "\\script.ps1"
strPath = "powershell.exe -ExecutionPolicy UnRestricted -windowstyle hidden -File " & strFolder & "\\script.ps1"
objShell.Run strPath, 4, true