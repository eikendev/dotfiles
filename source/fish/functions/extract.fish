function extract -d "Extract an archive into a directory named after it, next to the archive"
	set -l file $argv[1]

	if not test -f "$file"
		printf "Usage: extract <file>\n" >&2
		return 1
	end

	# Strip every extension from the file name, so foo.tar.gz becomes foo.
	set -l archive (path basename $file)
	set -l name (string split -m 1 '.' $archive)[1]

	if test -z "$name"
		printf "Cannot derive a directory name from '%s'.\n" "$file" >&2
		return 1
	end

	set -l directory (path dirname $file)/$name

	if test -e "$directory"
		printf "Directory '%s' already exists.\n" "$directory" >&2
		return 1
	end

	mkdir "$directory"; or return 1
	mv "$file" "$directory/"; or return 1
	cd "$directory"; or return 1

	switch "$archive"
		case '*.7z'
			7z x "$archive"
		case '*.rar'
			unrar x -ad "$archive"
		case '*.tar' '*.tar.bz2' '*.tar.gz' '*.tar.xz' '*.tbz2' '*.tgz'
			tar -xvf "$archive"
		case '*.bz2'
			bunzip2 "$archive"
		case '*.gz'
			gunzip "$archive"
		case '*.xz'
			unxz "$archive"
		case '*.zip'
			unzip "$archive"
		case '*'
			printf "Unknown compression format.\n" >&2
			return 1
	end

	if test $status -ne 0
		printf "Extracting file '%s' failed.\n" "$archive" >&2
		return 1
	end

	printf "Extracting file '%s' was successful.\n" "$archive"
end
