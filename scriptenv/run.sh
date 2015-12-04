#!/bin/bash
umask 000

CMD=$1
shift

if [ "$CMD" = "python" ]; then
	exec python3 "$@"
fi

if [ "$CMD" = "java" ]; then
	exec java "$@"
fi
