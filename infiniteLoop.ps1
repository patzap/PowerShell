$wshell = New-Object -ComObject WScript.Shell

while($true){
    $wshell.SendKeys("+({F10})")
    Start-Sleep -Seconds 3
}