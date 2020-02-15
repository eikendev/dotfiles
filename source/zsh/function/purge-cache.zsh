# Purge the cache directory carefully.
# This will remove files older than 30 days and remove empty directories.
function purge-cache {
	local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}"
	find "$cache_dir" -type f -mtime +30 -delete
	find "$cache_dir" -type d -empty -delete
}
