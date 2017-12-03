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

text=$(git status)
changed_text="Changes to be committed"
untracked_files="Untracked files"

dirty=false

if [[ ${text} = *"$changed_text"* ]]; then
		dirty=true
fi

if [[ ${text} = *"$untracked_files"* ]]; then
		dirty=true
fi

if [[ ${dirty} ]]; then
	echo "changes in local repo. prepping to push to remote."
	git add .
	git commit -m "script sync_config.sh commited changes"
	git pull
	git push
else
	echo "No changes in local repo, git pulling and then done."
	git pull
fi
