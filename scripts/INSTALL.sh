#!/bin/env bash
# Script di installazione della configurazione personalizzata
# di NvChad per il codice Markdown
clear
# Source files
source libs/messages
source libs/functions
# -------------------
title_msg "$title_script"
printf "\n"
# Introduzione
format_text "$intro_script"
printf "\n"
# Controllo dipendenze richieste
nv_vers="$(nvim --version | head -1)"
nv_strip=$(echo "$nv_vers" | tr -cd '[:digit:].')
nv_req="0.11.0"
nv_path=$(command -v nvim)
tmp_dir=".local/tmp"
section_title "$nv_check_title"
if command -v nvim >/dev/null; then
  printf "\n$nv_check_ok: ${orange}%s${clear}\n" "$nv_path" | indent 7
else
  print_centered_red_text "$warning - No Neovim Found"
  format_text "$nv_check_no"
  # Neovim Documentation
  printf "\n${bold_in}%s${bold_out}\n\n" "$neovim_title" | indent 3
  printf "${blue}%s${clear}" "$neovim_install" | indent 5
  printf "${blue}%s${clear}\n\n" "$neovim_install" | indent 5
  # --------------------
  print_centered_red_text "$install_halt"
  exit
fi
if ! printf "$nv_req\n%s\n" "$(nvim --version | grep -io "[0-9][0-9a-z.-]*" | head -n1)" | sort -V -C; then
  printf "\n"
  print_centered_red_text "$warning - Version Outdated"
  printf "\n"
  format_text "$nv_vers_req"
  printf "\n"
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
  printf "Installed version:   ${orange}%s${clear} " "$nv_vers" | indent 7
fi
section_title "$msg_nv_exe"
commands=("git" "gcc" "make" "rg" "sqlite3" "lazygit")
messages=("sudo dnf install git -y" "sudo dnf install gcc -y" "sudo dnf install make -y" "sudo dnf install ripgrep -y" "sudo dnf install sqlite -y" "Check the README.md")

# Print header
printf "${blue}%-10s %-10s %-10s${clear}\n" "Package" "Status" "Install Cmd" | indent 7
printf "%-10s %-10s %-40s\n" "-------" "------" "-----------" | indent 7

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
  printf "${orange}%-10s${clear} %-10s ${bold_in}%-10s${bold_out}\n" "${commands[i]}" "${status}" "${message}" | indent 7
done
# Check each command and exit if one is missing
commands_req=("git" "gcc" "make")
for cmd in "${commands_req[@]}"; do
  if ! command -v "$cmd" &>/dev/null; then
    printf "\n"
    print_centered_red_text "$warning"
    printf "\n"
    format_text "$command_check_info"
    printf "\n"
    printf "  %s" "$info_to_exit"
    press_to_exit
  fi
done
section_title "Checking installation paths"
# Array of paths to check
paths=( "$HOME/.config" "$HOME/.local/share" "$HOME/.local/tmp" )
# Function to check and create paths
check_and_create_path() {
    local path="$1"

    if [ -d "$path" ]; then
        printf "${orange}%s${clear} already exists\n" "$path" | indent 7
    else
        mkdir -p "$path"
        if [ $? -eq 0 ]; then
            printf "${orange}%s${clear} created successfully\n" "$path" | indent 7
        else
            printf "Failed to create directory ${red}%s${clear}\n" "$path" | indent 7
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
title_msg "$title_script"
printf "\n"
# Configurazione delle variabili
conf_dir=".config/$root_dir"
share_dir=".local/share/$root_dir"
cache_dir=".cache/$root_dir"

date=$(date +%m-%d-%Y-%H-%M)
cd ~/ || exit
if [ -d "$conf_dir" ]; then
  while true; do
    printf " Detected a configuration already present in the system in use.\n Back up the configuration ${orange}%s${clear}\n" "$conf_dir"
    divider
    read -r -p " Start the backup? (y/n) " yn
    case $yn in
    [Yy]*)
      # Backup della configurazione esistente
      mkdir -p ~/backup/"$root_dir-$date"
      printf " Creating the backup of ${orange}%s${clear} in the folder: \n\t${orange}%s${clear}" "$root_dir" "$HOME/backup/$root_dir-$date"
      # printf " in the folder ${orange}backup/%s${clear}: " "$root_dir-$date"
      cp -r "$conf_dir" ~/backup/"$root_dir"-"$date"/"$date"-config/
      cp -r "$share_dir" ~/backup/"$root_dir"-"$date"/"$date"-share/
      confirm
      break
      ;;
    [Nn]*)
      break
      ;;
    *) echo "Please answer Y/y or N/n" ;;
    esac
  done
  # Rimozione della installazione precedente
  divider
  printf " ${bold_in}%s${bold_out}\n" "Removing previous installations"
  divider
  printf " Removing folder ${orange}%s${clear}: " "$conf_dir"
  rm -rf "$conf_dir"
  confirm
  if [ -d "$share_dir" ]; then
    printf " Removing folder ${orange}%s${clear}: " "$share_dir"
    rm -rf "$share_dir"
    confirm
  else
    printf " Directory %s not present: \e[32mOK\e[0m\n" "$share_dir"
  fi
  if [ -d "$cache_dir" ]; then
    printf " Removing folder ${orange}%s${clear}: " "$cache_dir"
    rm -rf "$cache_dir"
    confirm
  else
    printf " Directory ${orange}%s${clear} not present: \e[32mOK\e[0m\n" "$cache_dir"
  fi
fi
divider
printf " ${bold_in}%s${bold_out} ${orange}%s${clear}\n" "Start configuration installation" "$root_dir"
divider
printf "${bold_in}%s\n${bold_out}" " Downloading the latest version of the configuration"
curl -L https://github.com/ambaradan/markchad/releases/latest/download/markchad.tar.gz --output $tmp_dir/markchad.tar.gz
divider
printf "${bold_in}%s\n${bold_out}" " Extraction of compressed archive: "
tar -xf $tmp_dir/markchad.tar.gz --checkpoint=.1650 --checkpoint-action=dot -C $tmp_dir
confirm
divider
printf " ${bold_in}%s\n${bold_out}" "Setup installation"
printf " Copying files: "
cp -r $tmp_dir/markchad/config/nvim/ "$conf_dir"
cp -r $tmp_dir/markchad/share/nvim/ "$share_dir"
confirm
printf " Configuration files copied to: \n\t${orange}%s${clear}\n" "$HOME/$conf_dir"
printf " Shared files copied to:\n\t${orange}%s${clear}\n" "$HOME/$share_dir"
printf " Cleaning temporary files: "
rm -rf $tmp_dir/markchad
rm -f $tmp_dir/markchad.tar.gz
if [ -z "$(ls -A $tmp_dir)" ]; then
  rm -rf ~/.local/tmp/
  confirm
else
  printf "\n\t${orange}%s${clear} folder not empty: ${orange}%s${clear}\n" "$HOME/$tmp_dir" "Skipped"
fi
divider
printf "\t${bold_in}${green}%s${clear}${bold_out}\n" "Installation performed properly"
divider
if [ "$root_dir" == "markchad" ]; then
  printf " ${red}%s${clear}\n To start this version of the configuration, it is necessary to use\n for further starts the variable ${blue}%s${clear}\n\n" "NOTE:" "NVIM_APPNAME"
  printf " ${blue}%s${clear}\n\n" "NVIM_APPNAME=markchad nvim"
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
