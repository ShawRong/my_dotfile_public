export PATH="/opt/homebrew/bin:$PATH"
export OLLAMA_HOME="/Volumes/database"
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"

export GOROOT="/usr/local/go"
export GOBIN="$GOROOT/bin"
export PATH="$PATH:$GOBIN"




# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HISTTIMEFORMAT="%Y-%m-%d %T "
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/shawnrong/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# The following lines were added by myself

#########################
# Environment variables #
#########################

#export EDITOR=vim
#export VISUAL=vim
export EDITOR=nvim
export VISUAL=nvim

############
# FUCTIONS #
############


###########
# Aliases #
###########

alias ll='ls -lah'
alias grep='grep --color=auto'
alias editrc="$EDITOR $HOME/.zshrc"
alias sc="source $HOME/.zshrc"
alias pip='pip3'
alias python='python3'
alias lvim="nvim -u ~/.config/nvim/latex.lua"
alias sourcers="source ~/.zshrc"
alias vim="nvim"
alias vscode="code --reuse-window"
alias todotfile='cd ~/Desktop/dotfiles'

alias yabaistart='brew services start yabai'
alias yabairestart='brew services restart yabai'
alias yabaistop='brew services stop yabai'
# this is for temporal using, for hkust cse2 lab only.
alias logincse='ssh msbd5009stu22@csl2wk22.cse.ust.hk'
########################
# Prompt customization #
########################

# All escape codes at http://zsh.sourceforge.net/Doc/Release/Prompt-EXpansion.html

# %F{color} sets the color
# %n is username
# %m is full hostname
# %f resets formatting
# %~ is current working directory
PROMPT='%F{green}%n@%F{cyan}%m:%~%f$> '
# username@hostname:currentdir$> 

# %W is the date 
# %* is time
# %? is the return code of previous command
# $(q.n.y) is a ternary that checks the variable in question %q
#     and outputs value n if it's false or 0, and and value y is output
#     when %q is non-zero.
#     Replace q, n, and y with whatever you want
RPROMPT='%w %* %(?.√.%?)'

##########################
# Keybind mode for shell #
##########################

#For vi mode
# autoload is similar to source, but autoload loaded when the function to be used.
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line # this map key space to edit-command-line. press esc then space to edit command line.

#
# End of lines added by myself

# This is added automatically by brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<



#initial command to run
fortune | cowsay -r

# 启用 ls 颜色
alias ls='ls --color=auto'

# 自定义颜色
export LS_COLORS='di=34:fi=0:ln=36:pi=33:so=35:bd=32;33:cd=32;33:or=31;1;33:mi=31:ex=32;1:*.tar=31;1:*.gz=31;1:*.zip=31;1'
