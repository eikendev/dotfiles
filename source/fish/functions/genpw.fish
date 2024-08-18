function genpw -d 'Generate a secure password.'
	set LOWERCASE_CHARS 'abcdefghijklmnopqrstuvwxyz'
	set UPPERCASE_CHARS 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	set DIGIT_CHARS '1234567890'
	set SPECIAL_CHARS ',.-+#!$%&/()=?[]{}*_:;\''

	if test "$argv[1]" = "simple"
		set BASE_CHARS "$LOWERCASE_CHARS$UPPERCASE_CHARS$DIGIT_CHARS"
	else if test "$argv[1]" = "complex"
		set BASE_CHARS "$LOWERCASE_CHARS$UPPERCASE_CHARS$DIGIT_CHARS$SPECIAL_CHARS"
	else
		echo "Usage: genpw <simple|complex>"
		return 1
	end

	makepasswd -l 32 -n 8 -c "$BASE_CHARS"
end
