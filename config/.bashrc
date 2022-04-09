#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="\[\033[01;34m\]\u@\h\[\033[01;91m\]\$\[\033[01;37m\]\w\[\033[01;34m\]>\[$(tput sgr0)\]"

export PATH=~/.npm-global/bin:$PATH
export PATH=~/.local/bin:$PATH

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias badapple='vlc --vout=aa /home/patrik/.ascii_vids/BadApple.mkv'
alias badapple-full='vlc --vout=aa ~/.ascii_vids/BadApple-full.mp4'
alias ytmdl='ytmdl --skip-meta'
alias c='clear'
alias mountboot="sudo mount /dev/nvme0n1p1 /boot"
alias ani-cli="ani-cli -v"
alias sudo="doas"
alias todo="/usr/bin/emacs -nw"
alias emacs="emacs -nw -q"
alias sync="sudo emerge --sync"
alias update="sudo emerge --update --deep --newuse @world"
alias ekern="cd /usr/src/linux && sudo make menuconfig"
alias mkern="sudo /usr/src/linux/rebuild-kernel.sh"
alias fprog="tail -f /var/log/emerge-fetch.log"
