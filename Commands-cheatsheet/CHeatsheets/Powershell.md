PowerShell Cheat Sheet

markdown

# PowerShell Cheat Sheet

## 1. Basics

### Variables
- **Definition**: Store data in a variable for reuse.
- **Syntax**: `$variableName = value`

Example:
```powershell
$name = "Lakshana"
Write-Host "Hello, $name"

Conditionals

    Purpose: Make decisions based on conditions.
    Syntax:

    powershell

    if ($condition) {
        # Code if true
    } else {
        # Code if false
    }

Example:

powershell

if ($name -eq "Lakshana") {
    Write-Host "Welcome!"
} else {
    Write-Host "Access denied."
}

Loops

    For Loop: Executes commands for each item in a collection.

    powershell

for ($i = 1; $i -le 5; $i++) {
    Write-Host "Number: $i"
}

While Loop: Repeats commands while a condition is true.

powershell

    $count = 1
    while ($count -le 5) {
        Write-Host "Count: $count"
        $count++
    }

Functions

    Definition: Reusable blocks of code.
    Syntax:

    powershell

    function FunctionName {
        param ($param1, $param2)
        # Code
    }

Example:

powershell

function Greet {
    param ($name)
    Write-Host "Hello, $name!"
}
Greet "Lakshana"

2. File Operations
Creating Files and Directories

powershell

New-Item -ItemType File -Name "file.txt"  # Create file
New-Item -ItemType Directory -Name "my_directory"  # Create directory

Reading a File

powershell

Get-Content file.txt | ForEach-Object { Write-Host $_ }

Deleting Files and Directories

powershell

Remove-Item file.txt              # Delete file
Remove-Item my_directory -Recurse  # Delete directory with contents

3. Text Processing
Using Select-String

    Purpose: Search for patterns in files.

Example:

powershell

Select-String -Pattern "text" -Path file.txt

Using Replace

    Purpose: Replace text in a string.

Example:

powershell

("old text" -replace "old", "new")

4. Process Management
Running a Process

powershell

Start-Process "notepad.exe"  # Start a new process

Stopping a Process

powershell

Stop-Process -Name "notepad"  # Stop a process by name

5. Network Operations
Ping a Server

powershell

Test-Connection -ComputerName "example.com" -Count 4

Download a File

powershell

Invoke-WebRequest -Uri "http://example.com/file.zip" -OutFile "file.zip"

6. Error Handling
Try/Catch Blocks

powershell

try {
    # Code that might throw an exception
} catch {
    Write-Host "Error occurred: $_"
}

7. Best Practices

    Use Comments: Add explanations for complex code.

powershell

# This function greets the user
function Greet {
    param ($name)
    Write-Host "Hello, $name!"
}

    Error Checking: Use error handling mechanisms.

powershell

if (-Not (Test-Path "file.txt")) {
    Write-Host "File does not exist."
}