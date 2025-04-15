Server Performance Monitoring Script
This script provides an overview of key system statistics, such as CPU usage, memory usage, disk space, and process information, to help monitor server performance. It uses common Linux commands like top, free, and df to fetch and display the data in an easy-to-read format.

Prerequisites
A Linux-based system (Ubuntu, CentOS, etc.)

Basic knowledge of Linux commands

Bash shell (usually pre-installed on Linux systems)

Features
Total CPU Usage: Displays the percentage of CPU in use.

Total Memory Usage: Shows total memory, used memory, free memory, and available memory.

Disk Usage: Displays the total disk space, used space, available space, and usage percentage for the root (/) partition.

Top 5 Processes by CPU Usage: Displays the top 5 processes that are using the most CPU.

Top 5 Processes by Memory Usage: Displays the top 5 processes consuming the most memory.

Usage
Clone the repository or download the script.

Make the script executable:

bash
Copy
Edit
chmod +x server_performance_monitor.sh
Run the script:

bash
Copy
Edit
./server_performance_monitor.sh
The script will output the following information:

Total CPU Usage

Memory Usage (Total, Used, Free, Available)

Disk Usage (Total, Used, Available, Use%)

Top 5 processes by CPU usage

Top 5 processes by Memory usage

Example Output:
bash
Copy
Edit
Total: 50G
Used: 12G
Available: 35G
Used %: 25%

CPU Usage: 5%

Memory Usage:
Total: 7972MB
Used: 2245MB
Free: 1244MB
Available: 5312MB

Top 5 Processes by CPU:
1. pid 1 - init [CPU: 0.5%]
2. pid 145 - apache2 [CPU: 0.4%]
3. pid 256 - node [CPU: 0.3%]

Top 5 Processes by Memory:
1. pid 256 - node [MEM: 200MB]
2. pid 145 - apache2 [MEM: 150MB]
3. pid 1 - init [MEM: 120MB]
Script Details
1. CPU Usage
The script uses the top command to capture CPU usage data:

bash
Copy
Edit
top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1
2. Memory Usage
The free -m command is used to display memory statistics:

bash
Copy
Edit
free -m
3. Disk Usage
The df -h command is used to get disk usage information:

bash
Copy
Edit
df -h / | tail -1
4. Top Processes by CPU and Memory
The script uses top -bn1 to extract top CPU and memory processes:

bash
Copy
Edit
top -bn1 | head -10
Customization
You can modify the script to monitor additional resources such as network usage, disk I/O, or load average by updating the respective command sections. You can also modify the alert thresholds for CPU usage, memory usage, and disk usage to trigger notifications.


Project Page URL :- https://roadmap.sh/projects/server-stats