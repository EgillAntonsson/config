#!/bin/bash

# NOTE: I'm executing script automatically using a scheduled Jenkins job.

case "$(uname -s)" in
	Linux)
		echo "on Linux"
		vscode_user_dir=~/.config/Code/User/
		os_dir="linux"
		;;
	Darwin)
		echo "on Mac OS X"
		# vscode_user_dir="Library/Application Support/Code/User/"
		os_dir="osx"
		echo "exiting until I've tested on Mac OS X"
		exit 0
		;;
	*)
		echo "not Linux nor OSX, exiting"
		exit 0
		;;
esac

mkdir -p ${os_dir}/vscode
cp -R $vscode_user_dir ${os_dir}/vscode/

nr_of_untracked_files=$(git status --porcelain 2>/dev/null| grep "^??" | wc -l)
nr_of_modified_files=$(git diff --name-only | wc -l)
echo "nr of untracked files ${nr_of_untracked_files}"
echo "nr of modified files ${nr_of_modified_files}"

if [[ (( $nr_of_untracked_files > 0 )) || (( $nr_of_modified_files > 1 )) ]]; then
	echo "changes in local repo. prepping to push to remote."
	git add .
	git commit -m "script sync_config.sh commited changes"
	git pull
	git push
else
	echo "no enough changes to do a push. Doing git pull then "
	# git pull
fi