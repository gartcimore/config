#!/usr/bin/env bash

printf "Do you wish to install additional tools ? (brew, bat, thefuck)\n"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) make install;
        # Check to see if Homebrew is installed, and install it if it is not
        command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; \
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; };
        brew install bat;
        brew install thefuck;
        break;;
        No )
        printf "proceed to copying samples\n";
        break;;
    esac
done


BASHFILE=""
case "$OSTYPE" in
  linux*)   printf "Linux / WSL\n"; BASHFILE=".bashrc" ;;
  darwin*)  printf "darwin (macos)\n";BASHFILE=".bash_profile" ;;
  #win*)     echo "Windows" ;;
  #msys*)    echo "MSYS / MinGW / Git Bash" ;;
  #cygwin*)  echo "Cygwin" ;;
  #bsd*)     echo "BSD" ;;
  #solaris*) echo "Solaris" ;;
  *)        echo "unknown: $OSTYPE"; exit ;;
esac

printf "appending to ${HOME}/${BASHFILE} \n"
if [  -f ${HOME}/${BASHFILE} ]; then
    cat <<\EOF >> ${HOME}/${BASHFILE}
###### sample below ######
EOF
    cat .bash_profile >> ${HOME}/${BASHFILE}
else
  cp .bash_profile ${HOME}/${BASHFILE}
fi

printf "appending to .ssh/config \n"
if [  -f ${HOME}/".ssh/config" ]; then
    cat <<\EOF >> ${HOME}/".ssh/config"
###### sample below ######
EOF
    cat config >> ${HOME}/".ssh/config"
else
  cp config ${HOME}/".ssh/config"
fi
