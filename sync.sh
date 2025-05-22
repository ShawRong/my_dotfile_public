#!/bin/zsh
set -e
set -o pipefail

./upload.sh
# Configuration
local REPO_URL="https://github.com/ShawRong/my_dotfile_public.git"
local WORK_DIR="$HOME/Desktop/tmp/dotfiles_temp_$(date +%s)"  # Add timestamp to avoid conflicts

# Associative array for source → target mapping
# Key is the TARGET path, value is the SOURCE path in the repo
typeset -A CONFIG_MAP=(
    ["$HOME/.zshrc"]=".zshrc"        
    ["$HOME/.config/nvim"]=".config/nvim"  # Now points to the whole nvim dir
    #["$HOME/.config/raycast"]=".config/raycast"  # Now points to the whole nvim dir
    #["$HOME/.config/karabiner"]=".config/karabiner"  # Now points to the whole nvim dir
    #["$HOME/Documents/obsidian-library/October/.obsidian"]=".obsidian"  # Now points to the whole nvim dir
    #["$HOME/Documents/obsidian-library/academic/.obsidian"]=".obsidian"  # Now points to the whole nvim dir
    #["$HOME/Documents/obsidian-library/tmp/.obsidian"]=".obsidian"  # Now points to the whole nvim dir
    #["$HOME/Documents/obsidian-library/book/.obsidian"]=".obsidian"  # Now points to the whole nvim dir
)

# Colors for better output
autoload -U colors && colors
local GREEN=$fg[green]
local YELLOW=$fg[yellow]
local RED=$fg[red]
local RESET=$reset_color

# 1. Clone the repository
echo "${GREEN}[1/3]${RESET} Downloading dotfiles..."
mkdir -p "$WORK_DIR" && cd "$WORK_DIR"

if ! git clone --depth 1 "$REPO_URL" "$WORK_DIR/repo"; then
    echo "${RED}Error: Failed to clone repository${RESET}"
    rm -rf "$WORK_DIR"
    exit 1
fi

local REPO_DIR="$WORK_DIR/repo"

# 2. Backup and create symlinks
echo "${GREEN}[2/3]${RESET} Deploying dotfiles..."
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

# 3. Cleanup
#echo "${GREEN}[3/3]${RESET} Cleaning up..."
#rm -rf "$WORK_DIR" || echo "${YELLOW}Warning: Failed to clean up $WORK_DIR${RESET}"

#echo "${GREEN}Done! Dotfiles deployed successfully.${RESET}"
