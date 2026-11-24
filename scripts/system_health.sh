#!/bin/bash
BASE_DIR="$(dirname "$0")"
LOG_DIR="$BASE_DIR/../logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/system_health_$(date +%Y%m%d_%H%M%S).log"
{
echo "========================================="
echo "UBUNTU SERVER HEALTH REPORT"
echo "Generated On : $(date)"
echo "========================================="
echo ""
echo "Hostname:"
hostname
echo ""
echo "IP Address:"
hostname -I
echo ""
echo "Operating System:"
cat /etc/os-release | grep PRETTY_NAME
echo ""
echo "Kernel Version:"
uname -r
echo ""
echo "System Uptime:"
uptime -p
echo ""
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)"
echo ""
echo "Memory Usage:"
free -h
echo ""
echo "Disk Usage:"
df -hT
echo ""
echo "Top Processes:"
ps -eo pid,cmd,%mem,%cpu --sort=-%cpu | head
echo ""
echo "Listening Ports:"
ss -tulnp | head
echo ""
echo "Failed Services:"
systemctl --failed
} > "$LOG_FILE"
echo "Health report saved to $LOG_FILE"

