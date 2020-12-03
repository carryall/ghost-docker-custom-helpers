#!/bin/bash
set -o errexit

# INFO: $GHOST_VERSION is a globally available variable
# executing the tool that installs our custom helpers
node ./_tools/helper-adder.js

baseDir="$GHOST_INSTALL/content.orig"
	for src in "$baseDir"/*/ "$baseDir"/themes/*; do
		src="${src%/}"
		target="$GHOST_CONTENT/${src#$baseDir/}"
		mkdir -p "$(dirname "$target")"
		if [ ! -e "$target" ]; then
			tar -cC "$(dirname "$src")" "$(basename "$src")" | tar -xC "$(dirname "$target")"
		fi
	done

node updateConfig.js