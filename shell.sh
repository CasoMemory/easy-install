# confirm system type
sys=`uname -a`

mac="Darwin"
linux="Linux"
empty_str=""

install() {
    # install nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    # make the nvm command active
    source ~/.nvm/nvm.sh

    nvm install --lts

    nvm use --lts

    nv=`nvm -v`
    nov=`node -v`

    # install omz
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # write the .zshrc file
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc

    source ~/.zshrc

    echo "nvm verison is ${nv}, node version is ${nov}"
    echo "Congratulations! All tools installed"
}

if [[ $sys =~ $mac ]]; then
    xcode-select --install

    # install homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # execute
    install
elif [[ $sys =~ $linux ]]; then
    echo "your laptop OS is $sys, start to execute the shell"
    yum install -y git

    check_sudo=`command -v sudo`
    check_chsh=`command -v chsh`
    check_zsh=`command -v zsh`

    # install sudo
    if [[ $check_sudo = "" ]]; then
        yum install sudo -y
    fi

    # install chsh
    if [[ $check_chsh = "" ]]; then
        yum install util-linux-user -y
    fi

    # install zsh
    if [[ $check_chsh = "" ]]; then
        yum install zsh -y
    fi

    zsh

    # execute
    install
else
    echo "your laptop OS is $sys"
fi

