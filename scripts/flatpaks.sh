#!/bin/bash

IFS="#"
APPS=(
	"BitWarden - Password manager#com.bitwarden.desktop"
	"Contrast - Checks contrast between two colors#org.gnome.design.Contrast"
	"Drawing - Simple drawing app#com.github.maoschanz.drawing"
	"Escambo - HTTP API testing#io.github.cleomenezesjr.Escambo"
	"EyeDropper - Color picker#com.github.finefindus.eyedropper"
	"FlatSeal - Flatpak apps permissions GUI#com.github.tchx84.Flatseal"
	"Gimp - Image editor#org.gimp.GIMP"
	"Inkscape - Vector graphics#org.inkscape.Inkscape"
	"Krita - Digital painting#org.kde.krita"
	"MongoDBCompass - MongoDB GUI#com.mongodb.Compass"
	"PinUp - Customize your app list#io.github.fabrialberio.pinapp"
	"Postman - API testing#com.getpostman.Postman"
	"Psequel - PostgreSQL GUI#me.ppvan.psequel"
	"RedisInsight - Redis GUI#com.redis.RedisInsight"
	"Stimulator - Keeps your computer awake#io.github.sigmasd.stimulator"
	"Upscayl - AI Image Upscaler#org.upscayl.Upscayl"
	"Whaler - Docker GUI#com.github.sdv43.whaler"
)

function getName(){
	read -ra parts <<< "$1"
	echo "${parts[0]}"
}

function getPak(){
	read -ra parts <<< "$1"
	echo "${parts[1]}"
}

function installFlatpak() {
	pak=$(getPak "$1")
	flatpak install flathub "$pak"
}


function main() {
	clear -x

	choices=()

	menu() {
		echo "Select the apps you want to install"
		for i in "${!APPS[@]}"; do
			name=$(getName "${APPS[i]}")
			[ $pointer -eq "$i" ] && marker="»" || marker=" "
			[ "${choices[i]}" ]  && bullet="✚" || bullet="·"
			echo "$marker $bullet $name"
		done
		[[ "$msg" ]] && echo "$msg"
		:
	}


	pointer=0

	function moveUp() {
		[[ $pointer -gt 0 ]] && ((pointer--))
		clear -x
	}

	function moveDown() {
		len=${#APPS[@]}-1
		[[ $pointer -lt len ]] && ((pointer++))
		clear -x
	}

	function selectChoice() {
		choices[pointer]="+"
		clear -x
	}

	function unselectChoice() {
		choices[pointer]=""
		clear -x
	}

	function toggleChoice() {
		[[ "${choices[$pointer]}" ]] && choices[pointer]="" || choices[pointer]="+"
		clear -x
	}

	prompt="
⬆ ⬇ 🅹 🅺 : move selector
⬅ ⮕ 🅷 🅻 : uncheck and check option
 ❪SPACE❫: toggle option
 ❪ENTER❫: install selected apps
"
	while menu && read -s -n 1 -rp "$prompt" key && [[ "$key" ]]; do
		case "$key" in
			" ") toggleChoice && continue;;
			"l") selectChoice && continue;;
			"h") unselectChoice && continue;;
			"j") moveDown && continue;;
			"k") moveUp && continue;;
			$'\x1B') # Check for escape sequence (arrow keys)
				read -r -s -n 2 -t 0.001 key # Read next two characters
				case "$key" in
					"[A") moveUp && continue;; # Up arrow pressed
					"[B") moveDown && continue;; # Down arrow pressed
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

	for ((num=0; num <= ${#APPS[@]} -1; num++)); do
		[ -n "${choices[$num]}" ] && installFlatpak "${APPS[$num]}"
	done
}

main
