markdown

# Shell Scripting Cheat Sheet

## 1. Basics

### Variables
- **Definition**: Store data in a variable for reuse.
- **Syntax**: `variable_name="value"`
  
Example:
```
name="Lakshana"
echo "Hello, $name"
```
### Conditionals

    Purpose: Make decisions based on conditions.
    Syntax:

    

    if [ condition ]; then
      # Code if true
    else
      # Code if false
    fi

Example:



if [ "$name" == "Lakshana" ]; then
  echo "Welcome!"
else
  echo "Access denied."
fi

### Loops

    For Loop: Executes commands for each item in a list.

    

for i in {1..5}; do
  echo "Number: $i"
done

### While Loop: Repeats commands while a condition is true.



    count=1
    while [ $count -le 5 ]; do
      echo "Count: $count"
      count=$((count + 1))
    done

### Functions

    Definition: Reusable blocks of code.
    Syntax:

    

    function_name() {
      # Code
    }

Example:



greet() {
  echo "Hello, $1!"
}
greet "Lakshana"

## 2. File Operations
### Creating Files and Directories


```
touch file.txt           # Create file
mkdir my_directory       # Create directory
```
### Reading a File


```
while read line; do
  echo $line
done < file.txt
```
### Deleting Files and Directories


```
rm file.txt              # Delete file
rmdir my_directory       # Delete empty directory
rm -r my_directory       # Delete directory with contents
```
## 3. Text Processing
### Using grep

    Purpose: Search for patterns in files.

Example:


```
grep "pattern" file.txt
```
### Using sed
Purpose: Stream editor for editing text in a pipeline.

Example:


```
sed 's/old/new/g' file.txt
```
### Using awk

    Purpose: Process and analyze text in columns.

Example:


```
awk '{print $1}' file.txt
```
## 4. Process Management
### Running in Background
```


sleep 100 &         # Runs command in background
jobs                # List background jobs
```
### Killing a Process
```


kill [PID]
```
## 5. Network Operations
### Ping a Server
```


ping -c 4 example.com
```
### Download a File
```


curl -O http://example.com/file.zip
```
## 6. Error Handling & Debugging
### Enabling Debugging

    Use set -x to trace script execution.

Example:
```


set -x
echo "Debugging enabled"
set +x
```
### Trap Errors

    Trap signals and execute specific commands.

Example:
```


trap 'echo "Error occurred"' ERR
```
## 7. Best Practices

Use Comments: Add explanations for complex code.
```


### This loop prints numbers 1 to 5
for i in {1..5}; do
  echo $i
done
```
### Error Checking: Check for errors in commands.
```


if ! mkdir new_dir; then
  echo "Failed to create directory"
fi
```
Use Functions for Repeated Code: Write functions for tasks that repeat.