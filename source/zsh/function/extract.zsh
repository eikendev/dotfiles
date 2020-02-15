# Extract various compression formats.
function extract {
	local file="$1"

	if ! [ -f "$file" ] ; then
		echo "Usage: $0 <file>" >&2
		return 1
	fi

	local directory=${1%%.*}
	if [ -e "$directory" ] ; then
		echo "Directory '$directory' already exists." >&2
		return 1
	fi

	mkdir "$directory"
	if [ $? -ne 0 ] ; then return 1 ; fi

	mv "$file" "$directory/"
	if [ $? -ne 0 ] ; then return 1 ; fi

	cd "$directory"
	if [ $? -ne 0 ] ; then return 1 ; fi

	case "$file" in
		*.7z) 7z x "$file" ;;
		*.rar) unrar x -ad "$file" ;;
		*.tar) tar -xvf "$file" ;;
		*.tar.bz2) tar -xvf "$file" ;;
		*.bz2) bunzip2 "$file" ;;
		*.tar.gz) tar -xvf "$file" ;;
		*.gz) gunzip "$file" ;;
		*.tar.xz) tar -xvf "$file" ;;
		*.tbz2) tar -xvf "$file" ;;
		*.tgz) tar -xvf "$file" ;;
		*.xz) unxz "$file" ;;
		*.zip) unzip "$file" ;;
		*)
			echo 'Unknown compression format.' >&2
			return 1
			;;
	esac

	if [ $? -ne 0 ] ; then
		echo "Extractig file '$file' failed."
	else
		echo "Extractig file '$file' was successful."
	fi
}
