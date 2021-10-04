#!/bin/sh

UNAME=$( command -v uname);

USER="linux";
FROM_PRE_COMMIT_PATH="./src/linux-pre-commit";
TO_PRE_COMMIT_PATH="../.git/hooks/pre-commit";
echo $( "${UNAME}" | tr '[:upper:]' '[:lower:]');
case $( "${UNAME}" | tr '[:upper:]' '[:lower:]') in
  msys*|cygwin*|mingw*)
    # or possible 'bash on windows'
    USER="windows"
	FROM_PRE_COMMIT_PATH=".\\src\\windows-pre-commit";
	TO_PRE_COMMIT_PATH="..\\.git\\hooks\\pre-commit";
    ;;
  nt|win*)
    USER="windows"
	FROM_PRE_COMMIT_PATH=".\\src\\windows-pre-commit";
	TO_PRE_COMMIT_PATH="..\\.git\\hooks\\pre-commit";
    ;;
esac

if [ -e "$TO_PRE_COMMIT_PATH" ];
then
	PRE_COMMIT_EXISTS=1
else
	PRE_COMMIT_EXISTS=0
fi
cp "$FROM_PRE_COMMIT_PATH" "$TO_PRE_COMMIT_PATH"
if [ "$USER" = "linux" ];
then
	chmod +x "$TO_PRE_COMMIT_PATH"
fi

if [ "$PRE_COMMIT_EXISTS" = 0 ];
then
    echo "Pre-commit git hook is installed!"
else
    echo "Pre-commit git hook is updated!"
fi