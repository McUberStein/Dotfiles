#################### BEGINNING OF McUberStein's ~/.kshrc ####################
# ~/.kshrc
#
#
#
#
###### PROMPT ######

PS1="$(printf "\033[1;36m[\033[1;35mpatrik\033[1;34m@GentUwU\033[1;36m@\033[1;37m")\${PWD##}$(printf "\033[1;36m]\n\033[1;37m(\033[1;36m~$(echo $0)\033[1;37m) \033[1;35m>\033[00m")"

###### SHELL SETTINGS ######

set -o gmacs

###### ENVIRONMENT VARIABLES ######

export ANDROID_HOME=/opt/android-sdk-update-manager
export PATH=~/.npm-global/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/.doomacs/bin:$PATH
export EDITOR=/usr/bin/emacs
export VDPAU_DRIVER=nvidia

###### COLORS ######

RED="\001\033\[0;31m"
DARKRED="\001\033\[1;31m"
PURPLE="\001\033\[0;34m"
DARKPURPLE="\001\033\[1;34m"
GREEN="\001\033\[0;32m"
DARKGREEN="\001\033\[1;32m"
CYAN="\001\033\[0;36m"
DARKCYAN="\001\033\[1;36m"
NOCOLOR="\033\[0m\002"

###### ALIASES ######

alias update-grub='mountboot; doas grub-mkconfig -o /boot/grub/grub.cfg'
alias badapple='vlc --vout=aa /home/patrik/.ascii_vids/BadApple.mkv'
alias badapple-full='vlc --vout=aa ~/.ascii_vids/BadApple-full.mp4'
alias yt='ytmdl --skip-meta'
alias ytu="ytmdl --skip-meta --url "
alias c='clear'
alias mountboot="doas mount /dev/nvme0n1p1 /boot"
alias ani-cli="ani-cli -v"
alias sync="doas emerge --sync && doas layman -S"
alias doomacs="emacsclient -nw -c -s doomacs -a 'emacs -nw --with-profile doomacs'"
alias doomacs-gui="emacsclient -c -s doomacs -a 'emacs --with-profile doomacs'"
alias spacemacs="emacsclient -nw -c -s spacemacs -a 'emacs -nw --with-profile spacemacs'"
alias spacemacs-gui="emacsclient -c -s spacemacs -a 'emacs --with-profile spacemacs'"
alias emacs="emacsclient -nw -c -s gnu-emacs -a 'emacs -nw --with-profile default'"
alias emacs-gui="emacsclient -c -s gnu-emacs -a 'emacs --with-profile default'"
alias update="mountboot ; doas emerge --update --deep --newuse @world"
alias fprog="tail -f /var/log/emerge-fetch.log"
alias clean="doas emerge --depclean"
alias cpugovern="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias homemake="make -C ~/"


###### FUNCTIONS ######

ex(){
if [ -f $1 ]; then
	case $1 in
		*.tar.bz2)	tar -xjvf $1	;;
		*.tar.gz)	tar -xzvf $1	;;
		*.bz2)		bunzip2 $1	;;
		*.rar)		unrar $1	;;
		*.gz)		gunzip $1	;;
		*.tar)		tar -xvf $1	;;
		*.tbz2)		tar -xjvf $1	;;
		*.tgz)		tar -xzvf $1	;;
		*.zip)		unzip $1	;;
		*.Z)		uncompress $1	;;
		*.7z)		7z x $1		;;
		*.deb)		ar x $1		;;
		*.tar.xz)	tar -xvf $1	;;
		*.tar.zst)	unzstd $1	;;
		*)		print $'\001\033[1;31m'$1' cannot be extracted via ex()\033[0m\002' ;;			
	esac
else
	print $'\001\033[1;31m'$1' is not a valid file\033[0m\002'
fi
}

checkfor(){
if [[ -f $1 && -d $3 && $2 == "in" ]]; then
	TMPFILE=/tmp/lsdir
	ls $3 > $TMPFILE
	count=$(cat $TMPFILE | wc -l) 
	i=0
	while (($i<=${count}))
	do
		((i++))
		curr="$3/$(awk -v i=$i 'NR==i' $TMPFILE)"
		if [[ ! -f $curr || -d $curr ]]; then
			continue
		fi
		diff -s --binary "$1" "$curr" | sed 's/\/\//\//g' | grep -i identical
	done
else
	if [[ -z $1 ]]; then
		printf "${DARKRED}No arguments provided${NOCOLOR}\n"
	elif [[ ! -f $1 ]]; then
	 	printf "${DARKRED}Error: Invalid file${NOCOLOR}\n"
	elif [[ $2 != "in" ]]; then
 		 printf "${DARKRED}Error: Syntax error${NOCOLOR}\n"
	elif [[ ! -d $3 ]]; then
		printf "${DARKRED}Error: Invalid directory${NOCOLOR}\n"
	fi
print "Usage: lookfor [FILE] in [DIR]"

fi
}

countword(){
	if [[ ! -z $1 && -f $3 && $2 == "in" ]]; then
		printf "${DARKCYAN}$(cat "$3" | grep -oi "$1" | wc -l)${NOCOLOR}\n" 
	else
		if [[ -z $1 ]]; then
			printf "${DARKRED}No word provided${NOCOLOR}\n"
		elif [[ $2 != "in" ]]; then
			printf "${DARKRED}Syntax error${NOCOLOR}\n"
		elif [[ ! -f $3 ]]; then
			printf "${DARKRED}Invalid file${NOCOLOR}\n"
		fi
	print "Usage: countword [WORD] in [FILE]"

	fi
}

sizeof(){
	if [[ -d $1 && -r $1 ]]; then
		size_t=$(ls -lh $1 | awk 'NR==1 {print $2}')
		printf "${DARKCYAN}$size_t${NOCOLOR}\n" 
	elif [[ -f $1 && -r $1 ]]; then
		size_t=$(ls -lh $1 | awk '{print $5}')
		printf "${DARKCYAN}$size_t${NOCOLOR}\n"
	elif [[ -z $1 ]]; then
		printf "${DARKRED}Error: No file provided${NOCOLOR}\n"
	elif [[ ! -r $1 ]]; then
		printf "${DARKRED}Error: Permission denied${NOCOLOR}\n"
	else
		printf "${DARKRED}Error: No such file or directory${NOCOLOR}\n"
	fi
}

rand(){
	if [[ $1 =~ ^[0-9]+$ ]] && (($1 < 99999)); then
		print $(( $RANDOM % $1 ))
	else
		if ! [[ $1 =~ ^[0-9]+$ ]]; then
			printf "${CYAN}Argument not a number\nUsing default${NOCOLOR}\n"
		elif (($1 > 99999)); then
			printf "${CYAN}Argument too big: maximum is 99999\nUsing default${NOCOLOR}\n"
		fi
		print $RANDOM
	fi
}
#################### END OF ~/.kshrc ####################
