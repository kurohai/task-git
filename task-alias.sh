#!/usr/bin/env bash


# if [ ! -e ~/.task/pending.data ];
# then
#     mkdir ${HOME}/.task
# 	sudo mount -o bind "${PROJECT_HOME}/task-config" "${HOME}/.task"
#     ln -s ${HOME}/.task/.taskrc ${HOME}/.taskrc
# fi

export TASKDATA=${PROJECT_HOME}/task-config
export TASKRC=${PROJECT_HOME}/task-config/.taskrc-osx

alias task='${PROJECT_HOME}/task-git/task-git.sh'
alias task-git-push='${PROJECT_HOME}/task-git/task-git.sh --task-git-push'



function task-pull() {
    echo "performing git pull"
    cd ${PROJECT_HOME}/task-config/
    git checkout develop
    git pull origin develop
    echo "git pull complete"
}

function task-push() {
    echo "performing git push"
    cd ${PROJECT_HOME}/task-config/
    git checkout develop
    git push -u origin develop
    echo "git push complete"
}

function task-sync() {
    echo "starting task sync"
    task-pull
    task-push
    echo "task sync complete"
}

task-sync
