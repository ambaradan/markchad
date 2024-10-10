#!/bin/env bash
# source libs/help
bold_in='\033[1m'
bold_out='\033[0m'
italic='\e[3m'
clear='\e[0m'
# Function ause to continue or quit
function press_enter_or_quit() {
  while true; do
    printf "\n"
    read -r -p "  Press Enter to continue or 'q' to quit... " input
    if [[ "$input" == "q" ]]; then
      printf "  %s\n" "Quitting the script."
      printf "\n"
      exit 0
    elif [[ -z "$input" ]]; then
      return # Continue with the script
    else
      printf "  %s\n" "Invalid input. Please press Enter to continue or 'q' to quit."
      printf "\n"
    fi
  done
}
# Function to format text
function format_text() {
  local text="$1"
  # Use fold to limit line width and sed to add padding
  printf "%s" "$text" | fold -s -w 76 | sed 's/^/  /; s/$/  /'
}
function format_text4() {
  local text="$1"
  # Use fold to limit line width and sed to add padding
  printf "%s" "$text" | fold -s -w 72 | sed 's/^/    /; s/$/    /'
}
function center_text() {
  local text="$1"
  local text_length=${#text}                # Get the length of the text
  local padding=$(((80 - text_length) / 2)) # Calculate padding
  # Print the text with padding
  printf "%${padding}s%s\n" "" "$text"
}
print_right_aligned() {
    local text="$1"
    local length=80
printf "%${length}s\n" "$text"
}
function indent() {
  local indentSize=2
  local indent=1
  if [ -n "$1" ]; then indent=$1; fi
  pr -to $((indent * indentSize))
}
function intro_script(){
format_text "Markchad configuration installation script, custom NvChad configuration for Markdown code."
printf "\n\n"
format_text "Tthe features provided are:"
printf "${italic}%s\n\n" " "
format_text4 " * System check for required dependencies (commands and paths)"
printf "\n"
format_text4 " * Backup pre-existing configurations"
printf "\n"
format_text4 " * Installation of the configuration as the main editor, replacing the standard Neovim configuration, or as a secondary editor alongside the main editor"
printf "%s${clear}\n\n" " "
format_text "For more information visit the dedicated Help section."
printf "\n"
}
# Define the menu entries
menu_entries=(
  "    1) Check the environment"
  "    2) Backup & Restore"
  "    3) Install as Nvim"
  "    4) Install as Markchad"
  "    h) Help"
  "    q) Quit the script"
)

# Function for check requirements
function check() {
  clear
  source libs/check
}

# Function for backup restore
function backup() {
  clear
  source libs/backup
  # press_enter_or_quit
}

# Function for install as nvim
function nvim_install() {
  EDITOR_DIR="nvim"
  source libs/install_release
}

# Function for install as markchad
function markchad_install() {
  EDITOR_DIR="markchad"
  source libs/install_release
}

# Function for help system
function help() {
  source libs/help
}

# Function to display the menu
function show_menu() {
  center_text "Select an option:"
  printf "\n"
  for i in "${!menu_entries[@]}"; do
    printf "\t%-30s" "${menu_entries[$i]}" # Increased space to 30
    # Print a newline after every second entry for two-column display
    if (((i + 1) % 2 == 0)); then
      printf "\n"
    fi
  done
  printf "\n" # Final newline for spacing
}

# Main loop
while true; do
  clear
  cat libs/logo.txt
  printf "\n"
  intro_script
  printf "\n"
  show_menu
  read -r -p "                          Enter your choice: " choice

  case $choice in
  1) check ;;
  2) backup ;;
  3) nvim_install ;;
  4) markchad_install ;;
  h) help ;;
  q)
    printf "  Exiting...\n"
    exit 0
    ;;
  *) printf "  Invalid choice. Please try again.\n" ;;
  esac
  echo ""
done
