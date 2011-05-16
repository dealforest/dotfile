zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

_cache_hosts=(`perl -ne  'if (/^Host\s([a-zA-Z0-9.-]+)/) { print "$1\n";}' ~/.ssh/config`)
compctl -k _cache_hosts ssh_screen

autoload colors; colors
case ${UID} in
0)
	PROMPT="%{${fg[red]}%}[%n@%m%1(v|%F{green}%1v%f|)%{${fg[red]}%}]%{${reset_color}%} "
	PROMPT2="%{${fg[red]}%}[%_#]%{${reset_color}%} "
	SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
	;;
*)
	PROMPT="%{${fg[yellow]}%}[%n@%m%1(v|%F{green}%1v%f|)%{${fg[yellow]}%}]%{${reset_color}%}%b "
	PROMPT2="%{${fg[yellow]}%}[%_#]%{${reset_color}%}%b "
	SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
	;;
esac


case "${TERM}" in
"screen")
    preexec() {
	    # see [zsh-workers:13180]
	    # http://www.zsh.org/mla/workers/2000/msg03993.html
	    emulate -L zsh
	    local -a cmd; cmd=(${(z)2})
	}
	;;
esac

if [[ $ZSH_VERSION == (<5->|4.<4->|4.3.<10->)* ]]; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' formats ':(%s)%b'
    zstyle ':vcs_info:*' actionformats ':(%s)%b|%a'
    precmd () {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }
fi
RPROMPT="%{$fg[red]%}[%~]%{$reset_color%} "


HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

if [ -x /usr/bin/screen ]; then
  alias sc='screen -h 4000 -S' dsc='HOME=~/dotfile screen -c ~/dotfile/.screenrc -s zsh -S '
  alias scr='screen -r'
  alias scl='screen -ls'
  alias scd='screen -d'
  alias scx='screen -x'
#   alias ssh='ssh_screen'

#   function ssh_screen() {
#     eval server=\${$#}
#     screen -t $server ssh "$@"
#   }
fi

unsetopt promptcr #改行なくても表示
setopt extended_history
setopt share_history
function history-all { history -E 1 }
setopt autocd 
setopt magic_equal_subst

autoload -U colors
colors

autoload -U compinit
compinit -u

#^]で指定したフォルダを入力
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match \
  '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

# quote previous word in single or double quote
autoload -U modify-current-argument
_quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey '^[s' _quote-previous-word-in-single

_quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-double
bindkey '^[d' _quote-previous-word-in-double

#補完候補をemacs操作で移動
zstyle ':completion:*:default' menu select=1


autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified


bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end 
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
