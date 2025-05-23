Param([Parameter(Mandatory=$True, Position=1)][String]$Name,
[Parameter(Mandatory=$True, Position=2)][Alias("Yo")][String]$Greeting)

Write-Host $Greeting $Name