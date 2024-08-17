function extract -d "Extract various compressed file formats into a directory"
	set file $argv[1]

	if not test -f "$file"
		printf "Usage: extract <file>\n" >&2
		return 1
	end

	set directory (string split -m 1 '.' $file)[1]
	if test -e "$directory"
		printf "Directory '%s' already exists.\n" "$directory" >&2
		return 1
	end

	mkdir "$directory"
	if test $status -ne 0
		return 1
	end

	mv "$file" "$directory/"
	if test $status -ne 0
		return 1
	end

	cd "$directory"
	if test $status -ne 0
		return 1
	end

	switch "$file"
		case '*.7z'
			7z x "$file"
		case '*.rar'
			unrar x -ad "$file"
		case '*.tar' '*.tar.bz2' '*.tar.gz' '*.tar.xz' '*.tbz2' '*.tgz'
			tar -xvf "$file"
		case '*.bz2'
			bunzip2 "$file"
		case '*.gz'
			gunzip "$file"
		case '*.xz'
			unxz "$file"
		case '*.zip'
			unzip "$file"
		case '*'
			printf "Unknown compression format.\n" >&2
			return 1
	end

	if test $status -ne 0
		printf "Extracting file '%s' failed.\n" "$file"
	else
		printf "Extracting file '%s' was successful.\n" "$file"
	end
end
