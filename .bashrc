#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fastfetch

alias ff='fastfetch -c examples/10 -l arch3'
alias ffl='fastfetch'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias neofetch='fastfetch -c neofetch -l arch3'
alias update-grub='grubmkconfig -o /boot/grub/grub.cfg'
PS1='[\u@\h \W]\$ '

export THEME=$HOME/.bash/themes/agnoster-bash/agnoster.bash
if [[ -f $THEME ]]; then
    export DEFAULT_USER=`whoami`
    source $THEME
fi
