#!/usr/bin/env bash


if [ ! -e ~/.task/pending.data ];
then
	sudo mount -o bind "${PROJECT_HOME}/task-config" "${HOME}/.task"
fi

alias task='${PROJECT_HOME}/task-git/task-git.sh'
