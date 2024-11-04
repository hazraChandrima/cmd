# a script that maintains a silly toDo list, nothing more, nothing less!

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"

Write-Host "`n---- Welcome! -----" -ForegroundColor "Cyan"

$tasks = New-Object System.Collections.ArrayList

function toDo() {
	
	Write-Host "`nEnter:`tview`n`tadd`n`tdelete`n`texit" -ForegroundColor "DarkYellow"
	$choice = Read-Host 

	if($choice -eq "exit") {
		Write-Host "`nExited.`n" -ForegroundColor "Cyan"
		exit
	} else {
		if($choice -eq "view") {
			if($tasks.Count -eq 0) {
				Write-Host "`nNo tasks remaining" -ForegroundColor "DarkCyan"
			} else {
				for($i = 0; $i -lt $tasks.Count; $i++) {
					Write-Host -NoNewLine "$($i+1). " -ForegroundColor "Magenta"
					Write-Host "$($tasks[$i])" -ForegroundColor "Yellow"
				}
			}
		}
		elseif($choice -eq "add") {
			Write-Host "`nenter a new task :" -ForegroundColor "DarkYellow"
			$newTask = Read-Host 
			$tasks.Add($newTask) | Out-Null
			Write-Host "`ntask '$newTask' added successfully!" -ForegroundColor "Green"
		}
		elseif($choice -eq "delete") {
			if($tasks.Count -eq 0) {
				Write-Host "`nNo tasks to delete" -ForegroundColor "DarkCyan"
			} else {
				while($true) {
					Write-Host "`nenter the task number you want to delete :" -ForegroundColor "DarkYellow"
					$taskIndex = Read-Host 

					if([int]::TryParse($taskIndex , [ref]$null) -and ($taskIndex -gt 0) -and ($taskIndex -le $tasks.Count)) {
						$deletedTask = $tasks[$taskIndex - 1]
						$tasks.RemoveAt($taskIndex - 1)
						Write-Host "`ntask '$deletedTask' deleted successfully!" -ForegroundColor "Green"
						break
					} else {
						Write-Host "`nplease enter a valid index!" -ForegroundColor "DarkRed"
					}
				}
			}
		}
		else {
			Write-Host "`ninvalid choice entered!" -ForegroundColor "DarkRed"
		}
		toDo
	}
}

toDo

		