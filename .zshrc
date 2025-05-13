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

# This is for wsl. It echos the ip of the windows host.
function hostip_wsl {
	host_ip=$(cat /etc/resolv.conf | grep "nameserver" | cut -f 2 -d " ")
	echo $host_ip
}

# This is for change the zsh proxy anytime you need.
function proxy {
	if [[ $# -ne 2 ]]; then
		echo "need ip and port" ; return
	fi
	#proxy ip and port	
	ip=$1 
	port=$2

	export http_proxy="http://$ip:$port"
	export https_proxy="http://$ip:$port"
	echo "$ip:$port"
}

function unproxy() {
	unset http_proxy
	unset https_proxy
	echo "HTTP Proxy unseted"
}

# This is for synchronizing dot rc file to github. 
function syncdotrc {
	source_dir="$HOME"
	des_dir="$HOME/myrc"

	if [ ! -d "$des_dir" ]; then
		mkdir -p "$des_dir"
	fi

	find "$source_dir" -type f -name '.*rc' -exec cp {} "$des_dir"	\;

	cd "$des_dir"

	git add .
	git commit -m "Sync dot rc file to GitHub"
	git push origin main
}




###########
# Aliases #
###########

alias ll='ls -lah'
alias grep='grep --color=auto'
alias zrc="$EDITOR $HOME/.zshrc"
alias scrc="source $HOME/.zshrc"
#alias pp="proxy $(hostip_wsl) 7890"
alias sync="syncdotrc"
alias px="proxychains4"
#alias updateapt="sudo apt update && sudo apt updgrade"
#alias
alias pip='pip3'
alias python='python3'
alias lvim="nvim -u ~/.config/nvim/latex.lua"
alias sourcers="source ~/.zshrc"
alias vim="nvim"
alias changerc='vim ~/.zshrc'
alias vscode="code --reuse-window"

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
