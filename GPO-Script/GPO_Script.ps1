Param(
    [Parameter(Mandatory=$true)]
    [string] $domainname,
    [Parameter(Mandatory=$true)]
    [string] $domaincontroller, 
    [Parameter(Mandatory=$true)]
    [string] $gui_gpo
)


Function domain_summary{

    Write-Output "---Domain Summary---"

    Get-Addomain | ForEach-Object {" Name: " + $_.Name + "`n", "Forest: " + $_.Forest + "`n", 
    "DNSRoot: " + $_.DNSRoot + "`n", "Domain Mode: " + $_.DomainMode + "`n",
     "Infrastructure Master: " + $_.InfrastructureMaster + "`n"}

    Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name, DistinguishedName -A
}


if ($domainname -ne "tidas.net" -And $domaincontroller -ne "AD-TIDAS-VM"){

    Write-Output "Error. Incorrect Domain, you typed" + $domainname " + Incorrect Domain Controller, you typed " + $domaincontroller
}

elseif ($domainname -ne "tidas.net"){

    Write-Output "Error. Incorrect Domain, you typed" + $domainname

}

elseif ($domaincontroller -ne "AD-TIDAS-VM"){
    
    Write-Output "Incorrect Domain Controller, you typed " + $domaincontroller

}
else{
    
    Write-Host("`n Checking if GPO exists..... `n")

    $ps_gpo = Get-GPO -name "No Shutdown PS" 2> $null

    if ($ps_gpo.DisplayName -eq "No Shutdown PS"){
        
        Write-Host "This GPO already exists"

        domain_summary
    
    }
    else {

        domain_summary

        $gpoGuid = $gui_gpo.Id.ToString()

        $registryPolPath = "\\$domainController\sysvol\$domainName\Policies\{$gpoGuid}\User"
        Get-ChildItem -Path $registryPolPath
        $regPolPath = Join-Path -Path $registryPolPath -ChildPath 'registry.pol'
        Parse-PolFile -Path $regPolPath
        $regKeyInfo = Parse-PolFile -Path $regPolPath
        $gponame = "No Shutdown PS"
        New-GPO -Name $gponame -Comment "Powershell Version of No Shutdown"

        $gpRegParams = @{
        Name       = $gponame
        Key        = "HKCU\$($regKeyInfo.KeyName)"
        ValueName  = $regKeyInfo.ValueName
        Type       = $regKeyInfo.ValueType
        Value      = $regKeyInfo.ValueData
        }

        Set-GPRegistryValue @gpRegParams 
        $ou = 'Test2OU'
        $domainDn = (Get-ADDomain).DistinguishedName
        $ouDn = "OU=$ou,$domainDn"
        New-GPLink -Name $gpoName -Target $ouDn -LinkEnabled 'Yes'

        Write-Host $gponame + " has been created"
        
    }  
    
}




