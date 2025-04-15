#!/bin/bash
#########################################################################
# Problem Statement
# Display the following.
#Total CPU usage
#Total memory usage (Free vs Used including percentage)
#Total disk usage (Free vs Used including percentage)
#Top 5 processes by CPU usage
#Top 5 processes by memory usage
#########################################################################
#This is a sample script that prints the statistics of the server
# The commands   are
# top --> Displays Linux Processes
# free --> displays the amount of free memory and   memory in the system
# df --> displays the disk amount of disk space available on the file system containing each file name argument
# pd --> reports the current snapshot of the current processes
#
######### Comman Commnads 
# | --> Pipe (Takes the input from the first commnad and pass it to next )  ex:- top | grep "Cpu(s)" 
# grep --> Global Regular Expression  
# awk -->  Text Processing 
#
#
#
#
#
#
#
#

echo "Server Report Generated on  $(date)"
echo "Hostname : $(hostname)"
os_version=$(hostnamectl | grep "Operating System" | tail -d':' -f2 | xargs)  # xargs Removes the Extra spaces
echo 'OS version: ${os_version}'
echo 'Uptime: $(uptime)'
echo 'User: $(whoami)'
read one  five fifteen < /proc/loadavg
echo "Load Average(1 min , 5 min , 15 min): $one, $five, $fifteen"
failed_login=$(grep -c "Failed password" /var/log/auth.log)
echo "Failed Login Attempts: ${failed_login}"
echo "######################"

echo "-----Total CPU Usage-----"
CPU_IDLE = $(top -bn1 | grep  "Cpu(s)" |  awk '{print $8}' | cut  -d'.' -f1) 
CPU_USAGE = $(( 100 - CPU_IDLE))

echo "Total CPU usage $CPU_USAGE"

echo "######################"

echo "-----Memory Usage-----"

read total used free <<< $(free -m | awk '/Mem:/ {print $2, $3, $4}')
MEM_USED_PERCENT= $(( used  * 100 / total))
echo "Total: $(total)MB"
echo "Used: $(used)MB"
echo "Free: $(free)MB"
echo "Memory Used Percentage: $(MEM_USED_PERCENT)%"
echo "##################################"

#------Disk Usage-----
echo "##################################"
echo "Disk Usage"
df_output=$(df - h / |  tail -1)

total=$(echo "$df_output" | awk '{print $2}')
used=$(echo "$df_output" | awk '{print $3}')
avail=$(echo "$df_output" | awk '{print $4}')
used_percent=$(echo "$df_output" | awk '{print $5}')
echo "Total: $total"
echo "Used: $used"
echo "Available: $avail"
echo "Used %: $used_percent"
echo "##################################"

#--Top 5 Processes by CPU usage -->
echo "Top 5 processes by CPU usage"

ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head n -5

# ps --> displays info about all the processes
# -e --> shows all processes
# -o --> specifies the output format
# pid -> process id
# ppid --> parent process id
# cmd --> command that launches that process
# %cpu --> percentage cpu usage
# %mem --> percentage memory usage  
# --sort=-%cpu --> sorts cpu usage in descending order  
# head -n 6 --> List the ouput to the top 6 lines  


echo "Top 5 processes by Memory Usage"

ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%mem | head  -n 6


echo "######################################"
echo "END OF THE REPORT"


