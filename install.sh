#!/bin/bash

# Print pretty color output
#  $1: The message to be printed with the color level
#  $2: The message level
#    s = success | w = warning | e = error | i = information | l = log
function printc(){
	CLEAR_COLOR="\033[0m"
	l=$2
	msg=$1
	if [ "$l" = "s" ];then # success
		PRIMARY_COLOR="\033[36;01m"
	fi
	if [ "$l" = "w" ];then # warning
		PRIMARY_COLOR="\033[33;01m"
	fi
	if [ "$l" = "e" ];then # error
		PRIMARY_COLOR="\033[31;01m"
	fi
	if [ "$l" = "i" ];then # info
		PRIMARY_COLOR="\033[34;01m"
	fi
	if [ "$l" = "l" ];then # log
		PRIMARY_COLOR="\033[0;01m"
	fi
	if [ "$l" = "d" ];then # default log
		PRIMARY_COLOR="\033[0m"
	fi

	printf "$PRIMARY_COLOR$msg$CLEAR_COLOR"
}

function check_execution(){
	if [ ! "$?" -eq "0" ];then
		printc " ... Error!\n" "e"
		if [ "$1" = "exit" ];then
			printc "Exiting ...\n" "l"
			exit 1
		fi
	else
		printc " ... OK\n" "i"
	fi

}

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME="/home/$USER_NAME"
if [ ! -d "$USER_HOME" ]; then
	printc "User not found!\n" "e"
	exit 1
fi

cp_neovim() {
	printc "\nCopy nvim to $USER_HOME/.config ...\n" "i"
	cp -r ./nvim "$USER_HOME/.config/nvim"
	sudo chown  "$USER_NAME:$USER_NAME" "$USER_HOME/.config/nvim"
}

cp_tmux() {
	printc "\nCopy .tmux.conf to $USER_HOME/.tmux.conf ...\n" "i"
	cp -r ./tmux/.tmux.conf "$USER_HOME/.tmux.conf"
	sudo chown  "$USER_NAME:$USER_NAME" "$USER_HOME/.tmux.conf"
}

cp_vim() {
printc "VIM" "i"
	printc "\nCopy .vimrc to $USER_HOME/.vimrc ..." "i"
	cp -r ./vim/.vimrc "$USER_HOME/.vimrc"
	cp -r ./vim/.vim "$USER_HOME/.vim"
	printc "\nCreating .vim/undodir\n" "i"
	mkdir "$USER_HOME/.vim/undodir" -p
	sudo chown  "$USER_NAME:$USER_NAME" "$USER_HOME/.vimrc"
	sudo chown  "$USER_NAME:$USER_NAME" "$USER_HOME/.vim"
}

cp_alacritty() {
	printc "Copy alacritty.yml to $USER_HOME/.config ...\n" "i"
	cp -r ./alacritty "$USER_HOME/.config/alacritty"
	sudo chown  "$USER_NAME:$USER_NAME" "$USER_HOME/.config/alacritty"
}

_usage(){
cat <<- EOF
Usage: install.sh [OPTION]

OPTION:
  -h, --help       This screen
      --vim        Install vim config
      --nvim       Install neovim config
      --tmux       Install tmux config
      --alacritty  Install alacritty config

PS: If no option, all is installed

EOF
}

case $1 in
        "--vim")
			cp_vim
			;;
        "--nvim")
			cp_neovim
			;;
        "--tmux")
			cp_tmux
			;;
        "--alacritty")
			cp_alacritty
			;;
        "-h")
			_usage
			;;
        "--help")
			_usage
			;;
        *)
			cp_vim
			cp_neovim
			cp_tmux
			cp_alacritty
			;;
esac


printc "Finished ...\n" "s"

