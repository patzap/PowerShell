$filetext = 'C:\Users\Administrator\Documents\text.txt'

$testPath = Test-Path $filetext

$Date = Get-Date

if ($testPath -eq 0){
    
    New-Item $filetext 

   "Hello World" > $filetext

    $Date >> $filetext

}

else{

    $Date >> $filetext
    
}