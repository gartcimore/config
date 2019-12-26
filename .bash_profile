# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt

alias ls="ls -G"
alias ll="ls -lhA"
alias ps="ps -axf"
alias psg="ps -ax | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -pv"
alias wget="wget -c"
alias ping='ping -c 5'
alias dockerps="docker ps --format '{{.ID}} ~ {{.Names}} ~ {{.Status}} ~ {{.Image}}'"

#load ssh keys
if [ -d $HOME/keys ]
then
      ssh-add $HOME/keys/*
fi
ssh-add -k $HOME/.ssh/id_rsa

 [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# need to install thefuck https://github.com/nvbn/thefuck
eval $(thefuck --alias)

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export LESS="-FRXI"
export PAGER="less"

# for maven signing using GPG to work on Macos
GPG_TTY=$(tty)
export GPG_TTY

export CLICOLOR=1
export BUILD_PATH=/tmp/build
export RESULT_PATH=/tmp/build
export VCS_ROOT=$HOME/depots
export UCS9=${VCS_ROOT}/ucs9
export UCS8=${VCS_ROOT}/ucsCore
export UCS8_FORK=${VCS_ROOT}/ucsCorelarustue
export CI=${VCS_ROOT}/brest_ci
export DEV_OPS=${VCS_ROOT}/devops_aws
export GENESYS_DOCKER_ROOT=/vagrant/ucs/ucs-tng/devops

export GIT_USER_PERSO="gartcimore"
export GIT_MAIL_PERSO="gart.algar@gmail.com"

# if you have jenv (for java version switching)
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

depot () {
    cd ${VCS_ROOT}
    [[ ! -z "$1" ]] && cd $1
}

depots () {
  depot $1
}
ucs9 () {
    cd ${UCS9}
}
ucs8 () {
    mkdir -p /tmp/build/
    cd ${UCS8}
}
ucs8f () {
    mkdir -p /tmp/build/
    cd ${UCS8_FORK}
}
ci () {
 cd ${CI}
}


gitconfig () {
 git config user.email $GIT_MAIL_PERSO;
 git config user.name $GIT_USER_PERSO;
}

build () {
 pushd . && ucs9 && mvn package -DskipUnitTests=true -DskipEndToEndTests=true -DskipBenchmarkTests=true && popd
}
copybuild () {
 pushd . && ucs9 && cp distribution/target/lib/*.jar $VCS_ROOT/ucs_ops/images/ucs91/ucs/localbuild/lib/ && popd
}
preparedevcontainer () {
 build && copybuild
}
makedevcontainer () {
 pushd . && preparedevcontainer && cd $VCS_ROOT/ucs_ops/images/ucs91/ucs/ && make build.dev && popd
}

devops () {
    cd $DEV_OPS
}

gendocker () {
 cd $GENESYS_DOCKER_ROOT
}

cloudssh () {
 ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ec2-user@$1
}

cloudssh-esrvp () {
 cloudssh hostname-region.example.com
}

# create compressed file tar.gz from arguments
targz() {
tar -zcvf $1.tar.gz $*
}

# extract provided argument
untargz() {
tar -zxvf $1
}

extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }
## docker

dockersh() {
  docker exec -it $1 /bin/sh
}

dockerprune() {
  docker system prune -af
}

dockerclean() {
  docker rm $(docker ps --all -q -f status=exited)
  docker volume rm $(docker volume ls -qf dangling=true)
}

export PATH=$PATH:.
