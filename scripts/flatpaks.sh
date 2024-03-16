#!/bin/bash

IFS="#"
APPS=(
	"BitWarden - Password manager#com.bitwarden.desktop"
	"Contrast - Checks contrast between two colors#org.gnome.design.Contrast"
	"EyeDropper - Color picker#com.github.finefindus.eyedropper"
	"FlatSeal - Flatpak apps permissions GUI#com.github.tchx84.Flatseal"
	"Gimp - Image editor#org.gimp.GIMP"
	"Inkscape - Vector graphics#org.inkscape.Inkscape"
	"Krita - Digital painting#org.kde.krita"
	"PinUp - Customize your app list#io.github.fabrialberio.pinapp"
	"Stimulator - Keeps your computer awake#io.github.sigmasd.stimulator"
	"Upscayl - AI Image Upscaler#org.upscayl.Upscayl"
	"Whaler - Docker GUI#com.github.sdv43.whaler"
)

function installFlatpak() {
	name=$(getName "$1")
	pak=$(getPak "$1")
	echo -e "\e[34mInstalling $name from $pak...\e[0m"
	# flatpak install flathub "$pak" && echo 'ok'
}

function getName(){
	read -ra parts <<< "$1"
	echo "${parts[0]}"
}

function getPak(){
	read -ra parts <<< "$1"
	echo "${parts[1]}"
}


function main() {
	clear -x

	choices=()

	menu() {
		echo "Select the apps you want to install"
		for i in "${!APPS[@]}"; do
			name=$(getName "${APPS[i]}")
			local label=" $((i + 1))) $name"
			[ $pointer -eq "$i" ] && final="+$label" || final="$label"
			[ "${choices[i]}" ] && echo -e "\e[46m\e[30m+$final\e[0m" || echo -e " $final"
		done
		[[ "$msg" ]] && echo "$msg"
		:
	}


	pointer=0
	prompt="Check an option (again to uncheck, ENTER when done): "
	while menu && read -s -n 1 -rp "$prompt" key && [[ "$key" ]]; do
		case "$key" in
			" ") 
				# choices[pointer + 1]="+"
				[[ "${choices[$pointer]}" ]] && choices[pointer]="" || choices[pointer]="+"
				clear -x
				continue
				# Add your action for spacebar press here
			;;
			"l") 
				choices[pointer]="+"
				clear -x
				continue
			;;
			"h") 
				choices[pointer]=""
				clear -x
				continue
			;;
			"j") 
				[[ $pointer -lt ${#APPS[@]} ]] && ((pointer++))
				clear -x
				continue
			;;
			"k") 
				[[ $pointer -gt 0 ]] && ((pointer--))
				clear -x
				continue
			;;
			$'\x1B') # Check for escape sequence (arrow keys)
				read -r -s -n 2 -t 0.001 key # Read next two characters
				case "$key" in
					"[A") # Up arrow pressed
						[[ $pointer -gt 0 ]] && ((pointer--))
						clear -x
						continue
						;;
					"[B") # Down arrow pressed
						[[ $pointer -lt ${#APPS[@]} ]] && ((pointer++))
						clear -x
						continue
						;;
				esac
			;;
			*) 
				msg="Invalid option: $key"
				clear -x
				continue
			;;
		esac
		msg=""
		clear -x
	done
	echo ""

	[ -n "${choices[0]}" ] && installFlatpak "${APPS[0]}"
	[ -n "${choices[1]}" ] && installFlatpak "${APPS[1]}"
	[ -n "${choices[2]}" ] && installFlatpak "${APPS[2]}"
	[ -n "${choices[3]}" ] && installFlatpak "${APPS[3]}"
	[ -n "${choices[4]}" ] && installFlatpak "${APPS[4]}"
	[ -n "${choices[5]}" ] && installFlatpak "${APPS[5]}"
}

main
