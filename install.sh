#!/bin/bash

UNINSTALL=false
VIM=false
NVIM=false
TMUX=false
ALACRITTY=false
IS_ROOT=false

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

_usage(){
cat <<- EOF
Usage: install.sh [OPTION]

OPTION:
  -h, --help       This screen
  -a, --all        Install all configs
      --vim        Install vim config
      --nvim       Install neovim config
      --tmux       Install tmux config
      --alacritty  Install alacritty config
  -u, --uninstall  Uninstall the configurations

EOF

exit 0
}

if [ "$#" -eq 0 ]; then
	_usage
fi

printc "\nStarting ...\n" "i"
USER_HOME=$(eval echo ~${SUDO_USER})
USER_NAME="${SUDO_USER:-$USER}"
BASE_DIR=$(echo "${BASH_SOURCE[0]}" | sed 's/install.sh//g')
printc "--> Current user home: $USER_HOME\n" "l"

if [ ! -d "$USER_HOME" ]; then
	printc "--> User not found!\n" "e"
	exit 1
fi

# Check if is root user
if [[ "$(id -u)" -eq "0" ]];then
	IS_ROOT=true
fi

function remove_configuration() {
	program="$1"
	shift
	folders=("$@")
	printc "Cleaning '$program' configuration\n" "i"
	for folder in "${folders[@]}"; do
		if [ -d "$USER_HOME/.config" ]; then
			printc "  Removing '$folder' ..." "i"
			rm -rf "$folder"
			printc " OK\n" "i"
		fi
	done
}

function copy_config() {
	program="$1"
	config_folder="$2"
	shift 2
	array=("$@")

	printc "Copy configuration for '$program' ...\n" "i"
	if [ "$config_folder" = true ]; then
		if [ ! -d "$USER_HOME/.config" ]; then
			mkdir -p "$USER_HOME/.config"
		fi
	fi

	for (( i = 0; i < "${#array[@]}" ; i += 2 )); do
		src="${array[i]}"
		dst="${array[i + 1]}"
		printc "  ---> $dst\n" "i"
		if [ ! -d "$dst" ]; then
			cp -r "$src" "$dst"
		fi
		if [ "$IS_ROOT" = true ]; then
			sudo chown -R "$USER_NAME:$USER_NAME" "$dst"
		fi
	done

}

while [ "$#" -ne 0 ]; do
	case "$1" in
			-u)
				UNINSTALL=true
				;;
			--vim)
				VIM=true
				;;
			--nvim)
				NVIM=true
				;;
			--tmux)
				TMUX=true
				;;
			--alacritty)
				ALACRITTY=true
				;;
			-a | --all)
				VIM=true
				ALACRITTY=true
				NVIM=true
				TMUX=true
				;;
			-h | --help) _usage ;;
			*) _usage ;;
	esac
	shift
done

if [ "$VIM" = true ]; then
	if [ "$UNINSTALL" = false ]; then
		copy_config "vim" false "$BASE_DIR./vim/.vimrc" "$USER_HOME/.vimrc" "$BASE_DIR/vim/.vim" "$USER_HOME/.vim"
	else
		remove_configuration "vim" "$USER_HOME/.vimrc" "$USER_HOME/.vim"
	fi
fi

if [ "$NVIM" = true ]; then
	if [ "$UNINSTALL" = false ]; then
		NVIM_FOLDER="$USER_HOME/.config/nvim"
		copy_config "nvim" true "$BASE_DIR/nvim" "$NVIM_FOLDER"
	else
		remove_configuration "nvim" "$USER_HOME/.config/nvim" "$USER_HOME/.local/share/nvim/"
	fi
fi

if [ "$TMUX" = true ]; then
	if [ "$UNINSTALL" = false ]; then
		copy_config "tmux" false "$BASE_DIR/tmux/.tmux.conf" "$USER_HOME/.tmux.conf"
	else
		remove_configuration "tmux" "$USER_HOME/.tmux.conf"
	fi
fi

if [ "$ALACRITTY" = true ]; then
	if [ "$UNINSTALL" = false ]; then
		copy_config "alacritty" true "$BASE_DIR/alacritty" "$USER_HOME/.config/alacritty"
	else
		remove_configuration "alacirtty" "$USER_HOME/.config/alacritty"
	fi
fi

printc "Finished ...\n" "s"

