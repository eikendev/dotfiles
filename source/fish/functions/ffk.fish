function ffk -d "Interactively select and kill processes with fzf"
	if test (id -u) -ne 0
		set pid (ps -f -u (id -u) | sed 1d | fzf -m --height=22 | awk '{print $2}')
	else
		set pid (ps -ef | sed 1d | fzf -m --height=22 | awk '{print $2}')
	end

	if test -n "$pid"
		set signal (or $argv[1] 9)
		echo $pid | xargs kill -$signal
	end
end
