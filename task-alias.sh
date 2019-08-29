#!/usr/bin/env bash


export TASKDATA=${PROJECT_HOME}/task-config
if [ "${USER}" = "j2v6" ];
then
    export TASKRC=${TASKDATA}/.taskrc-osx
else
    export TASKRC=${TASKDATA}/.taskrc
fi

TASK_SYNC_LOG_FILE=${TASKDATA}/log/task-sync-`date +%Y-%m-%d`.log
TASK_SYNC_LOCK_FILE=${TASKDATA}/.sync_lock

if [ ! -d "${TASKDATA}/log" ];
then
    mkdir -p "${TASKDATA}/log"
fi

function t() {
    ${PROJECT_HOME}/task-git/task-git.sh $@
}
function task() {
    ${PROJECT_HOME}/task-git/task-git.sh $@
}
function taskp() {
    ${PROJECT_HOME}/task-git/task-git.sh --task-git-push $@
}

# alias task='${PROJECT_HOME}/task-git/task-git.sh'
# alias task-git-push='${PROJECT_HOME}/task-git/task-git.sh --task-git-push'


function task-pull() {
    echo "performing git pull"
    cd "${TASKDATA}"
    git checkout develop
    git pull origin develop
    echo "git pull complete"
    cd "${OLDPWD}"
}

function task-push() {
    echo "performing git push"
    cd "${TASKDATA}"
    git checkout develop
    git push -u origin develop
    echo "git push complete"
    cd "${OLDPWD}"
}

function task-sync() {
    if [ ! -f "${TASK_SYNC_LOCK_FILE}" ];
    then
        touch "${TASK_SYNC_LOCK_FILE}"
        echo "starting task sync: $(date --iso-8601=seconds)"
        task-pull >> "${TASK_SYNC_LOG_FILE}" 2>&1
        task-push >> "${TASK_SYNC_LOG_FILE}" 2>&1
        echo "task sync running"
        unalias rm
        rm -f "${TASK_SYNC_LOCK_FILE}"
    fi
}

task-sync &
