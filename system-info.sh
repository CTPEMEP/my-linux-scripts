#!/bin/bash
#system-info.sh - Output main info about system
#author: Aleksandrov M.S.
#date: $(date +%Y-%m-%d)
echo "========================================"
echo "Information about system"
echo "========================================"
echo "Opertion system:"
cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2
echo ""
echo "Core version:"
uname -r
echo ""
echo "Uptime:"
uptime -p
echo ""
echo "Disk usage"
df -h --output=source,pcent,target | grep -E "^/dev"
echo ""
echo "random access memory"
free -h | awk 'NR==1{print "     "$0} NR==2{print "Total: " $2 " | Free: " $4" | Use d: "$3}'
echo ""
echo "CPU"
lscpu | grep "Model name" | cut -d: -f2 | sed 's/^ *//'
echo ""
echo "Network interface"
ip -o -4 addr show | awk '{print $2 ": " $4}'
echo ""

echo "========================================="
echo "check completed d $(date)"
