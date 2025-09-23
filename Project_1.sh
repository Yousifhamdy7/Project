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

