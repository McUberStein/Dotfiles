#################### BEGINNING OF McUberStein's ~/.kshrc ####################
# ~/.kshrc
#
#
#
#
###### PROMPT ######

PS1="$(printf "\033[1;36m[\033[1;35mpatrik\033[1;34m@GentUwU\033[1;36m@\033[1;37m")\${PWD##}$(printf "\033[1;36m]\n\033[1;37m(\033[1;36m~$(print $0)\033[1;37m) \033[1;35m>\033[00m")"

###### SHELL SETTINGS ######

set -o gmacs # NOT vi
set -o histexpand # bash-like !! history expansion
set -o globstar # ** wildcard includes subdirectories
set -o markdirs # add / to the end of directory names from globbing, more readable
set -o showme # show command with expansion by placing ; before it

###### ENVIRONMENT VARIABLES ######

export HISTFILE=~/.ksh_history
export ANDROID_HOME=/opt/android-sdk-update-manager
export PATH=~/.npm-global/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/.cargo/bin:$PATH
export PATH=~/.doomacs/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
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

alias doas="doas "
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
alias fusermount="printf 'Please use the alias \"${DARKRED}feuermount${NOCOLOR}\" instead\n'"
alias echo="printf '${DARKRED}echo${NOCOLOR} is used in Bash\nUse ${DARKRED}print${NOCOLOR} instead\n'"
alias mpc="/usr/bin/ncmpcpp" 
alias mpd-up="systemctl --user enable --now mpd"
alias mpd-down="systemctl --user disable --now mpd"
alias mpd-stat="systemctl --user status mpd"

###### FUNCTIONS ######

squish(){
    if [[ ! -z "$1" && -r "$1" && "$2" == "into" && ! -z "$3" && $(print "$3" | grep -o ".7z") ]]; then
        7z a "$3" -m0=LZMA -mx=9 "$1"
    else
        if [[ -z "$1" ]]; then 
            printf "${DARKRED}No arguments provided\n${NOCOLOR}"
        elif [[ ! -f "$1" && ! -d "$1" ]]; then
            printf "${DARKRED}No such file or directory\n${NOCOLOR}"
        elif [[ ! -r "$1" ]]; then
            printf "${DARKRED}Permission denied\n${NOCOLOR}"
        elif [[ "$2" != "into" ]]; then
            printf "${DARKRED}Syntax error\n${NOCOLOR}"
        elif [[ ! $(print "$3" | grep -o ".7z") ]]; then
            printf "${DARKRED}Invalid archive name\n${NOCOLOR}"
        fi
        print "Usage: squish [FILE or DIR] into [NAME].7z"
    fi
}

ex(){
if [[ -f $1 ]]; then
	case $1 in
		*.tar.bz2)	tar -xjvf $1	;;
		*.tar.gz)	tar -xzvf $1	;;
		*.bz2)		bunzip2 $1	    ;;
		*.rar)		rar x $1	    ;;
		*.gz)		gunzip $1	    ;;
		*.tar)		tar -xvf $1	    ;;
		*.tbz2)		tar -xjvf $1	;;
		*.tgz)		tar -xzvf $1	;;
		*.zip)		unzip $1	    ;;
		*.Z)		uncompress $1	;;
		*.7z)		7z x $1		    ;;
		*.deb)		ar x $1		    ;;
		*.tar.xz)	tar -xvf $1	    ;;
		*.tar.zst)	unzstd $1	    ;;
		*)		printf "${DARKRED}'$1' cannot be extracted via ex()${NOCOLOR}\n" ;;			
	esac
return 0
else
    if [[ -z $1 ]]; then
        printf "${DARKRED}No file specified${NOCOLOR}\n"
    else
	    printf "${DARKRED}'$1' is not a valid file${NOCOLOR}\n"
    fi
return 1
fi
}

checkfor(){
if [[ -f $1 && -r $1 && -d $3 && -r $3 && $2 == "in" ]]; then
	TMPFILE=/tmp/lsdir
	ls $3 > $TMPFILE
	trap 'break' INT TERM 
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
    rm /tmp/lsdir
else
	if [[ -z $1 ]]; then
		printf "${DARKRED}No arguments provided${NOCOLOR}\n"
	elif [[ ! -f $1 ]]; then
	 	printf "${DARKRED}Error: Invalid file${NOCOLOR}\n"
	elif [[ $2 != "in" ]]; then
 		 printf "${DARKRED}Error: Syntax error${NOCOLOR}\n"
	elif [[ ! -d $3 ]]; then
		printf "${DARKRED}Error: Invalid directory${NOCOLOR}\n"
    elif [[ ! -r $1 || ! -r $3 ]]; then
        printf "${DARKRED}Error: Permission denied${NOCOLOR}\n"
    fi
print "Usage: checkfor [FILE] in [DIR]"

fi
}

replace(){
    if [[ -f "$1" && -r "$1" && "$2" == "with" && -f "$3" && -r "$3" ]]; then
        touch -mr "$1" "$3"
        mv "$3" "$1"
        printf "${DARKGREEN}File $1 replaced with $3${NOCOLOR}\n"
    else
        if [[ -z "$1" || -z "$3" ]]; then
            printf "${DARKRED}No file provided${NOCOLOR}\n"
        elif [[ -d "$1" || -d "$3" ]]; then
            printf "${DARKRED}Directories are not supported${NOCOLOR}\n"
        elif [[ ! -f "$1" || ! -f "$3" ]]; then
            printf "${DARKRED}No such file${NOCOLOR}\n"
        elif [[ ! -r "$1" || ! -r "$3" ]]; then
            printf "${DARKRED}Permission denied${NOCOLOR}\n"
        elif [[ "$2" != "with" ]]; then
            printf "${DARKRED}Syntax error${NOCOLOR}\n"
        fi
        print "Usage: replace [FILE] with [FILE]"   
    fi
}

countword(){
	if [[ ! -z $1 && -r $3 && -f $3 && $2 == "in" ]]; then
		printf "${DARKCYAN}$(cat "$3" | grep -oi "$1" | wc -l)${NOCOLOR}\n" 
        return 0
    elif [[ ! -z $1 && -r $3 && -d $3 && $2 == "in" ]]; then
        printf "${DARKCYAN}$(ls "$3" | grep -oi "$1" | wc -l)${NOCOLOR}\n"
        return 0
    else
		if [[ -z $1 ]]; then
			printf "${DARKRED}Error: No word provided${NOCOLOR}\n"
		elif [[ $2 != "in" ]]; then
			printf "${DARKRED}Error: Syntax error${NOCOLOR}\n"
        elif [[ ! -f $3 && ! -d $1 ]]; then
			printf "${DARKRED}Error: Invalid file or directory${NOCOLOR}\n"
        elif [[ ! -r $3 ]]; then
            printf "${DARKRED}Error: Permission denied${NOCOLOR}\n"
        fi
	print "Usage: countword [WORD] in [FILE or DIR]"
	   return 1
    fi
}

sizeof(){
	if [[ -r $1 ]]; then
		size_t=$(du -sh $1 2> /dev/null | awk '{print $1}')
		printf "${DARKCYAN}$size_t${NOCOLOR}\n" 
        return 0
    else
        if [[ -z $1 ]]; then
		    printf "${DARKRED}Error: No file provided${NOCOLOR}\n"
        elif [[ ! -f $1 && ! -d $1 ]]; then
		    printf "${DARKRED}Error: No such file or directory${NOCOLOR}\n"
	    elif [[ ! -r $1 ]]; then
		    printf "${DARKRED}Error: Permission denied${NOCOLOR}\n"
	    fi
    print "Usage: sizeof [FILE or DIR]"
    return 1
    fi
}

isdigit() {
    if [[ ! -z "$1" && -z "$2" ]]; then
        if [[ $1 =~ ^[0-9]+$ ]]; then
            printf "${DARKCYAN}$1 is a number${NOCOLOR}\n"
            return 0
        else
            printf "${RED}$1 is not a number${NOCOLOR}\n"
            return 1
        fi
    else
        if [[ -z "$1" ]]; then
            printf "${DARKRED}No argument provided"
        elif [[ ! -z "$2" ]]; then
            printf "${DARKRED}Too many arguments provided${NOCOLOR}\n"
        fi
    print "Usage: isdigit [EXPRESSION]"    
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

strlen(){
    if [[ ! -z $1 && -z $2 ]]; then
        LEN=$(print -n "$1" | wc -c)
        printf "${DARKCYAN}${LEN}${NOCOLOR}\n"
        return 0
    else
        if [[ ! -z $2 ]]; then
            printf "${DARKRED}Too many arguments provided\n${NOCOLOR}"
        elif [[ -z $1 ]]; then
            printf "${DARKRED}No arguments provided${NOCOLOR}\n"
        fi
        print "Usage: strlen [STRING or VARIABLE]"
        return 1
    fi
}

sprintf() {
if [[ ! -z "$1" && ! -z "$2" ]]; then
    printf -v "$1" "${@:2}"
else
    if [[ -z "$1" ]]; then
        printf "${DARKRED}No variable provided${NOCOLOR}\n"
    elif [[ -z "$2" ]]; then
        printf "${DARKRED}No format provided${NOCOLOR}\n"
    fi
    print "Usage: sprintf [VARIABLE] [FORMAT]\nVARIABLE: Variable name without \"\$\"\nFORMAT: C-like syntax"
fi
}

feuermount(){
    'fusermount' $@ 2>&1 | awk '{sub("fusermount", "feuermount"); print}'
}

#################### END OF ~/.kshrc ####################
