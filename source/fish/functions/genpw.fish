set -l LOWERCASE_CHARS 'abcdefghijklmnopqrstuvwxyz'
set -l UPPERCASE_CHARS 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
set -l DIGIT_CHARS '1234567890'
set -l SPECIAL_CHARS ',.-+#!$%&/()=?[]{}*_:;\''

# Secure password generation with special characters.
function genpw
    set BASE_CHARS "$LOWERCASE_CHARS$UPPERCASE_CHARS$DIGIT_CHARS$SPECIAL_CHARS"
    makepasswd -l 32 -n 8 -c "$BASE_CHARS"
end

# Secure password generation without special characters.
function genpw-simple
    set BASE_CHARS "$LOWERCASE_CHARS$UPPERCASE_CHARS$DIGIT_CHARS"
    makepasswd -l 32 -n 8 -c "$BASE_CHARS"
end
