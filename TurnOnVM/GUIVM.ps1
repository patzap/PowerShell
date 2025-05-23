[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$Form = New-Object System.Windows.Forms.Form
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$Form.Text = "Turn On VM"
$Form.Size = New-Object System.Drawing.Size(850, 750)
$Form.StartPosition = "CenterScreen"
$Form.BackgroundImageLayout = "Zoom"
$Form.MinimizeBox = $true
$Form.MaximizeBox = $false
$Form.WindowState = "Normal"
$Form.SizeGripStyle = "Hide"
$Icon = [system.drawing.icon]::ExtractAssociatedIcon($PSHOME + "\powershell.exe")
$Form.Icon = $Icon

$Label = New-Object System.Windows.Forms.Label
$LabelFont = New-Object System.Drawing.Font("Calibri", 20,[System.Drawing.FontStyle]::Bold)
$Label.Font = $LabelFont
$Label.Text = "Turn on VM"
$Label.AutoSize = $true
$Label.Location = New-Object System.Drawing.Size(325,40)
$Form.Controls.Add($Label)

$groupbox = New-Object System.Windows.Forms.GroupBox
$groupbox.Location = New-Object System.Drawing.Size(50,115)
$groupbox.size = New-Object System.Drawing.Size(750,550)
$groupboxfont = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Bold)
$groupbox.Font = $groupboxfont
$groupbox.text = "Click on list VM to turn on: "
$Form.Controls.Add($groupbox)

$OkButton = New-Object System.Windows.Forms.Button
$OkButton.Location = New-Object System.Drawing.Point(50,450)
$OkButton.size = New-Object System.Drawing.Size(100,50)
$OkButton.Text = "OK"
$OkButton.DialogResult = [System.Windows.Form.DialogResult]::OK
$groupbox.Controls.Add($OkButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(600,450)
$CancelButton.Size = New-Object System.Drawing.Size(100,50)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$groupbox.Controls.Add($CancelButton)

$listbox = New-Object System.Windows.Forms.ListBox
$listbox.Location = New-Object System.Drawing.Point(70,40)
$listbox.Size = New-Object System.Drawing.Size(600,40)
$listBox.Height = 400

$names = Get-Content "vm_list.txt"

foreach ($name in $names){
    [void] $listbox.Items.Add($item)
}
$groupbox.Controls.Add($listbox)

$result = $Form.ShowDialog()

if ($result -eq $OkButton.DialogResult){
    $VmName = $listbox.SelectedItem
    [System.Windows.Forms.MessageBox]::Show("Script is Running, please wait")
    $file = New-Item "TurnOnVM.txt"
    Write-Output $VmName > $file

    $testVM = Test-Connection $VmName - Count 60 -Quiet

    if ($test -eq "True"){
        [System.Windows.Forms.MessageBox]::Show("$VMName is online")

    }
    else{
        [System.Windows.Forms.MessageBox]::Show("$VMName is offline")
    }
}

elseif ($result -eq $CancelButton.DialogResult){

    $form.Close()
}