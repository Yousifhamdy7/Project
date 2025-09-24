#!bin/bash
	
LOG_DIR="./logs"
BACKUP_DIR="./backups"
mkdir -p "$LOG_DIR" "$BACKUP_DIR"

# --- Utilty Functions ---
pause(){
	read -p "Press [Enter] key to continue..."
}
confirm(){
	read -p "Are you sure? (y/n):" choice
	case "$choice" in
		y|Y) return 0 ;;
		*) echo "Operation cancelled"; return 1 ;;
	esac
}

#--- FILE MANAGMENT FUNCTIONS

create file(){
read -p "Enter file name: " filename
if [-e "$filename"]; then
	echo "File already exists!"
else
	touch "$filename" && echo "File '$filename' created."
fi
LOG_DIR="./logs"
BACKUP_DIR="./backups"
mkdir -p "$LOG_DIR" "$BACKUP_DIR"

# --- Utility Functions ---
pause() {
    read -p "Press [Enter] key to continue..."
}

confirm() {
    read -p "Are you sure? (y/n): " choice
    case "$choice" in
        y|Y) return 0 ;;
        *) echo "Operation cancelled."; return 1 ;;
    esac
}

# ==============================
# FILE MANAGEMENT FUNCTIONS
# ==============================

create_file() {
    read -p "Enter filename: " filename
    if [ -e "$filename" ]; then
        echo "File already exists!"
    else
        touch "$filename" && echo "File '$filename' created."
    fi
    pause
}

create_dir() {
    read -p "Enter directory name: " dirname
    if [ -d "$dirname" ]; then
        echo "Directory already exists!"
    else
        mkdir "$dirname" && echo "Directory '$dirname' created."
    fi
    pause
}
copy_file() {
	read -p "Enter file location:" src
	read -p "Enter destination:" dest
	if [ -e "$src"]; then
		cp -r "$src" "$dest" && echo "Copied successfully."
	else
		echo "Source does not exist."
	fi
	pause
}
move_file() {
	read -p "Enter file/dir:" src
	read -p "Enter destination:" dest
	if [ -e "$src" ]; then
		mv "$src" "$dest" && echo "Moved successfully."
	else
		echo "Source does not exist."
	fi
	pause
}
rename_file() {
    read -p "Enter current filename: " old
    read -p "Enter new filename: " new
    if [ -e "$old" ]; then
        if confirm; then
            mv "$old" "$new" && echo "Renamed successfully."
        fi
    else
        echo "File does not exist!"
    fi
    pause
}
delete_file() {
	read -p "Enter file/dir to delete:" target
	if [-e "$target" ]; then
		if confirm; then
			rm -rf "$target" && echo "Deleted.."
		fi 
	else
		echo "File/directory does not exist."
	fi 
	pause
}
search_file() {
	read -p "Enter directory to search:" dir
	read -p "Enter filename pattern:" pattern
	if [-d "$dir" ]; then
		find "$dir" -name "$pattern"
	else
		echo "Directory not found"
	fi 
	pause
}
change_permissions() {
	read -p "Enter file/dir:" target
	read -p "Enter permisson mode:" mode
	chmod "$mode" "$target" && echo "Permissions updated."
	pause
}
change_ownership() {
	read -p "Enter file/directory:" target
	read -p "Enter new owner:" owner
	sudo chown "$owner" "$target" && echo "Ownership updated."
	pause
}
backup_files() {
	read -p "Enter file/dir to backup:" target
	if [ -e "$target" ]; then
		tar -czf "$BACKUP_DIR/backup_$ts.tar.gz" "$target" && echo "Backup saved at $BACKUP_DIR/backup_$ts.tar.gz"
    else
        echo "Target does not exist!"
    fi
    pause
}
restore_backup() {
	read -p "Enter backup file path:" backup
	if [ -f "$backup" ]; then
		tar -xzf "$backup" -C ./ && echo "Backup restored."
	else "Backup file not found!"
	fi
	pause
}





#System Monitoring Funcitons...

system_info() {
    echo "System Information:"
    echo "OS: $(uname -o)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Date: $(date)"
}
cpu_usage() {
    echo "CPU Usage:"
    mpstat 1 1 | awk '/Average:/ {print 100 - $NF"%"}'
}

memory_usage() {
    echo "Memory Usage:"
    free -h | awk 'NR==2{printf "Used: %s / Total: %s\n", $3,$2}'
}

disk_usage() {
    echo "Disk Usage:"
    df -h --output=source,size,used,avail,pcent
}

generate_report() {
    report="$LOG_DIR/system_report_$(date +%Y%m%d_%H%M%S).log"
    {
        echo "===== System Report - $(date) ====="
        system_info
        echo
        cpu_usage
        echo
        memory_usage
        echo
        disk_usage
    } > "$report"
    echo "Report generated at $report"
    pause
}


#MENUS.....
#
#
file_management_menu() {
	while true; do
		clear
		echo
		echo "====== File Management ======"
        echo "1. Create File"
        echo "2. Create Directory"
        echo "3. Copy File/Directory"
        echo "4. Move File/Directory"
        echo "5. Rename File/Directory"
        echo "6. Delete File/Directory"
        echo "7. Search File"
        echo "8. Change Permissions"
        echo "9. Change Ownership"
        echo "10. Backup"
        echo "11. Restore Backup"
        echo "12. Back to Main Menu"
        read -p "Choose an option [1-12]: " choice
        case $choice in
            1) create_file ;;
            2) create_dir ;;
            3) copy_file ;;
            4) move_file ;;
            5) rename_file ;;
            6) delete_file ;;
            7) search_file ;;
            8) change_permissions ;;
            9) change_ownership ;;
            10) backup_files ;;
            11) restore_backup ;;
            12) break ;;
            *) echo "Invalid choice."; pause ;;
        esac
    done
}
system_monitoring_menu() {
    while true; do
        clear
        echo "====== System Monitoring ======"
        echo "1. System Info"
        echo "2. CPU Usage"
        echo "3. Memory Usage"
        echo "4. Disk Usage"
        echo "5. Generate Report"
        echo "6. Back to Main Menu"
        read -p "Choose an option [1-6]: " choice
        case $choice in
            1) system_info; pause ;;
            2) cpu_usage; pause ;;
            3) memory_usage; pause ;;
            4) disk_usage; pause ;;
            5) generate_report ;;
            6) break ;;
            *) echo "Invalid choice."; pause ;;
        esac
    done
}

