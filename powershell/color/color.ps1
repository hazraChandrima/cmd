#Set your colors in PowerShell

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"

Write-Host "`nSET YOUR COLORS IN POWERSHELL`n"

foreach ($color in [System.Enum]::GetValues([System.ConsoleColor])) {
	if(($color -eq "Black") -or ($color -eq "DarkBlue")) {
		Write-Host "$color " -ForegroundColor $color -BackgroundColor "White"
	} else { 			
		Write-Host "$color" -ForegroundColor $color
	}
}

$input_Fore = Read-Host "`nEnter your new Foreground Color from the colors above"
$input_Back = Read-Host "Enter your new Background Color from the colors above"

$Host.UI.RawUI.ForegroundColor = $input_Fore
$Host.UI.RawUI.BackgroundColor = $input_Back

Write-Host "`nYour desired color has been set Successfully`n"
