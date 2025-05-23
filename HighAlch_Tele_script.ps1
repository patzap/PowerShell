Import-Module "C:\Program Files\WindowsPowerShell\Modules\AutoItX\AutoItX.psd1"

Start-Sleep -s 5 
$winHandle = Get-AU3WinHandle -Title $("RuneLite - Impacto_PZ")

# test on Runelite client
if ($winHandle -ne $null){

    Show-AU3WinActivate -WinHandle $winHandle
    Start-Sleep -s 1
    Invoke-AU3MouseClick -Button "primary" -X 573 -Y 466
}

# user input item numbers

# iterate each number user input

    # click on red staff
    # click spellbook
    # click high alchemy 
    # click item
    # click inventory
    # click white staff
    # click teleport

