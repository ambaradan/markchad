#!/bin/env bash
# Script di installazione della configurazione personalizzata
# di NvChad per il codice Markdown
clear
# Source files
source libs/messages
source libs/functions
# -------------------
title_msg "$title_script"
# Introduzione
center_and_format_text "$intro_script"
# Controllo dipendenze richieste
nv_vers="$(nvim --version | head -1)"
nv_strip=$(echo "$nv_vers" | tr -cd '[:digit:].')
nv_req="0.10.0"
nv_path=$(command -v nvim)
tmp_dir=".local/tmp"
section_title "$nv_check_title"
if command -v nvim >/dev/null; then
  nv_check_ok
else
  nv_check_no
  official_doc
  exit
fi
if ! printf "$nv_req\n%s\n" "$(nvim --version | grep -io "[0-9][0-9a-z.-]*" | head -n1)" | sort -V -C; then
  nv_outdated
  nv_outdated_info
  official_doc
  info_to_exit
  press_to_exit
  exit
else
  printf "\tInstalled version: ${orange}%s${clear} " "$nv_vers"
  confirm
fi
section_title "$msg_nv_exe"
req=("git" "gcc" "make")
for req in "${req[@]}"; do
  if command -v "$req" >/dev/null; then
    printf "\tChecking availability ${green}%s${clear}: " "$req"
    confirm
  else
    printf "\tChecking availability ${red}%s${clear}: " "$req"
    missing
    printf "Installable with: ${bold_in}sudo dnf install %s -y${bold_out}\n" "$req" | indent 5

  fi
done
printf " \n ${bold_in}%s${bold_out}\n" "Optional executables control" | indent 2
req=("rg" "sqlite3" "lazygit")
for req in "${req[@]}"; do
  if command -v "$req" >/dev/null; then
    printf "\tChecking availability (optional) ${green}%s${clear}: " "$req"
    confirm
  else
    printf "\tChecking availability (optional) ${red}%s${clear}: " "$req"
    missing
    if [ "$req" = "rg" ]; then
      printf "Installable with: ${bold_in}%s${bold_out}\n" "sudo dnf install ripgrep -y" | indent 5
    fi
    if [ "$req" = "sqlite3" ]; then
      printf "Installable with: ${bold_in}%s${bold_out}\n" "sudo dnf install sqlite -y" | indent 5
    fi
    if [ "$req" = "lazygit" ]; then
      printf "Installable with: ${bold_in}%s${bold_out}\n" "sudo dnf copr enable atim/lazygit" | indent 5
      printf "${bold_in}%s${bold_out}" "sudo dnf install lazygit -y" | indent 14
    fi
  fi
done
# Check paths presence
printf " \n${bold_in}%s${bold_out}\n" " Checking installation paths" | indent 2
dir_path=(".config" ".local/share")
for dir_path in "${dir_path[@]}"; do
  if [ ! -d "$HOME/$dir_path" ]; then
    mkdir -p "$HOME/$dir_path"
    printf "\tCreation of the folder ${orange}%s${clear} " "$dir_path"
    confirm
  else
    printf "\tFolder ${green}%s${clear} already present " "$dir_path"
    confirm
  fi
done
# Creazione, se mancante, della cartella
# '.local/tmp' per le operazioni sui file
if [ ! -d "$HOME/$tmp_dir" ]; then
  mkdir -p "$HOME"/"$tmp_dir"
  printf "\tWork folder ${orange}%s${clear} successfully created " "$tmp_dir"
else
  printf "\tFolder ${green}%s${clear} already present " "$tmp_dir"
fi
confirm
# End check paths
divider
printf "The system meets the requirements for installation of the Markchad\nconfiguration.\nThe configuration can be installed as the main editor (${blue}%s${clear})\nor as an additional configuration (${blue}%s${clear}).\n\n" "Nvim" "Markchad" | indent 3
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
    return
    ;;
  2)
    root_dir="markchad"
    return
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
divider
title_script
divider
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
