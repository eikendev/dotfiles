LOWERCASE_CHARS='abcdefghijklmnopqrstuvwxyz'
UPPERCASE_CHARS='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
DIGIT_CHARS='1234567890'
BASE_CHARS="$LOWERCASE_CHARS$UPPERCASE_CHARS$DIGIT_CHARS"

# Secure password generation.
alias        genpw="makepasswd -l 32 -n 8 -c '$BASE_CHARS,.-+#!$%&/()=?[]{}*_:;'"
alias genpw-simple="makepasswd -l 32 -n 8 -c '$BASE_CHARS'"

unset LOWERCASE_CHARS
unset UPPERCASE_CHARS
unset DIGIT_CHARS
unset BASE_CHARS

# Do not track subsequent commands.
alias incognito='unset HISTFILE'

# Disable ASLR in a new shell.
# See https://askubuntu.com/a/507954.
alias unsafeshell='setarch "$(uname -m)" -R /bin/bash'

# Do not check authenticity when using SSH.
alias unsafessh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
