#!/usr/bin/env bash

# Directories to search (relative to home directory)
SEARCH_DIRS=("dev" "dotfiles" "lang" "project" "script")

# Function to search for folders
search_folders() {
  local search_term="$1"
  local folders=()

  # Loop through each directory and search for folders
  for DIR in "${SEARCH_DIRS[@]}"; do
    FULL_PATH="$HOME/$DIR"
    while IFS= read -r -d '' folder; do
      folders+=("$folder")
    done < <(find "$FULL_PATH" -type d -name "*$search_term*" -print0)
  done

  # Return the list of folders
  printf "%s\n" "${folders[@]}"
}

# Function to let the user select a folder
select_folder() {
  local folders=("$@")
  if [ ${#folders[@]} -eq 0 ]; then
    echo "No folders found."
    exit 1
  fi

  echo "Found folders:"
  for i in "${!folders[@]}"; do
    echo "$((i + 1)). ${folders[$i]}"
  done

  # Prompt the user to select a folder
  read -p "Enter the number of the folder to open: " choice
  if [[ ! "$choice" =~ ^[0-9]+$ ]] || ((choice < 1 || choice > ${#folders[@]})); then
    echo "Invalid selection."
    exit 1
  fi

  # Return the selected folder
  echo "${folders[$((choice - 1))]}"
}

# Main script logic
if [ -z "$1" ]; then
  # If no folder name is provided, search all folders
  echo "Searching all folders..."
  folders=($(search_folders "*"))
else
  # If a folder name is provided, search for matching folders
  echo "Searching for folders matching '$1'..."
  folders=($(search_folders "$1"))
fi

# Let the user select a folder
selected_folder=$(select_folder "${folders[@]}")

# Open the selected folder in Neovim
echo "Opening '$selected_folder' in Neovim..."
nvim "$selected_folder"
