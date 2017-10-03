Out-File -Encoding Ascii -FilePath $res -inputObject "OK!"
Get-Content $req -Raw | Out-File $outputQueueItem