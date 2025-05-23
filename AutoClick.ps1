Import-Module "C:\Program Files\WindowsPowerShell\Modules\AutoItX\AutoItX.psd1"

Start-Sleep -s 5 
$winHandle = Get-AU3WinHandle -Title $("RuneLite - Impacto_PZ")

$numClicks = 0

while ($numClicks -lt 28){
    Show-AU3WinActivate -WinHandle $winHandle
    #Start-Sleep -s 1
    Invoke-AU3MouseClick -Button "primary" -X 485 -Y 216
    $numClicks++
    Start-Sleep -s 2.525
}