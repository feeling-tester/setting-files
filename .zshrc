# Created by newuser for 5.1.1
# 環境変数LANGの設定
export LANG=ja_JP.UTF-8
export PATH="usr/include/python2.7:$PATH"
export LD_LIBRARY_PATH=/usr/include/python2.7
fpath=(/usr/local/share/zsh-completions/src $fpath)

#補完機能設定
autoload -U compinit; compinit

# 入力したコマンドが存在せず、かつディレクトリ名と一致するなら、ディレクトリに cd する
# 例： /usr/bin と入力すると /usr/bin ディレクトリに移動
setopt auto_cd


# もしかして機能
setopt correct

# PCRE 互換の正規表現を使う
setopt re_match_pcre

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst


# プロンプトの設定
# case ${UID} in
#   PROMPT="%B%{[31m%}%/#%{[m%}%b "
#   PROMPT2="%B%{[31m%}%_#%{[m%}%b "
#   SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
#   [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
#   ;;
# *)

#   PROMPT="%{[31M%}%/%%%{[m%} "
#   PROMPT2="%{[31M%}%_%%%{[m%} "
#   SPROMPT="%{[31M%}%r is correct? [n,y,a,e]:%{[m%} "
#   [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
#   ;;
# esac
PROMPT='%{[31m%}%/%#%{[m%}%b ${vcs_info_msg_0_}%(?.%B%F{magenta}.%B%F{blue})%(?!(-ω -%)
< !(>ω <%)
< )%f%b'
RPROMPT=''

# 履歴の保存先
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # 同じコマンドを重複して記録しないようにする
setopt share_history        # コマンド履歴ファイルを共有する

#ターミナルのタイトル編集
case "${TERM}" in
kterm*|xterm|mlterm)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  ;;
esac

# viキーバインド設定
bindkey -v

# 履歴検索機能のショートカット設定
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## 先方予測機能を有効に設定
# autoload predict-on
# predict-on

# カラー設定用の環境変数設定
export LS_COLORS='di=34;01:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# 補完候補一覧をカラー表示する設定
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 補完候補のカーソル選択を有効にする設定
zstyle ':completion:*:default' menu select=1

# コマンドのから表示設定
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ks='ls'
alias rm='rm -i'
# alias TeamSpeak='~/Public/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh'
alias forticlient='/opt/forticlientsslvpn/64bit/forticlientsslvpn'
alias e='emacsclient -nw -a ""'
alias Minecraft="java -jar ~/.minecraft/launcher.jar"
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias にゃーん='echo にゃーん'
alias connect_mie_univ='ssh -2YC mie-univ'
alias alphagcc='/home/yuckey/gem5-stable_2014_02_15/alphaev67-unknown-linux-gnu/bin/alphaev67-unknown-linux-gnu-gcc'
source /opt/ros/kinetic/setup.zsh
alias sql='mysql -u root -p --auto-rehash'
alias gcv='gcvgcv'
function gcvgcv() {
    g++ -ggdb `pkg-config --cflags opencv` $@ `pkg-config --libs opencv`
}
# added by Anaconda3 installer
export PATH="/home/yuckey/anaconda3/bin:$PATH"
alias md="mkdircd"
function mkdircd() {
    mkdir $@ ; cd $@
}
# export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/dist-packages;/usr/local/lib/python2.7/dist-packages
