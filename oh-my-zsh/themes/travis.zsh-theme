Git_Has_Stash() {
    git stash show >/dev/null 2>&1
}

Git_Prompt_Status() {
    INDEX=$(command git status --porcelain -b 2> /dev/null)
    local STATUS
    if $(echo "$INDEX" | grep -E '^\?\? ' &> /dev/null)
        then STATUS="$STATUS$GIT_PROMPT_STATUS_UNTRACKED"
    fi
    if $(echo "$INDEX" | grep '^A  ' &> /dev/null)
        then STATUS="$STATUS$GIT_PROMPT_STATUS_ADDED"
    fi
    if $(echo "$INDEX" | grep '^.[MTD] ' &> /dev/null)
        then STATUS="$STATUS$GIT_PROMPT_STATUS_UNSTAGED"
    fi
    if $(echo "$INDEX" | grep '^[AMRD]. ' &> /dev/null)
        then STATUS="$STATUS$GIT_PROMPT_STATUS_STAGED"
    fi
    if Git_Has_Stash
        then STATUS="$STATUS$GIT_PROMPT_STATUS_STASHED"
    fi
    echo $STATUS
}
Git_Prompt_Info() {
    local INFO=$(git_prompt_info)
    if [ -n "$INFO" ]
        then INFO="%F{blue}][ $INFO"
    fi
    echo $INFO
}
PROMPT='%F{green}%2c%F{blue} [%f '
RPROMPT='$(Git_Prompt_Info)$(Git_Prompt_Status) %F{blue}] %F{green}%D{%L:%M}'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

GIT_PROMPT_STATUS_ADDED=" %F{green}+%f"
GIT_PROMPT_STATUS_UNTRACKED=" %F{red}+%f"
GIT_PROMPT_STATUS_UNSTAGED=" %F{red}⁜%f"
GIT_PROMPT_STATUS_STAGED=" %F{green}⁜%f"
GIT_PROMPT_STATUS_STASHED=" %F{red}⇲%f"
