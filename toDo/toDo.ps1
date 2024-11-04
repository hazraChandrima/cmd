# a script that maintains a silly toDo list, nothing more, nothing less!
# Written by: Chandrima Hazra

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"

Write-Host "`n---- Welcome! -----" -ForegroundColor "Cyan"

if (!(Test-Path -Path $PSScriptRoot)) {
    New-Item -ItemType Directory -Path $PSScriptRoot
}

$listPath = "$PSScriptRoot\tasks.json"

if(Test-Path -Path $listPath) {
	$tasks = [System.Collections.ArrayList](Get-Content -Path $listPath | ConvertFrom-Json)
} else {
	$tasks = New-Object System.Collections.ArrayList
}


#saves the to-Do tasks in file tasks.json in the same directory as the script
function saveList() {
	$tasks | ConvertTo-Json | Set-Content -Path $listPath
}


function toDo() {
	
	Write-Host "`nEnter:`t'view' to view your to-do list`n`t'add' to add a new task`n`t'delete' to delete a task`n`t'clear' to clear the entire list`n`t'exit' to exit" -ForegroundColor "DarkYellow"
	$choice = Read-Host 

	if($choice -eq "exit") {
		Write-Host "`nExited.`n" -ForegroundColor "Cyan"
		saveList
		exit
	} else {
		if($choice -eq "clear") {
			$tasks = New-Object System.Collections.ArrayList
			Remove-Item '.\tasks.json'
			Write-Host "`nto-do list cleared successfully!" -ForegroundColor "Green"
		}
		elseif($choice -eq "view") {
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

		