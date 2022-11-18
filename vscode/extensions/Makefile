#!/bin/sh
OUTPUT_FILE=extensions.txt

install:
	cat ${OUTPUT_FILE} | while read extension
	do
		code --install-extension ${extension}
	done

	exit 0

uninstall:
	cat ${OUTPUT_FILE} | while read extension
	do
		code --uninstall-extension ${extension}
	done

	exit 0

output:
	code --list-extensions | xargs -L 1 >> ${OUTPUT_FILE}
