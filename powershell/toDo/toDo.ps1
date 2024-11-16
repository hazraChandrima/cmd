# A script that maintains a useless to-do list, nothing more, nothing less!

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"

Write-Host "`n---- Welcome! -----" -ForegroundColor "Cyan"

if (!(Test-Path -Path $PSScriptRoot)) {
    New-Item -ItemType Directory -Path $PSScriptRoot
}

$listPath = "$PSScriptRoot\tasks.json"

if (Test-Path -Path $listPath) {
    $jsonContent = Get-Content -Path $listPath | ConvertFrom-Json
    if ($jsonContent -is [System.Object[]] -or $jsonContent -is [System.Collections.ArrayList]) {
        $tasks = [System.Collections.ArrayList]$jsonContent
    } elseif ($jsonContent -is [string]) { # cuz apparently, it can't convert strings to arraylist :/
        $tasks = New-Object System.Collections.ArrayList
        $tasks.Add($jsonContent) | Out-Null
    } else {
        $tasks = New-Object System.Collections.ArrayList
    }
} else {
    $tasks = New-Object System.Collections.ArrayList
}


# Saves the to-do tasks in file tasks.json in the same directory as this script
function saveList {
    $tasks | ConvertTo-Json | Set-Content -Path $listPath
}



function toDo {
    $flag = $true  
    while ($flag) {
        Write-Host "`nEnter:`t'view' to view your to-do list`n`t'add' to add a new task`n`t'delete' to delete a task`n`t'clear' to clear the entire list`n`t'exit' to exit" -ForegroundColor "DarkYellow"
        $choice = Read-Host

        switch ($choice) {
            "view" {
                if ($tasks.Count -eq 0) {
                    Write-Host "`nNo tasks remaining" -ForegroundColor "DarkCyan"
                } else {
                    for ($i = 0; $i -lt $tasks.Count; $i++) {
                        Write-Host -NoNewLine "$($i+1). " -ForegroundColor "Magenta"
                        Write-Host "$($tasks[$i])" -ForegroundColor "Yellow"
                    }
                }
            }
            "add" {
                Write-Host "`nEnter a new task:" -ForegroundColor "DarkYellow"
                $newTask = Read-Host
                $tasks.Add($newTask) | Out-Null
		saveList
                Write-Host "`nTask '$newTask' added successfully!" -ForegroundColor "Green"
            }
            "delete" {
                if ($tasks.Count -eq 0) {
                    Write-Host "`nNo tasks to delete" -ForegroundColor "DarkCyan"
                } else {
                    while ($true) {
                        Write-Host "`nEnter the task number you want to delete:" -ForegroundColor "DarkYellow"
                        $taskIndex = Read-Host

                        if ([int]::TryParse($taskIndex, [ref]$null) -and ($taskIndex -gt 0) -and ($taskIndex -le $tasks.Count)) {
                            $deletedTask = $tasks[$taskIndex - 1]
                            $tasks.RemoveAt($taskIndex - 1)
			    saveList
                            Write-Host "`nTask '$deletedTask' deleted successfully!" -ForegroundColor "Green"
                            break
                        } else {
                            Write-Host "`nPlease enter a valid index!" -ForegroundColor "DarkRed"
                        }
                    }
                }
            }
            "clear" {
                $tasks = New-Object System.Collections.ArrayList
                Clear-Content $listPath
		saveList
                Write-Host "`nTo-do list cleared successfully!" -ForegroundColor "Green"
            }
            "exit" {
                Write-Host "`nExited.`n" -ForegroundColor "Cyan"
                saveList
                $flag = $false  
                break
            }
            default {
                Write-Host "`nInvalid choice entered!" -ForegroundColor "DarkRed"
            }
        }
    }
}

toDo
