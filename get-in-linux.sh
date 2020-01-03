#!/usr/bin/env bash

# @Author: lhw
# @Discription: A script to install program env in linux.
# @Ver. 0.1 alpha

# Download: curl (instead of wget, because curl is installed in almost Linux Distribution now but wget not)
# Mirror: TUNA

### 1. Get System Info
DISTRIBUTION=$(lsb_release -is)

case $DISTRIBUTION in
  'Arch')
    if [[ -z $(cat /etc/pacman.conf | grep -q archlinuxcn) ]]
    then
      echo '[archlinuxcn]'
      echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch'
      sudo pacman -Sy --noconfirm archlinuxcn-keyring
      sudo pacman -Sy yay
    fi
    INSTALLER='yay'
    INSTALL='yay -S --noconfirm'
    UPGRADE='yay -Syu'
    UPDATE='yay -Sy'
    ;;
  'Ubuntu')
    INSTALLER='sudo apt'
    INSTALL='sudo apt install'
    UPGRADE='sudo apt upgrade'
    UPDATE='sudo apt update'
    ;;
  *)
    echo 'Sorry, your distribution is not supported by this script.'
    exit
    ;;
esac

### 2. Define Install Function
# 2.1 Install C Env
install-c(){
  $INSTALL gcc gdb
}
# 2.2 INstall cpp Env
install-cpp(){
  $INSTALL gcc gdb
}
# 2.3 Install Python Env
install-python(){
  $INSTALL python3
  echo "Do you want to install Anaconda Distribution? [y/N]"
  read -r IS_ANA
  if [[ $IS_ANA == 'y'  ]]
  then
    echo 'Which do you want to install?'
    echo '1) Anaconda'
    echo '2) Miniconda'
    read -r IS_MINI
    if [[ $IS_MINI -eq 1 ]]
    then
      sh -c "$(curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh)"
    else
      sh -c "$(curl -fsSL https://repo.anaconda.com/archive/Anaconda2-2019.10-Linux-x86_64.sh)"
    fi
  fi
}
# 2.4 Install Lua Env
install-lua(){
  $INSTALL lua luajit luarocks
}
# 2.5 Install Zsh Env
install-zsh(){
  $INSTALL zsh
  echo 'Do you want to install zsh plugin manager?'
  echo '1) oh my zsh'
  echo '2) zplugin'
  echo '3) antigen'
  read -r ZPLUG
  case $ZPLUG in
    1)
      sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
      ;;
    2)
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
      ;;
    3)
      curl -L git.io/antigen > $HOME/antigen.zsh
      cat < EOF > ~/.zshrc
      # The plugin manager for zsh.
      source $HOME/antigen.zsh

      # Load the oh-my-zsh's library.
      antigen use oh-my-zsh

      # Load the theme
      antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
      SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
      SPACESHIP_TIME_SHOW=true
      SPACESHIP_TIME_PREFIX="["
      SPACESHIP_TIME_SUFFIX="] "
      SPACESHIP_TIME_FORMAT="%D{%Y-%m-%d} %*"
      SPACESHIP_DIR_TRUNC_REPO=false
      SPACESHIP_DIR_PREFIX="["
      SPACESHIP_DIR_SUFFIX="] "

      # Bundles from the default repo (robbyrussell's oh-my-zsh).
      antigen bundle autojump
      antigen bundle bundler
      antigen bundle common-aliases
      antigen bundle colored-man
      antigen bundle extract
      antigen bundle gitfast
      antigen bundle git-extras
      antigen bundle rails
      antigen bundle rake
      antigen bundle ruby
      antigen bundle safe-paste

      # For SSH, starting ssh-agent is annoying
      antigen bundle ssh-agent

      # Plugins not part of Oh-My-Zsh can be installed using githubusername/repo
      antigen bundle zsh-users/zsh-autosuggestions
      # antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh
      antigen bundle zsh-users/zsh-syntax-highlighting

      # Tell Antigen that you're done.
      antigen apply
      EOF

      ;;
    *)

      ;;
  esac
  chsh -s /bin/zsh
  zsh
}
# 2.6 Set TUNA mirror
oh-my-tuna(){
  sudo python "$(curl -fsSL https://tuna.moe/oh-my-tuna/oh-my-tuna.py)" --global
}

while [[ 2 -gt 1 ]]
do
  echo "Now, choose language that you want to get! (0 means exit)"
  echo '1) C'
  echo '2) cpp'
  echo '3) Python'
  echo '4) Lua'
  echo '5) Zsh'
  echo '6) change mirror into TUNA'
  case $LANG_P in
    0)
      exit
      ;;
    1)
      install-c
      ;;
    2)
      install-cpp
      ;;
    3)
      install-python
      ;;
    4)
      install-lua
      ;;
    5)
      install-zsh
      ;;
    6)
      oh-my-tuna
      ;;
    *)
      echo 'Sorry, you choose wrong number, please choose again.'
      ;;
  esac
done



