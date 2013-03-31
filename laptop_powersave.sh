#!/bin/bash
if on_ac_power; then
# Reset back to normal settings
  echo 0 > /proc/sys/vm/laptop_mode 
  echo 10 > /proc/sys/vm/dirty_ratio
  echo 5 > /proc/sys/vm/dirty_background_ratio 
  echo 500 > /proc/sys/vm/dirty_writeback_centisecs 
  echo max_performance > /sys/class/scsi_host/host0/link_power_management_policy 
  echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
  echo "AC Power Done"
else
# Turn on aggressive power savings
  echo 5 > /proc/sys/vm/laptop_mode
  echo 40 > /proc/sys/vm/dirty_ratio
  echo 10 > /proc/sys/vm/dirty_background_ratio
  echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
  echo min_power > /sys/class/scsi_host/host0/link_power_management_policy
  echo conservative > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
  xrandr --output DFP_EXTTMDS --off
  xrandr --output CRT1 --off

fi