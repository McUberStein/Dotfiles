#!/bin/bash
PS3="Which game would you like to play?: "
options=("Sakura Maid 1" "Sakura Maid 2" "Sakura Maid 3" "Champions of Realms" "My Little Sister Can't Possibly Have A Hemorrhoid!?" "The Grim Reaper That Reaped My Heart" "Back")
select opt in "${options[@]}"


do
    case $opt in
	"Sakura Maid 1")
	    exec "/home/patrik/Pictures/LOST.DIR/DIR/Backup/A/H/BACKUP/Games/Sakura Maid/SakuraMaid1/SakuraMaid.sh" & 
	    ;;
	"Sakura Maid 2")
	    exec "/home/patrik/Pictures/LOST.DIR/DIR/Backup/A/H/BACKUP/Games/Sakura Maid/SakuraMaid2/SakuraMaid2.sh" &
	    ;;
	
	"Sakura Maid 3")
	    exec "/home/patrik/Pictures/LOST.DIR/DIR/Backup/A/H/BACKUP/Games/Sakura Maid/SakuraMaid3/SakuraMaid3.sh" &
	    ;;
	"Champions of Realms")
	    exec "/home/patrik/Pictures/LOST.DIR/DIR/Backup/A/H/BACKUP/Games/ChampionOfRealms-0.63-pc/ChampionOfRealms.sh" > /dev/null & 
	    ;;

	"My Little Sister Can't Possibly Have A Hemorrhoid!?")
	    WINEDEBUG=-all wine /home/patrik/Pictures/LOST.DIR/DIR/Backup/A/H/BACKUP/Games/MLSCPHAH!/hemoimo.exe > /dev/null
	    ;;
	"The Grim Reaper That Reaped My Heart")
	    exec "/home/patrik/Pictures/LOST.DIR/DIR/Backup/A/H/BACKUP/Games/TGRTRMH/Vel.sh" &
	    ;;
	"Back")
	    exec "/home/patrik/ResetPC" && disown
	    exit
	    ;;
	
	*) echo "invalid option $REPLY";;
    esac
done
