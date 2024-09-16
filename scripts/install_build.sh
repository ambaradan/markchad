#!/bin/env bash
# Script di installazione della configurazione personalizzata
# di NvChad per il codice Markdown
clear
# Source files
source libs/messages
source libs/functions
# -------------------
# title_green "$title_script"
cat ./libs/logo.txt
printf "\n"
# Introduzione
format_text "Create a configuration of NvChad dedicated to writing documentation with Markdown code by implementing the following features."
printf "\n"
printf "${bold_in}%s${bold_out}\n" "* Automatically set Neovim options for Markdown files" | indent 2
printf "${bold_in}%s${bold_out}\n" "* Highlighting Markdown tags in the buffer" | indent 2
printf "${bold_in}%s${bold_out}\n" "* Providing a zen mode for document editing" | indent 2
printf "\n"
format_text "$intro_script"
printf "\n"
format_text "A README is available for further information about the project and the software needed to run it at:"
printf "\n  ${bold_in}%s\n\n${bold_out}" "https://github.com/ambaradan/markchad/blob/main/README.md"
press_enter_or_quit
# Controllo dipendenze richieste
nv_vers="$(nvim --version | head -1)"
nv_strip=$(echo "$nv_vers" | tr -cd '[:digit:].')
nv_req="0.10.0"
nv_path=$(command -v nvim)
tmp_dir="$HOME/.local/tmp"
tar_name="markchad.tar.gz"
sha256_name="markchad.tar.gz.sha256"
section_title "$nv_check_title"
if command -v nvim >/dev/null; then
  printf "$nv_check_ok: ${orange}%s${clear}\n" "$nv_path" | indent 2
else
  warning_bar "WARNING - No Neovim Found"
  format_text "$nv_check_no"
  # Neovim Documentation
  printf "\n"
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
  printf "Installed version:   ${orange}%s${clear} " "$nv_vers" | indent 2
fi
section_title "$msg_nv_exe"
# commands=("git" "gcc" "make" "rsync" "sqlite3" "rg" "lazygit")
# messages=("sudo dnf install git -y" "sudo dnf install gcc -y" "sudo dnf install make -y" "sudo dnf install rsync -y" "sudo dnf install sqlite -y" "Check the NOTE below" "Check the NOTE below")
print_list_missing
print_if_one_missing header
for cmd in "${commands[@]}"; do
  print_missing_message "$cmd"
done
print_if_one_missing footer
section_title "Checking installation paths"
# Array of paths to check
paths=("$HOME/.config" "$HOME/.local/share" "$HOME/.local/tmp")
# Function to check and create paths
check_and_create_path() {
  local path="$1"

  if [ -d "$path" ]; then
    printf "${orange}%s${clear} already exists\n" "$path" | indent 2
  else
    mkdir -p "$path"
    if mkdir -p "$path"; then
      printf "${orange}%s${clear} created successfully\n" "$path" | indent 2
    else
      printf "Failed to create directory ${red}%s${clear}\n" "$path" | indent 2
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
# backup_nvim="$HOME/backup/$root_dir"
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
      backup_directories "$root_dir"
      divider_single_green
      center_bold_green "Backup performed correctly"
      divider_single_green
      press_enter_or_quit
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
  section_title "Cleaning previous installations"
  printf "${bold_in}  %s${bold_out}\n" "Removing folders:"
  printf "${orange}%s${clear}" "$config" | indent 2
  rm -rf "$config"
  if [ -d "$share_local" ]; then
    printf "${orange}%s${clear}" "$share_local" | indent 2
    rm -rf "$share_local"
  else
    printf "%s not present\n" "$share_local" | indent 2
  fi
  if [ -d "$cache_dir" ]; then
    printf "${orange}%s${clear} " "$cache_dir" | indent 2
    rm -rf "$cache_dir"
  else
    printf "${orange}%s${clear} %s\n" "$cache_dir" "missing" | indent 2
  fi
fi
remove_markchad
section_title "Downloading source files"
printf "\n"
printf "${bold_in}  %s${bold_out}\n" "Downloading the latest version of the configuration"
curl -L https://github.com/ambaradan/markchad/releases/latest/download/$tar_name --output "$tmp_dir"/$tar_name
printf "${bold_in}  %s${bold_out}\n" "Downloading the latest checksum (sha256)"
curl -L https://github.com/ambaradan/markchad/releases/latest/download/$sha256_name --output "$tmp_dir"/$sha256_name
printf "${bold_in}  %s${bold_out}\n" "Checkusm Verification"
cd "$tmp_dir" || exit
# Verify the checksum
sha256sum -c "$sha256_name" --strict --quiet
sha_error=$?
if [[ $sha_error -ne 0 ]]; then
  printf " Error: Checksum verification failed for %s." "$tar_name"
  # return 1
fi

printf "Checksum verification successful for ${bold_in}%s${bold_out}." "$tar_name" | indent 1
cd "$OLDPWD" || exit
# return 0
printf "\n"
section_title "Start configuration installation"
printf "\n${bold_in}  %s${bold_out}\n" "Extraction of compressed archive: "
printf "%s\n" "Extraction of the Markchad archive" | indent 2
tar -xf "$tmp_dir"/markchad.tar.gz -C "$tmp_dir"
tar_status=$?
if [ $tar_status -eq 0 ]; then
  printf "${green}%s${clear}" "Tar archive extracted successfully" | indent 2
else
  printf "${red}%s${clear}" "Failed to extract tar archive." | indent 2
  exit 1
fi
section_title "Setup installation"
cp -r "$tmp_dir"/markchad/config/nvim/ "$config"
cp -r "$tmp_dir"/markchad/share/nvim/ "$share_local"
if [ "$root_dir" == "markchad" ]; then
  cp "$tmp_dir"/markchad/add-on/peek-markchad.lua "$config/lua/plugins/peek.lua"
fi
printf "${bold_in}  %s${bold_out}\n" "Configuration files copied to:"
printf "${orange}%s${clear}\n" "$HOME$config" | indent 2
printf "${bold_in}  %s${bold_out}\n" "Shared files copied to:"
printf "${orange}%s${clear}\n" "$HOME$share_local" | indent 2
remove_markchad
divider_single_green
center_bold_green "Installation performed properly"
divider_single_green
if [ "$root_dir" == "markchad" ]; then
  format_text "To start this version of the configuration, it is necessary to use for further starts the variable NVIM_APPNAME."
  printf "\n${bold_in}%s${bold_out}\n" "NVIM_APPNAME=markchad nvim" | indent 4
  printf "\n"
  format_text "To install the language server required for the correct execution of the configuration, run, when first opened, the command:"
  printf "\n${bold_in}%s${bold_out}\n" ":MasonInstallAll" | indent 4
else
  printf "To start the new Neovim configuration use the command ${bold_in}%s${bold_out}\n\n" "nvim" | indent 1
  printf "\n"
  format_text "To install the language server required for the correct execution of the configuration, run, when first opened, the command:"
  printf "\n${bold_in}%s${bold_out}\n" ":MasonInstallAll" | indent 4
fi
printf "\n"
cd ~/ || exit
while true; do
  read -r -p "  Do you want to start the new configuration? (y/n) " yn
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
