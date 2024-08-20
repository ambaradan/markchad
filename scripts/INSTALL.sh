#!/bin/env bash
# Script di installazione della configurazione personalizzata
# di NvChad per il codice Markdown
clear
# Funzioni
function divider() {
  printf -- "-%.0s" $(seq 1 80)
  printf "\n"
}
function confirm() {
  printf "\e[32mOK\e[0m\n"
}
function missing() {
  printf "\x1b[38;5;214mMISSING\e[0m\n"
}
function indent() {
  local indentSize=2
  local indent=1
  if [ -n "$1" ]; then indent=$1; fi
  pr -to $((indent * indentSize))
}

# Variabili Colori
green='\e[32m'
red='\x1b[31m'
blue='\x1b[38;5;81m'
orange='\x1b[38;5;214m'
clear='\e[0m'
bold_in='\033[1m'
bold_out='\033[0m'
divider
printf "${bold_in}${green}%s${clear}${bold_out}\n" "Markchad configuration installation" | indent 4
divider
# Introduzione
printf "The script was created and tested on a Rocky Linux 8.4 system. Consequently,\nall commands refer to a RHEL based system, especially the commands for\ninstalling the required packages, in case you are using another Linux\ndistribution, you should adapt them to your own distribution.\n\n" | indent 1
# Controllo dipendenze richieste
nv_vers="$(nvim --version | head -1)"
nv_strip=$(echo "$nv_vers" | tr -cd '[:digit:].')
nv_req="0.10.0"
nv_path=$(command -v nvim)
tmp_dir=".local/tmp"
printf "${bold_in}%s${bold_out}\n" "Neovim availability check" | indent 2
if command -v nvim >/dev/null; then
  printf "\tExecutable detected: (${orange}%s${clear}): " "$nv_path"
  confirm
else
  printf " ${red}%s${clear}\n No Neovim (${orange}%s${clear}) executable was found to be available on the system in use,\n the configuration requires an installation of Neovim 0.10.0 or higher.\n\n For its installation, reference can be made to the official documentation\n available in the links below.\n\n" "WARNING" "nvim" | indent 2
  printf " ${bold_in}%s\n\n${bold_out}" "Official documentation"
  printf " https://github.com/neovim/neovim/blob/master/INSTALL.md\n"
  printf " https://github.com/neovim/neovim/blob/master/BUILD.md\n\n"
  printf " ${bold_in}%s\n\n${bold_out}" "Installation halted pending availability of minimum requirements."
  exit
fi
if ! printf "$nv_req\n%s\n" "$(nvim --version | grep -io "[0-9][0-9a-z.-]*" | head -n1)" | sort -V -C; then
  printf "\n ${red}%s${clear} detected incompatible version of Neovim:\n\n Version required ${blue}%s${clear}\n Version installed ${orange}%s${clear}\n\n" "WARNING" "$nv_req" "$nv_strip"
  printf " The installed version ${orange}%s${clear} does not meet the minimum requirements\n for a successful installation it is recommended to run an update of Neovim.\n\n" "$nv_vers"
  printf " ${bold_in}%s\n\n${bold_out}" "Official documentation"
  printf " https://github.com/neovim/neovim/blob/master/INSTALL.md\n"
  printf " https://github.com/neovim/neovim/blob/master/BUILD.md\n\n"
  echo " Press any key to terminate the script..."
  # Loop until a key is pressed
  while true; do
    read -rsn1 key # Read a single character silently
    if [[ -n "$key" ]]; then
      printf " Installation aborted due to Neovim incompatibility."
      exit
    fi
  done
  exit
else
  printf "\tInstalled version: ${orange}%s${clear} " "$nv_vers"
  confirm
  printf "\n"
fi
printf " ${bold_in}%s${bold_out}\n" "Required executable control" | indent 2
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
# Scelta della cartella di destinazione
PS3=" Select the destination folder: "
# Menu for defining the destination folder
select root_dir in Nvim Markchad Quit; do
  case $root_dir in
  "Nvim")
    root_dir="nvim"
    break
    ;;
  "Markchad")
    root_dir="markchad"
    break
    ;;
  "Quit")
    printf " Installation aborted\n"
    exit
    ;;
  *)
    printf "Incorrect selection\n"
    ;;
  esac
done
clear
divider
printf "\t${bold_in}${green}%s${clear}${bold_out}\n" "Markchad configuration installation"
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
