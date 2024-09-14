#!/bin/bash
# Markchad Installation Script
# The script downloads the latest version of install_markchad.tar.gz
# and checks its correctness (sha256sum).
# Extracts it to the '.local/tmp' folder which it creates if missing,
# checks for previous installations and deletes them if present and starts
# the Markchad configuration installation script.
# When finished if all steps were performed without errors it deletes
# all downloaded files from the 'tmp' folder.

# Variables
tmp_dir="$HOME/.local/tmp"
tmp_name="install_markchad"
tar_file="install_markchad.tar.gz"
repo="https://github.com/ambaradan/markchad/releases/latest/download/"
sha256_file="$tar_file.sha256"

# Function to create directory if missing
create_tmp_dir() {
  if [ ! -d "$tmp_dir" ]; then
    mkdir -p "$tmp_dir"
  fi
}
# Function to remove a directory or file with error handling
remove_item() {
  local item_path="$1"
  if [[ -e "$item_path" ]]; then
    rm -rf "$item_path"
    local rm_err=$?
    if [[ $rm_err -eq 0 ]]; then
      return
    else
      printf "Error: Failed to remove %s." "$item_path"
      exit 1
    fi
  else
    return
    # printf "%s does not exist, no action taken." "$item_path" 
  fi
}
# Function to download the tar file
download_tar_file() {
  curl -L -s "$repo/$tar_file" --output "$tmp_dir/$tar_file"
  local tar_err=$?
  if [ $tar_err -eq 0 ]; then
    return
  else
    printf "Download failed!"
    exit 1
  fi
}

# Function to download the SHA-256 checksum file
download_sha256_file() {
  curl -L -s "$repo/$sha256_file" --output "$tmp_dir/$sha256_file"
  local sha256_err=$?
  if [ $sha256_err -eq 0 ]; then
    return
  else
    printf "Checksum file download failed!"
    exit 1
  fi
}

# Function to verify the checksum
verify_checksum() {
  cd "$tmp_dir" || exit
  sha256sum -c "$sha256_file" --ignore-missing --quiet
  local sum_err=$?
  if [ $sum_err -eq 0 ]; then
    return
  else
    printf "Checksum verification failed!"
    exit 1
  fi
}

# Function to extract the tar file
extract_tar_file() {
  tar -xzf "$tmp_dir/$tar_file" -C "$tmp_dir"
  local ext_err=$?
  if [ $ext_err -eq 0 ]; then
    return
  else
    printf "Extraction failed!"
    exit 1
  fi
}
# Function to run the install script
run_install_script() {
  cd "$tmp_dir/$tmp_name" || exit 1
  if [ -f "install_build.sh" ]; then
    chmod +x install_build.sh
    ./install_build.sh
    local inst_err=$?
    if [ $inst_err -eq 0 ]; then
      cd "$OLDPWD" || exit 1
      rm -rf "${tmp_dir:?}"/*"$tmp_name"*
      exit 0
    else
      printf "Installation failed!"
      exit 1
    fi
  else
    printf "install.sh not found in the extracted folder."
    exit 1
  fi
}
# Main script execution
create_tmp_dir
remove_item "$tmp_dir/$tar_file"
remove_item "$tmp_dir/$sha256_file"
remove_item "$tmp_dir/$tmp_name"
download_tar_file
download_sha256_file
verify_checksum
extract_tar_file
run_install_script
