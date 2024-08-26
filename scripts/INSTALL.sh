#!/bin/env bash
# Script di installazione della configurazione personalizzata
# di NvChad per il codice Markdown
clear
# Source files
source libs/messages
source libs/functions
# -------------------
title_green "$title_script"
printf "\n"
# Introduzione
format_text "$intro_script"
printf "\n"
# Controllo dipendenze richieste
nv_vers="$(nvim --version | head -1)"
nv_strip=$(echo "$nv_vers" | tr -cd '[:digit:].')
nv_req="0.10.0"
nv_path=$(command -v nvim)
tmp_dir=".local/tmp"
section_title "$nv_check_title"
if command -v nvim >/dev/null; then
  printf "$nv_check_ok: ${orange}%s${clear}\n" "$nv_path" | indent 4
else
  warning_bar "WARNING - No Neovim Found"
  format_text "$nv_check_no"
  # Neovim Documentation
  printf "${bold_in}%s${bold_out}\n\n" "$neovim_title" | indent 3
  printf "${blue}%s${clear}" "$neovim_install" | indent 5
  printf "${blue}%s${clear}\n\n" "$neovim_install" | indent 5
  # --------------------
  warning_bar "$install_halt"
  exit
fi
if ! printf "$nv_req\n%s\n" "$(nvim --version | grep -io "[0-9][0-9a-z.-]*" | head -n1)" | sort -V -C; then
  warning_bar "$warning - Version Outdated"
  format_text "$nv_vers_req"
  printf "%s ${blue}%s${clear}" "$nv_required" "$nv_req" | indent 8
  printf "%s ${orange}%s${clear}" "$nv_installed" "$nv_strip" | indent 8
  # Neovim Documentation
  printf "\n${bold_in}%s${bold_out}\n\n" "$neovim_title" | indent 3
  printf "${blue}%s${clear}" "$neovim_install" | indent 5
  printf "${blue}%s${clear}\n\n" "$neovim_install" | indent 5
  # --------------------
  printf "  %s" "$info_to_exit"
  press_to_exit
else
  printf "Installed version:   ${orange}%s${clear} " "$nv_vers" | indent 4
fi
section_title "$msg_nv_exe"
commands=("git" "gcc" "make" "rg" "sqlite3" "lazygit")
messages=("sudo dnf install git -y" "sudo dnf install gcc -y" "sudo dnf install make -y" "sudo dnf install ripgrep -y" "sudo dnf install sqlite -y" "Check the NOTE below")

# Print header
printf "${blue}%-10s %-10s %-10s${clear}\n" "Package" "Status" "Install Cmd" | indent 4
printf "%-10s %-10s %-40s\n" "-------" "------" "-----------" | indent 4

for i in "${!commands[@]}"; do
  if command -v "${commands[i]}" &>/dev/null; then
    status="Installed"
    # exists="Yes"
    # message="${commands[i]} is installed."
    message="  ------  "
  else
    status="Missing"
    # exists="No"
    message="${messages[i]}"
  fi
  printf "${orange}%-10s${clear} %-10s ${bold_in}%-10s${bold_out}\n" "${commands[i]}" "${status}" "${message}" | indent 4
done
# Check each command and exit if one is missing
commands_req=("git" "gcc" "make")
for cmd in "${commands_req[@]}"; do
  if ! command -v "$cmd" &>/dev/null; then
    warning_bar "$warning - Missing required packages"
    format_text "$command_check_info"
    printf "\n"
    printf "  %s" "$info_to_exit"
    press_to_exit
  fi
done
commands_opt=("rg" "sqlite3" "lazygit")
missing_cmd=false
missing_lazygit=false
for cmd in "${commands_opt[@]}"; do
  # Check if the command is missing
  if ! command -v "$cmd" &>/dev/null; then
    missing_cmd=true
    if [[ "$cmd" == "lazygit" ]]; then
      missing_lazygit=true
    fi
  fi
done
if $missing_cmd; then
  printf "\n"
  center_bold_red "$warning - Missing Optional Packages"
  printf "\n"
  format_text "$command_opt_info"
  printf "\n"
  printf "  Press any key to continue.."
  press_to_continue
  if $missing_lazygit; then
    format_text "$lazygit_info"
    printf "\n"
    printf "${bold_in}%s${bold_out}" "$lazygit_inst_1" | indent 4
    printf "${bold_in}%s${bold_out}" "$lazygit_inst_2" | indent 4
    printf "\n"
    printf "  Press any key to continue.."
    press_to_continue
  fi
fi
section_title "Checking installation paths"
# Array of paths to check
paths=("$HOME/.config" "$HOME/.local/share" "$HOME/.local/tmp")
# Function to check and create paths
check_and_create_path() {
  local path="$1"

  if [ -d "$path" ]; then
    printf "${orange}%s${clear} already exists\n" "$path" | indent 4
  else
    mkdir -p "$path"
    if mkdir -p "$path"; then
      printf "${orange}%s${clear} created successfully\n" "$path" | indent 4
    else
      printf "Failed to create directory ${red}%s${clear}\n" "$path" | indent 4
    fi
  fi
}
# Loop through each path and check/create
for path in "${paths[@]}"; do
  check_and_create_path "$path"
done
section_title "Installation of Markchad"
format_text "The system meets the requirements for installation of the Markchad configuration. The configuration can be installed as the main editor (Nvim) or as an additional configuration (Markchad)."
printf "\n"
# Menu for folder choice
# Function to display the horizontal menu
display_menu() {
  printf "Please select the folder:\n\n" | indent 10
  printf "${blue}%s${clear} Nvim   ${blue}%s${clear} Markchad   ${red}%s${clear} Quit\n\n" "[1]" "[2]" "[q]" | indent 8
  printf "\t\t\tEnter your choice: "

  read -r choice
}
# Main loop
while true; do
  display_menu
  case $choice in
  1)
    root_dir="nvim"
    break
    ;;
  2)
    root_dir="markchad"
    break
    ;;
  q)
    printf "\t\tInstallation aborted.\n"
    exit 0
    ;;
  *)
    printf "\t\tInvalid option. Please try again."
    ;;
  esac
  echo # for a new line after the selection message
done
clear
title_green "$title_script"
printf "\n"
# Configurazione delle variabili
config="$HOME/.config/$root_dir"
share_local="$HOME/.local/share/$root_dir"
cache_dir="$HOME/.cache/$root_dir"
backup_nvim="$HOME/backup/$root_dir"
cd "$HOME" || exit
if [ -d "$config" ]; then
  while true; do
    section_title "$backup_title"
    format_text "$backup_info"
    printf "\n"
    printf "${bold_in}%s${bold_out}\n" "$backup_paths" | indent 2
    printf "${orange}%s${clear}\n" "$config" | indent 4
    printf "${orange}%s${clear}\n\n" "$share_local" | indent 4
    printf "${bold_in}%s${bold_out}" "$backup_save_path" | indent 2
    printf "${orange}%s${clear}\n" "$HOME/backup/$root_dir" | indent 4
    printf "\n"
    read -r -p "  Start the backup? (y/n) " yn
    case $yn in
    [Yy]*)
      mkdir -p "$backup_nvim"
      # Copy the first source directory to a subdirectory in the destination directory
      section_title "Copying files"
      if [ -d "$config" ]; then
        rsync -av --quiet --delete "$config" "$backup_nvim/config"
        rsync_status1=$?
        if [ $rsync_status1 -eq 0 ]; then
          printf "${bold_in}Copy:${bold_out} %s\n" "$config" | indent 4
          printf "  ${bold_in}to:${bold_out} %s/config\n" "$backup_nvim" | indent 4
        else
          printf "Copy of %s to %s/config failed with status %s" "$config" "$backup_nvim" "$rsync_status1"
        fi
      else
        printf "Source directory %s does not exist" "$config"
      fi
      # Copy the second source directory to a subdirectory in the destination directory
      if [ -d "$share_local" ]; then
        rsync -av --quiet --delete "$share_local" "$backup_nvim/share_local"
        rsync_status2=$?
        if [ $rsync_status2 -eq 0 ]; then
          printf "${bold_in}Copy:${bold_out} %s\n" "$share_local" | indent 4
          printf "  ${bold_in}to:${bold_out} %s/share_local\n" "$backup_nvim" | indent 4
        else
          printf "Copy of %s to %s failed with status %s" "$share_local" "$backup_nvim/share_local" "$rsync_status2"
        fi
      else
        printf "Source directory %s does not exist" "$share_local"
      fi
      divider_single_green
      center_bold_green "Backup performed correctly"
      divider_single_green
      printf "\n  Press any key to continue.."
      press_to_continue
      break
      ;;
    [Nn]*)
      break
      ;;
    *) echo "Please answer Y/y or N/n" ;;
    esac
  done
  # Rimozione della installazione precedente
  clear
  title_green "$title_script"
  printf "\n"
  section_title "Removing previous installations"
  printf "Removing folder: \n" | indent 2
  printf "${orange}%s${clear}" "$config" | indent 4
  rm -rf "$config"
  if [ -d "$share_local" ]; then
    printf "${orange}%s${clear}" "$share_local" | indent 4
    rm -rf "$share_local"
  else
    printf " Directory %s not present: \e[32mOK\e[0m\n" "$share_local" | indent 4
  fi
  if [ -d "$cache_dir" ]; then
    printf "${orange}%s${clear}: " "$cache_dir" | indent 4
    rm -rf "$cache_dir"
  else
    printf " Directory ${orange}%s${clear} not present: \e[32mOK\e[0m\n" "$cache_dir" | indent 4

  fi
fi
section_title "Start configuration installation"
printf "\n"
printf "${bold_in}%s\n${bold_out}" " Downloading the latest version of the configuration"
curl -L https://github.com/ambaradan/markchad/releases/latest/download/markchad.tar.gz --output $tmp_dir/markchad.tar.gz
printf "\n${bold_in}%s\n${bold_out}" " Extraction of compressed archive: "
tar -xf $tmp_dir/markchad.tar.gz --checkpoint=.1250 --checkpoint-action=dot -C $tmp_dir
section_title "Setup installation"
printf " Copying files: "
cp -r $tmp_dir/markchad/config/nvim/ "$config"
cp -r $tmp_dir/markchad/share/nvim/ "$share_local"
printf " Configuration files copied to: \n"
printf "${orange}%s${clear}\n" "$HOME$config"
printf " Shared files copied to: \n"
printf "${orange}%s${clear}\n" "$HOME$share_local"
section_title "Cleaning temporary files"
rm -rf $tmp_dir/markchad
rm -f $tmp_dir/markchad.tar.gz
if [ -z "$(ls -A $tmp_dir)" ]; then
  rm -rf ~/.local/tmp/
  printf "Folder .local/tmp removed\n"
else
  printf "\n\t${orange}%s${clear} folder not empty: ${orange}%s${clear}\n" "$HOME/$tmp_dir" "Skipped"
fi
divider_single_green
center_bold_green "Installation performed properly"
divider_single_green
if [ "$root_dir" == "markchad" ]; then
  format_text "To start this version of the configuration, it is necessary to use\n for further starts the variablen"
  printf "\n${blue}%s${clear}\n" "NVIM_APPNAME=markchad nvim" | indent 4
else
  printf " To start the new Neovim configuration use the command ${blue}%s${clear}\n\n" "nvim"
fi
divider
cd ~/ || exit
while true; do
  read -r -p " Do you want to start the new configuration? (y/n) " yn
  case $yn in
  [Yy]*)
    if [ "$root_dir" == "nvim" ]; then
      nvim
      break
    else
      NVIM_APPNAME=markchad nvim
      break
    fi
    ;;
  [Nn]*) exit ;;
  *) echo " Please answer Y/y or N/n." ;;
  esac
done
exit
