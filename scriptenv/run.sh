#!/bin/bash
umask 000

CMD=$1
shift

if [ "$CMD" = "python" ]; then
	exec python3 "$@"
elif [ "$CMD" = "java" ]; then
	exec java "$@"
elif [ "$CMD" = "bash" ]; then
	SCRIPT=$1
	shift
	source $SCRIPT "$@"
else
	echo "Use (python|java|bash) <scripts> [<params>]"
fi
