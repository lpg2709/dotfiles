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

# # ---- neovim
# printc "\nCopy nvim to $USER_HOME/.config ...\n" "i"
# cp -r ./nvim "$USER_HOME/.config/nvim"

# # ---- tmux
# printc "\nCopy .tmux.conf to $USER_HOME/.tmux.conf ..." "i"
# printc "\nExecuting curl" "i"
# # Copy .tmux.conf to $HOME
# curl -fLo "$USER_HOME/.tmux.conf" https://raw.githubusercontent.com/lpg2709/tmux-conf/master/.tmux.conf -s > /dev/null
# check_execution "exit"

# # ---- vim
# printc "\nInstalling vim-plug ..." "i"
# printc "\nExecuting curl" "i"
# # Install https://github.com/junegunn/vim-plug
# curl -fLo "$USER_HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -s > /dev/null
# check_execution "exit"
#
# printc "\nCopy .vimrc to $USER_HOME/.vimrc ..." "i"
# printc "\nExecuting curl" "i"
# # Copy My-vim-config from git to .vimrc
# curl -fLo "$USER_HOME/.vimrc" https://raw.githubusercontent.com/lpg2709/vim-config/master/.vimrc -s > /dev/null
# check_execution "exit"
#
# printc "\nCreating .vim/undodir\n" "i"
# mkdir "$USER_HOME/.vim/undodir" -p

printc "Finished ...\n" "s"

