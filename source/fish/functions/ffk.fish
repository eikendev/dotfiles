function ffk -d "Interactively select and kill processes with fzf"
	if test (id -u) -ne 0
		set pid (ps -f -u (id -u) | sed 1d | fzf -m --height=22 | awk '{print $2}')
	else
		set pid (ps -ef | sed 1d | fzf -m --height=22 | awk '{print $2}')
	end

	if test -n "$pid"
		set -l signal 9
		set -q argv[1]; and set signal $argv[1]
		echo $pid | xargs kill -$signal
	end
end
