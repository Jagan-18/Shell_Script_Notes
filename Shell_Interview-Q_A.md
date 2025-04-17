# 1. How can you write a script to get the PIDs of 10 processes running on your host?
### Bash Script:
```bash
#!/bin/bash

# List the first 10 running processes and display their PID
ps -eo pid,comm --sort=pid | head -n 11
```
### Explanation:
1. **`#!/bin/bash`**:  
   This is called a **shebang** and tells the system to run the script using the `bash` shell.
2. **`ps -eo pid,comm --sort=pid`**:  
   - `ps` is the command that shows information about running processes.
   - `-e` means to show all processes.
   - `-o pid,comm` specifies the output format, where `pid` is the Process ID and `comm` is the command that started the process.
   - `--sort=pid` sorts the processes by PID, so the smallest PIDs (typically the first processes that were started) come first.
3. **`head -n 11`**:  
   - `head` is used to display the first few lines of the output.
   - `-n 11` tells it to show the first 11 lines: one for the header (column names) and 10 for the processes.
---
(**OR**)
#### This script provides a clean list of the first 10 processes, showing their PIDs and associated commands. 
```bash
#!/bin/bash
ps -e -o pid,comm --sort=pid | head -n 11
```
**Explanation:**
- `ps -e`: Lists all running processes.
- `-o pid,comm`: Specifies the output format to show only the PID and command name.
- `--sort=pid`: Sorts the processes by their PID.
- `head -n 11`: Displays the first 11 lines (including the header and the first 10 processes).

---


