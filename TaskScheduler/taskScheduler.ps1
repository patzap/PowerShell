$trigger = New-ScheduledTaskTrigger -Once -At 4:40 -RepetitionInterval (New-TimeSpan -Minutes 5)
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "C:\Users\Administrator\Documents\helloText.ps1"

Register-ScheduledTask -TaskName "Test" -Action $action -Trigger $trigger -RunLevel Highest -Force 