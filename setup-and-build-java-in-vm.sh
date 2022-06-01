#!/usr/bin/env bash
set -e
APP_DIR=/vagrant_data

echo -- preparing vm --
vagrant up
echo "machine needs to be reloaded for envs to update"


echo -- running build command --

vagrant-command () {
    COMMAND="vagrant powershell --timestamp --elevated --command \"cd ${APP_DIR}; ${@}\""
    echo "running (${COMMAND})"
    bash -c "${COMMAND}"    
}


vagrant-command make images
