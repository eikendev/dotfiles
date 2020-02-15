# Check for repeated words recursively.
function find-repeated-words {
	rg --pcre2 "(\b[a-zA-Z]+\b)\s+\1"
}
