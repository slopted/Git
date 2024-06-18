'On Error Resume Next 

Dim sRuta, sText
Dim objfso, oFolder, oSubFolder
Dim rFile, wFile, sExtension
Dim sDate, sTime, sName
Dim sLine, fFolder, Line

sRuta = InputBox("Ingresa la ruta a escanear","Escaneo de strings SQL","c:\inetpub")
sText = InputBox("Ingresa el texto a buscar","Escaneo de strings SQL","larra_dom")

sTime = Replace(Time(),":","")
sTime = Split(sTime)(0)
sDate = Replace(Date(),"/","")
sName = "C:\Temp\" & sDate & "_" & sTime & ".txt"

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set wFile = objfso.OpenTextFile(sName, 2, True)

Call ShowSubfolders(sRuta)

Sub ShowSubFolders(fFolder)
    Set objFolder = objFSO.GetFolder(fFolder)
    Set colFiles = objFolder.Files

    For Each objFile in colFiles
    	sExtension = UCase(objFSO.GetExtensionName(objFile.name))
        
        If sExtension = "CS" Or sExtension = "ASP"  Or sExtension = "DLL" Or sExtension = "TXT" Or sExtension = "CONFIG" Then
                        
            Set rFile = objfso.OpenTextFile(objFile.Path, 1)            
	  		sLine = 1
	  		
	  		Do while rFile.AtEndOfStream <> True
	  			Line = rFile.ReadLine()	  			 			
				
				If InStr(1,Line,sText,vbTextCompare) > 0 Then
					wFile.WriteLine objFile.Path & vbTab & sLine
				End If
				sLine = sLine + 1
			Loop
			rFile.Close
			Set rFile = Nothing
            
        End If
    Next

    For Each Subfolder in objFolder.SubFolders
        ShowSubFolders(Subfolder)
    Next
   
End Sub