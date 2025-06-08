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
#zstyle :compinstall filename '/home/shawnrong/.zshrc'

autoload -Uz compinit
compinit

#bindkey '^I' expand-or-complete


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
alias sc="source $HOME/.zshrc"
alias pip='pip3'
alias python='python3'
alias lvim="nvim -u ~/.config/nvim/latex.lua"
alias sourcers="source ~/.zshrc"
alias vim="nvim"
alias vscode="code --reuse-window"
alias todotfile='cd ~/Desktop/dotfiles'

# yabai
alias yabai='yabai --start-service'
alias restart_yabai='yabai --restart-service'
alias stop_yabai='yabai --stop-service '
alias yabai_config_load='sh ~/.yabairc'
alias skhd='skhd --start-service'
alias restart_skhd='skhd --restart-service'
alias stop_skhd='skhd--stop-service '

alias desktop='cd ~/Desktop'

#blog
alias blog='cd ~/Desktop/blog/ShawRong.github.io/content/posts'
alias bblog='cd ~/Desktop/blog/ShawRong.github.io/'
alias pushblog="pushd && cd ~/Desktop/blog/ShawRong.github.io && ./upload.sh && popd"

# this is for temporal using, for hkust cse2 lab only.
alias logincse='ssh msbd5009stu22@csl2wk22.cse.ust.hk'

alias sync="~/Desktop/dotfiles/upload.sh & ~/Desktop/dotfiles/sync.sh & source ~/.zshrc & sh ~/.config/.yabairc"
alias crc="$EDITOR ~/Desktop/dotfiles/.zshrc && sync"
alias aloha="echo 'Hello, version 0.11'"

alias omp="/opt/homebrew/opt/llvm/bin/clang -g -Wall -fopenmp"
alias vs="tmux split-window -v"
alias hs="tmux split-window -h"
alias xx="tmux kill-pane"
alias temp='cd ~/Desktop/temp'


## alias max tex commands
## pdflatex

########################
# Prompt customization #
########################

# All escape codes at http://zsh.sourceforge.net/Doc/Release/Prompt-EXpansion.html

#####################
#   git info hint   #
#####################
autoload -Uz vcs_info
precmd() { vcs_info }

# 基础格式：分支名 + 修改状态
zstyle ':vcs_info:git:*' formats '%F{green}(%b%u%c)%f'  # 正常状态
zstyle ':vcs_info:git:*' actionformats '%F{red}(%b|%a%u%c)%f'  # 特殊操作（rebase/merge）

# 检查未暂存/已暂存的修改
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '*'  # 未暂存的修改
zstyle ':vcs_info:git:*' stagedstr '+'    # 已暂存的修改

# 关键修复：启用检测未推送/未拉取的提交
zstyle ':vcs_info:git:*' formats '%F{green}(%b%u%c%m)%f'  # 正常状态
zstyle ':vcs_info:git:*' actionformats '%F{red}(%b|%a%u%c%m)%f'  # 特殊操作
zstyle ':vcs_info:git+set-message:*' hooks git-aheadbehind

# 自定义 Hook：检测未推送（ahead）/未拉取（behind）的提交
+vi-git-aheadbehind() {
    local ahead behind
    local -a gitstatus

    # 检查未推送的提交（ahead）
    ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
    # 检查未拉取的提交（behind）
    behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)

    # 如果有未推送的提交，显示 ⇡N
    (( ahead )) && gitstatus+=( "⇡${ahead}" )
    # 如果有未拉取的提交，显示 ⇣M
    (( behind )) && gitstatus+=( "⇣${behind}" )

    # 更新提示符
    [[ -n $gitstatus ]] && hook_com[misc]+=" ${(j:/:)gitstatus}"
}

setopt prompt_subst
PROMPT='%F{white}%n@%m%f:%F{yellow}%~%f${vcs_info_msg_0_}%f$> '
# username@hostname:currentdir (branch)$> 

# Right prompt
# %W is the date (mm/dd/yy)
# %* is time (hh:mm:ss)
# %? is the return code of previous command
RPROMPT='%W %* %(?.√.%?)'



# auto suggestion
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
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


#auto start
tmux
