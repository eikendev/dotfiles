################################################################################
# AUTOSUGGESTIONS                                                              #
################################################################################

# Prevent autosuggestions when pasting large buffers.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=32

# Use asynchronous fetching.
ZSH_AUTOSUGGEST_USE_ASYNC=1

################################################################################
# FORGIT                                                                       #
################################################################################

FORGIT_FZF_DEFAULT_OPTS="
--height '100%'
$FZF_DEFAULT_OPTS
"

forgit_log=ffgl
forgit_diff=ffgd
forgit_add=ffga
forgit_reset_head=ffgch
forgit_ignore=ffgi
forgit_restore=ffgcf
forgit_clean=ffgclean
forgit_stash_show=ffgs

################################################################################
# SYNTAX HIGHLIGHTING                                                          #
################################################################################

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
