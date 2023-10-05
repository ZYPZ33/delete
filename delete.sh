#!/usr/bin/env sh

# This is a custom delete script that relies on:
# - coreutils - specifically the rm and shred commands
# - trash-cli - available in most repositories

# EXAMPLES
#  __________________________________________
# |_Terminal__________________________-_[]_X_|
# |                                          |
# | $ delete Documents/image.jpg             |
# | delete image.jpg? (yes/trash/shred/No) s |
# | image.jpg shredded                       |
# | $ delete -y Downloads/mini.iso           |
# | $                                        |
# |__________________________________________|

for argument in "$@"
do if [ "${argument}" = "-y" ]
then rm -rf $(echo $@|sed 's/\-y//') && exit
elif [ "${argument}" = "-h" ] || [ "${argument}" = "--help" ]
then echo "
 usage

 delete [OPTION]... [FILE]...

 OPTIONS
	-h	show this message
	-y	auto remove everything

 INTERFACE
 	enter y or Y for yes (deletes files)
 	enter t or T for trash (moves files to trash folder)
 	enter s or S for shred (wipes files from computer)
 	enter anything else for no (does nothing to files)" && exit
fi
done


for item in "$@"
	do test ! -e ${item} && echo "${item} does not exist" && continue
	echo -n "delete ${item}? (yes/trash/shred/No) "
	read response
	if [ "${response}" = "y" ] || [ "${response}" = "Y" ] # if yes
		then rm -rf ${item} && echo "${item} deleted"
	elif [ "${response}" = "t" ] || [ "${response}" = "T" ]
		then trash-put ${item}
	elif [ "${response}" = "s" ] || [ "${response}" = "S" ]
		then if [ -f "${item}" ]
			then shred -xvfu ${item} && echo "${item} shredded"
		else echo "${item} is a directory" 1>&2
	fi
	else echo "${item} unaltered."
	fi
done
