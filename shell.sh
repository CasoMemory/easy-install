# confirm system type
sys=`uname -a`

mac="Darwin"
linux="Linux"

install() {
    # install homebrew
    git clone https://github.com/Homebrew/brew homebrew

    # eval "$(homebrew/bin/brew shellenv)"
    # brew update --force --quiet
    # chmod -R go-w "$(brew --prefix)/share/zsh"

    # install nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    checkNVM=`command -v nvm`

    # install node
    if [[ $checkNVM = "nvm" ]]; then
        nvm install --lts
    else
        chmod +x ~/.nvm/nvm.sh
        nvm install --lts
    fi

    nvm use --lts
    
    # install omz
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


if [[ $sys =~ $mac ]]; then
    xcode-select --install

    # execute
    install
elif [[ $sys =~ $linux ]]; then
    echo "your laptop OS is $sys, start to execute the shell"
    yum install -y git
    
    # execute
    install
else
    echo "your laptop OS is $sys"
fi

