# confirm system type
sys=`uname -a`

mac="Darwin"
linux="Linux"

install() {
    # install homebrew
    git clone https://github.com/Homebrew/brew homebrew

    eval "$(homebrew/bin/brew shellenv)"
    brew update --force --quiet
    chmod -R go-w "$(brew --prefix)/share/zsh"

    # install nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    # make the nvm command active
    source ~/.nvm/nvm.sh

    checkNVM=`command -v nvm`

    # install node
    if [[ $checkNVM = "nvm" ]]; then
        nvm install --lts
    else
        chmod +x ~/.nvm/nvm.sh
        nvm install --lts
    fi

    nvm use --lts

    nv=`nvm -v`
    nov=`node -v`

    echo "nvm verison is ${nv}, node version is ${nov}"
}

installTool() {
    if [[ $sys =~ $mac ]]; then
       brew install zsh
    elif [[ $sys =~ $linux ]]; then
        yum -y install zsh
    else
        echo "will support install tools"
    fi

    chsh -s /usr/local/bin/zsh

    chsh -s /bin/zsh

    source ~/.zshrc

    echo "Congratulations! All tools installed"

    kill `ps -A | grep -w Terminal.app | grep -v grep | awk '{print $1}'`
}

if [[ $sys =~ $mac ]]; then
    xcode-select --install

    # execute
    install

    installTool
elif [[ $sys =~ $linux ]]; then
    echo "your laptop OS is $sys, start to execute the shell"
    yum install -y git
    
    # execute
    install

    installTool
else
    echo "your laptop OS is $sys"
fi

