# Show all 256 different terminal colors.
function term-colors {
	for COLOR in {0..255}; do
		TAG="\033[38;5;${COLOR}m"
		echo -ne "${TAG}████████"
		echo -ne "\e[0m "

		TAG="\033[48;5;${COLOR}m"
		echo -ne "${TAG}        "
		echo -ne "\e[0m "

		echo -ne "(${COLOR})"
		echo
	done
}
