$CsvVMList = Import-csv "VMlist.csv"

$file = Get-Content "VMlist.csv" | Out-Null

if ($file -ne $null){

    $CsvVMList | ForEach-Object {
        foreach ($property in $_.[PSCustomObject]){
            $names = $property.value
            if ($file -like $Names){
                $hostname = $CsvVMList | ?{$_.VMName -eq $File} | Select -Property Hostname -ExpandProperty "Hostname"
                $vmname = $CsvVMList | ?{$_.VMName -eq $File} | Select -Property Hostname -ExpandProperty "VMName"

                Invoke-Command -ComputerName $Hostname -ArgumentList $VMName -ScriptBlock {
                    param($VMName)
                    Start-VM -Name $VMName
                }
            }
        }
    }
}