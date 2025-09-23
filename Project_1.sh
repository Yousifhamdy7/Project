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

