#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="\[\033[01;36m\]\u@\h\[\033[01;91m\]\$\[\033[01;37m\]\w\[\033[01;36m\]>\[$(tput sgr0)\]"

export PATH=~/.npm-global/bin:$PATH
export PATH=~/.local/bin:$PATH

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias badapple='vlc --vout=aa /home/patrik/.ascii_vids/BadApple.mkv'
alias badapple-full='vlc --vout=aa ~/.ascii_vids/BadApple-full.mp4'
alias ytmdl='ytmdl --skip-meta'
alias c='clear'
alias vnc="x11vnc -display :0"
