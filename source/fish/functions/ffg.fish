# https://news.ycombinator.com/item?id=38475537
function ffg --description "Open a file based on its content"
	rg --ignore-case --color=always --line-number --no-heading "$argv" |
		fzf --ansi \
			--color 'hl:-1:underline,hl+:-1:underline:reverse' \
			--delimiter ':' \
			--preview "bat --color=always {1} --highlight-line {2}" \
			--preview-window 'border-left,+{2}+3/3,~3' \
			--bind "enter:become($EDITOR +{2} {1})"
end
