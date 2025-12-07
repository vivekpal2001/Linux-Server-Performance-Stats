#!/bin/bash


display_header(){
    echo "======================================"
    echo "       Server Performance Stats       "
    echo "======================================"
    echo "Generated Date and Time: $(date '+%Y_%m_%d %H:%M:%S')"
    echo "Current User: $(whoami)"
    echo
}

get_os_info(){
    echo "--- Operating System Information ---"
    
    if [ -f /etc/os-release ]; then
        . .etc/os-release
        echo "Distribution: $PRETTY_NAME"
    fi
    echo "Kernel Version: $(uname -r)"
    echo "Architechture: $(uname -m)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Boot Time: $(who -b | awk '{print $3, $4}')"
}

get_cpu_usage(){
    echo "--- CPU Usage Information ---"
    cpu_model=$(lscpu | grep "Model name" | cut -d: -f2 | xargs)
    cpu_cores=$(nproc)
    echo "CPU Model: $cpu_model"
    echo "Number of Cores: $cpu_cores"
    top -bn1 | grep "Cpu(s)" | sed 's/,//g' | awk '{
        printf "User:      %s%%\n", $2
        printf "System:    %s%%\n", $4
        printf "Idle:      %s%%\n", $8
        printf "I/O Wait:  %s%%\n", $10
        printf "Total:     %.2f%%\n", 100 - $8
    }'

}

get_memory_usage(){
    echo "--- MEMORY USAGE ---"
    free -h --giga | awk 'NR==2{
        total=$2
        used=$3
        free=$4
        avail=$7
        used_pct=int(($3/$2)*100)
        free_pct=100-used_pct
        printf "Total: %s\n", total
        printf "Used: %s (%d%%)\n", used, used_pct
        printf "Free: %s (%d%%)\n", free, free_pct
        printf "Available: %s\n", avail
    }'
}

get_disk_usage(){
    echo "--- DISK USAGE ---"
    df -h --total | awk 'NR==1 || /total/ {
        printf "Filesystem: %s\n", $1
        printf "Size:       %s\n", $2
        printf "Used:       %s\n", $3
        printf "Available:  %s\n", $4
        printf "Use%%:      %s\n", $5
    }'
}

get_top_processes_cpu(){
    echo "--- TOP 5 PROCESSES BY CPU USAGE ---"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

get_top_processes_memory(){
    echo "--- TOP 5 PROCESSES BY MEMORY USAGE ---"
    ps -eo pid,comm,rss,%mem --sort=-%mem | head -n 6 | awk 'NR==1{print "PID   COMMAND         SIZE      MEM%"} NR>1{printf "%-6s %-15s %6.1f MB %5.1f%%\n", $1, $2, $3/1024, $4}'
}

get_uptime_info(){
    echo "--- UPTIME INFORMATION ---"
    
    uptime_str=$(uptime -p | sed 's/up //')
    echo "Uptime: $uptime_str"
    
    boot_time=$(who -b | awk '{print $3, $4}')
    echo "Boot Time: $boot_time"
    
    load_avg=$(uptime | awk -F'load average:' '{print $2}' | xargs)
    echo "Load Average: $load_avg"
}

get_failed_attempts(){
    echo "--- FAILED LOGIN ATTEMPTS (Last 24 hours) ---"
    
    if sudo -n lastb -s -1days &>/dev/null; then
        sudo lastb -s -1days | awk '{print $1, $3, $4, $5, $6, $7}' | head -n 10
    else
        echo "Note: Requires sudo privileges to view failed login attempts."
        echo "Run with: sudo ./serverStat.sh"
    fi
}


main(){
    display_header
    echo
    get_os_info
    echo
    get_cpu_usage
    echo
    get_memory_usage
    echo
    get_disk_usage
    echo
    get_top_processes_cpu
    echo
    get_top_processes_memory
    echo
    get_uptime_info
    echo
    get_failed_attempts
    echo
    echo "======================================"
    echo "     End of Performance Report        "
    echo "======================================"
}


main


