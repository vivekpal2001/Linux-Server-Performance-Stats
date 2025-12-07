# Linux Server Performance Stats

A comprehensive Bash script to monitor and display Linux server performance statistics in real-time.

## 📋 Description

This script collects and displays detailed server performance metrics including CPU usage, memory utilization, disk space, running processes, system uptime, and security information (failed login attempts). Perfect for system administrators and DevOps engineers who need quick insights into server health.

## ✨ Features

- **OS Information**: Distribution, kernel version, architecture, hostname, uptime, and boot time
- **CPU Metrics**: Model, cores, user/system/idle percentages, I/O wait, and total usage
- **Memory Stats**: Total, used, free, and available memory with percentages
- **Disk Usage**: Total filesystem usage summary
- **Process Monitoring**: Top 5 CPU and memory-consuming processes
- **Uptime Info**: System uptime, boot time, and load averages (1min, 5min, 15min)
- **Security**: Failed login attempts in the last 24 hours

## 🚀 Getting Started

### Prerequisites

- Linux-based operating system (Ubuntu, Debian, CentOS, RHEL, etc.)
- Bash shell
- Standard Linux utilities: `top`, `free`, `df`, `ps`, `lscpu`, `uptime`, `lastb`

### Installation

1. Clone the repository:
```bash
git clone https://github.com/vivekpal2001/Linux-Server-Performance-Stats.git
cd Linux-Server-Performance-Stats
```

2. Make the script executable:
```bash
chmod +x serverStat.sh
```

### Usage

**Basic usage:**
```bash
./serverStat.sh
```

**For failed login attempts (requires sudo):**
```bash
sudo ./serverStat.sh
```

## 📊 Sample Output

```
======================================
       Server Performance Stats       
======================================
Generated Date and Time: 2025_12_07 14:30:25
Current User: vivek

--- Operating System Information ---
Distribution: Ubuntu 22.04.3 LTS
Kernel Version: 5.15.0-91-generic
Architecture: x86_64
Hostname: server-01
Uptime: 15 days, 3 hours, 45 minutes
Boot Time: 2025-11-20 08:30

--- CPU Usage Information ---
CPU Model: Intel(R) Core(TM) i7-9700K CPU @ 3.60GHz
Number of Cores: 8
User:      12.5%
System:    5.2%
Idle:      82.0%
I/O Wait:  0.3%
Total Busy:18.0%

--- MEMORY USAGE ---
Total:     16G
Used:      8G (50%)
Free:      8G (50%)
Available: 12G

--- DISK USAGE ---
Filesystem: total
Size:       500G
Used:       320G
Available:  180G
Use%:       64%

--- TOP 5 PROCESSES BY CPU USAGE ---
  PID COMMAND         %CPU
 2345 chrome          25.5
 6789 node            18.3
 1234 python3         12.1
 4567 mysql            8.7
 8901 nginx            5.2

--- TOP 5 PROCESSES BY MEMORY USAGE ---
PID   COMMAND         SIZE(MB)   MEM%
2345  chrome          1024.5MB    12.5%
6789  firefox          680.3MB     8.3%
9012  mysql            550.7MB     6.7%
3456  apache2          345.2MB     4.2%
7890  python3          312.8MB     3.8%

--- UPTIME INFORMATION ---
Uptime: 15 days, 3 hours, 45 minutes
Boot Time: 2025-11-20 08:30
Load Average: 2.45, 1.89, 1.67

--- FAILED LOGIN ATTEMPTS (Last 24 hours) ---
root 192.168.1.50 Sat Dec 7 14:23
admin 10.0.0.45 Sat Dec 7 13:15
test 203.0.113.10 Sat Dec 7 12:08

======================================
     End of Performance Report        
======================================
```

## 🔧 Customization

You can modify the script to:
- Change the number of top processes displayed (modify `head -n 6`)
- Adjust time range for failed login attempts (modify `-1days`)
- Add more metrics or remove existing ones
- Format output differently

## 📝 Functions Overview

| Function | Description |
|----------|-------------|
| `display_header()` | Shows script header with timestamp and current user |
| `get_os_info()` | Displays OS distribution, kernel, architecture, hostname, uptime |
| `get_cpu_usage()` | Shows CPU model, cores, and usage breakdown |
| `get_memory_usage()` | Displays memory statistics with percentages |
| `get_disk_usage()` | Shows total disk usage summary |
| `get_top_processes_cpu()` | Lists top 5 CPU-consuming processes |
| `get_top_processes_memory()` | Lists top 5 memory-consuming processes with sizes |
| `get_uptime_info()` | Shows uptime, boot time, and load averages |
| `get_failed_attempts()` | Displays recent failed login attempts |
| `main()` | Orchestrates all functions and generates the report |

## ⚠️ Requirements & Permissions

- **Failed login attempts**: Requires sudo/root access to read `/var/log/btmp`
- If running without sudo, the script will still execute but skip failed login attempts

## 📚 Linux Commands & Concepts Learned

Through building this project, I learned and implemented various Linux server monitoring commands:

### System Information Commands
- `uname -r` - Display kernel version
- `uname -m` - Show system architecture (x86_64, ARM, etc.)
- `hostname` - Get server hostname
- `lscpu` - List CPU architecture and details
- `nproc` - Count number of CPU cores
- `/etc/os-release` - File containing OS distribution information

### Resource Monitoring
- `top -bn1` - Batch mode top command for CPU usage
- `free -h` - Display memory usage in human-readable format
- `df -h --total` - Show disk space usage
- `uptime -p` - Display system uptime in readable format
- `who -b` - Show last system boot time

### Process Management
- `ps -eo pid,comm,%cpu` - List processes with CPU usage
- `ps -eo pid,comm,rss,%mem` - List processes with memory usage
- `--sort=-%cpu` - Sort processes by CPU (descending)
- `--sort=-%mem` - Sort processes by memory (descending)

### Security & Logs
- `lastb` - Show failed login attempts from `/var/log/btmp`
- `sudo -n` - Check sudo privileges without password prompt

### Text Processing with AWK
- Field extraction: `awk '{print $1, $2}'`
- Conditional filtering: `awk 'NR==2'` (select specific rows)
- Mathematical operations: `awk '{print 100 - $8}'`
- Formatted output: `printf` for aligned columns

### Shell Scripting Techniques
- Command substitution: `$(command)`
- Piping and redirection
- Function definitions and organization
- Conditional checks with `if [ -f file ]`
- Error handling and fallbacks

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Roadmap.sh submit Link
Roadmap.sh link : https://roadmap.sh/projects/server-stats
