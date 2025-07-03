#!/bin/bash

# Specify the directory (current directory in this case)
directory="/home/subby/dotfiles/config/home/.config"
destination="/home/subby/.config"

# Iterate over files in the directory
for file_path in "$directory"/*; do
  file_name=$(basename "$file_path")
  
  if [ -L "$destination/$file_name" ]; then
    # File is already symlinked

      echo "The file is a symbolic link."
  else
    # File isnt symlinked yet
    rm -rf "$destination/$file_name"
    ln -sf "$file_path" "$destination/"
  fi

done
