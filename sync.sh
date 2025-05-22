#!/bin/zsh
set -e
set -o pipefail

# Configuration
local REPO_DIR="${0:a:h}"  # Get the directory where this script is located
local WORK_DIR="$PWD"      # Current working directory

# Associative array for source → target mapping
# Key is the TARGET path, value is the SOURCE path relative to the repo
typeset -A CONFIG_MAP=(
    ["$HOME/.zshrc"]=".zshrc"        
    ["$HOME/.config/nvim"]=".config/nvim"

    ["$HOME/.config/raycast"]=".config/raycast"  # Now points to the whole nvim dir
    ["$HOME/.config/karabiner"]=".config/karabiner"  # Now points to the whole nvim dir
    ["$HOME/Documents/obsidian-library/October/.obsidian"]=".obsidian"  # Now points to the whole nvim dir
    ["$HOME/Documents/obsidian-library/academic/.obsidian"]=".obsidian"  # Now points to the whole nvim dir
    ["$HOME/Documents/obsidian-library/tmp/.obsidian"]=".obsidian"  # Now points to the whole nvim dir
    ["$HOME/Documents/obsidian-library/book/.obsidian"]=".obsidian"  # Now points to the whole nvim dir
    # Add other mappings as needed
)

# Colors for better output
autoload -U colors && colors
local GREEN=$fg[green]
local YELLOW=$fg[yellow]
local RED=$fg[red]
local RESET=$reset_color

# Deploy dotfiles
echo "${GREEN}[1/1]${RESET} Deploying dotfiles..."
for target in "${(@k)CONFIG_MAP}"; do
    local source="$REPO_DIR/${CONFIG_MAP[$target]}"
    
    if [[ -e "$source" ]]; then
        # Backup existing file/dir if it's not a symlink
        if [[ -e "$target" && ! -L "$target" ]]; then
            local backup="${target}.bak.$(date +%s)"
            echo "${YELLOW}Backing up $target → $backup${RESET}"
            mv "$target" "$backup" || {
                echo "${RED}Error: Failed to backup $target${RESET}"
                continue
            }
        fi
        
        # Create parent directory if needed
        mkdir -p "$(dirname "$target")" || {
            echo "${RED}Error: Failed to create parent directory for $target${RESET}"
            continue
        }
        
        # Remove existing symlink or file/dir
        [[ -e "$target" ]] && rm -rf "$target"
        
        # Create symlink
        echo "Linking $source → $target"
        if ! ln -sf "$source" "$target"; then
            echo "${RED}Error: Failed to create symlink for $target${RESET}"
        fi
    else
        echo "${YELLOW}Warning: Source not found: $source${RESET}"
    fi
done

echo "${GREEN}Done! Dotfiles deployed successfully.${RESET}"
