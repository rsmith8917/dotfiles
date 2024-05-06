# enable GIT integration
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '(%b)'

setopt PROMPT_SUBST
PROMPT='%F{green}%-80<…<%~%<<%f %F{167}${vcs_info_msg_0_}%f$ '

alias k="kubectl"


open_feature () {
    git checkout feat/$1
}

close_feature () {
    # switch to main branch
    git checkout main
    # ensure local main matches remote
    git fetch origin
    git reset --hard origin/main
}

new_feature () {
    close_feature
    # create local feature branch
    git checkout -b feat/$1
    # push feature branch to remote
    git push -u origin feat/$1
}

delete_feature () {
    # Get the current branch name
    if [ -n "$1" ]
    then
        branch="feat/$1"
    else
        branch=$(git symbolic-ref --short HEAD)
    fi

    if [[ $branch == feat/* ]]
    then
        close_feature
        # delete local feature branch
        git branch -d $branch
        # delete remote branch
        git push origin --delete $branch
    else
        echo "Not in a feature branch."
        echo "Existing feature branches:"
        git branch --list 'feat/*'
    fi
}



list_features () {
    git branch --list 'feat/*'
}

save_feature () {
    if [ -n "$1" ]
    then
        message="$1"
    else
        message="checkpoint"
    fi

    branch=$(git symbolic-ref --short HEAD)
    if [[ $branch == feat/* ]]
    then
        git add .
        git commit -am "$message"
        git push origin -f
    else
        echo "Not in a feature branch."
        echo "Existing feature branches:"
        list_features
    fi
}

merge_feature () {
    branch=$(git symbolic-ref --short HEAD)
    if [[ $branch == feat/* ]]
    then
        save_feature "Finalizing Feature"
        close_feature

        # merge and squash commits
        git merge --squash $branch
        git commit -m "$1"
        git push origin main

        # delete local feature branch
        git branch -d $branch
        # delete remote branch
        git push origin --delete $branch
    else
        echo "Not in a feature branch."
        echo "Existing feature branches:"
        list_features
    fi
}

git_log () {
    git log --all --graph --pretty=format:'%C(auto)%h%d %s %C(bold black)(%ar by <%aN>)%Creset'
}

git_status () {
    git status
}

g () {
    if [[ $1 == "nf" ]]
    then
        new_feature $2
    elif [[ $1 == "df" ]]
    then
        delete_feature $2
    elif [[ $1 == "of" ]]
    then
        open_feature $2
    elif [[ $1 == "cf" ]]
    then
        close_feature
    elif [[ $1 == "lf" ]]
    then
        list_features
    elif [[ $1 == "sf" ]]
    then
        save_feature "$2"
    elif [[ $1 == "mf" ]]
    then
        merge_feature "$2"
    elif [[ $1 == "l" ]]
    then
        git_log
    elif [[ $1 == "s" ]]
    then
        git_status
    else
        echo "usage: g [options]"
        echo ""
        echo "options:"
        echo "  nf    Start a new feature branch and switch to it"
        echo "  df    Delete a feature branch"
        echo "  of    Open an existing feature branch (switch to it)"
        echo "  cf    Close the current feature branch and switch back to main"
        echo "  lf    List existing feature branches"
        echo "  sf    Save changes to feature branch"
        echo "  mf    Merge feature branch into main"
        echo "  l     Show the git log"
        echo "  s     Show the git status"
    fi
}
