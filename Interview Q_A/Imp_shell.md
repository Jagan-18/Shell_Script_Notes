1. What is a shell script? Explain the concept of a shell script, its purpose, and how it differs from a regular program.
2. What are the different types of shells in Unix/ Linux?Discuss common shells like Bash, Korn shell, and Z shell.
3. How do you execute a shell script?Explain the steps involved in making a script executable and running it.
4. What are the basic shell scripting syntax elements?Cover variables, comments, control flow statements (if-else, for, while, case), and input/output redirection.
5. Explain the concept of environment variables. Discuss how environment variables are set, accessed, and used in shell scripts.
6. How do you write a simple shell script to print "Hello, World!"?Provide a basic script example and explain its components.

7. What are command-line arguments in shell scripts? Explain how to access command-line arguments using $1, $2, $@, and $*.
8. How do you read user input from the keyboard in a shell script?Discuss the read command and its usage.
9. What are shell functions? How do you define and use them? Explain the syntax and usage of shell functions.
10. How do you write a shell script to check if a file exists and is readable? Demonstrate the use of test or [] commands for file checks.
11. How do you write a shell script to sort a file numerically? Explain the use of sort command with appropriate options.
12. What is the difference between single quotes, double quotes, and backticks in shell scripts? Discuss the usage and nuances of these quoting mechanisms.

13. How do you write a shell script to automate a backup process? Discuss the steps involved, including file copying, compression, and logging.
14. Explain the concept of pipelines in shell scripting.Demonstrate how to chain multiple commands together using pipes.
15. How do you write a shell script to parse a log file and extract specific information? Explain the use of grep, sed, and awk for text processing.
16. What are regular expressions? How are they used in shell scripting? Discuss the basic syntax and usage of regular expressions with grep and sed.
17. How do you write a shell script to send email notifications?Explain the use of mail or sendmail commands.
18. What are shell traps? How can they be used to handle signals and errors? Discuss the concept of traps and their usage in error handling and cleanup.



### Imp Q:
1. Write a shell script to find and delete all files in a directory that are older than 30 days.
2. Create a script to monitor the disk usage of a server. If usage exceeds 80%, log the details to a file and send an alert email. ## Refer: shell_script/18_disk-usea 
3. Write a script that renames all.txt files in a directory by appending the current date to the filename.
4. Create a script that checks if a particular service (e.g., httpd or nginx) is running. If not, it should restart the service and log the action.
5. Write a script to monitor CPU and memory usage every minute and log the details if CPU usage is above 90% or memory usage exceeds 75%.
6. Write a script that performs a backup of a specified directory and compresses it with the current date in the filename. Schedule it to run daily using cron.
7. Create a script to check the availability of a list of websites. For each site, if it's unreachable, log the URL and send an alert.
8. Write a Python script using boto3 to list all S3 buckets in an AWS account and their respective sizes.
9. Develop a script that starts and stops EC2 instances based on a schedule (e.g., start at 8 AM and stop at 8 PM).
10. Create a script that monitors a specified directory and automatically deletes any files larger than 100 MB.



