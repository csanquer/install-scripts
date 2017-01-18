# based on steeef theme for oh my zsh

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('%F{blue}`basename $VIRTUAL_ENV`%f') '
}
PR_GIT_UPDATE=1

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

if [ ${CSA_THEME_BOLD:=true} ]; then
    turquoise="$fg_bold[cyan]"
    orange="$fg_bold[yellow]"
    purple="$fg_bold[magenta]"
    hotpink="$fg_bold[red]"
    limegreen="$fg_bold[green]"
    black="$fg[black]"
    blue="$fg_bold[blue]"
    white="$fg_bold[white]"
else
    #use extended color pallete if available
    if [[ $terminfo[colors] -ge 256 ]]; then
        turquoise="%F{81}"
        orange="%F{166}"
        purple="%F{135}"
        hotpink="%F{161}"
        limegreen="%F{118}"
    else
        turquoise="%F{cyan}"
        orange="%F{yellow}"
        purple="%F{magenta}"
        hotpink="%F{red}"
        limegreen="%F{green}"
    fi
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%f"
FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
FMT_UNSTAGED="%{$orange%}●"
FMT_STAGED="%{$limegreen%}●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function csa_preexec {
    case "$(history $HISTCMD)" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec csa_preexec

function csa_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd csa_chpwd

function csa_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="(%{$turquoise%}%b%u%c%{$hotpink%}●${PR_RST})"
        else
            FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd csa_precmd

time_enabled="%(?.%{$limegreen%}.%{$hotpink%})%*%{$reset_color%}"
time_disabled="%{$limegreen%}%*%{$reset_color%}"
time=$time_enabled

if [ $UID -eq 0 ]; then
    local PR_USER="%{$hotpink%}%n%{$reset_color%}"
    local PR_STATE="%{$hotpink%}%(!.#.$) %{$reset_color%}"
else
    local PR_USER="%{$blue%}%n%{$reset_color%}"
    local PR_STATE="%{$blue%}%(!.#.$) %{$reset_color%}"
fi

PROMPT=$'${PR_USER}%{$turquoise%}@%{$orange%}%m%{$reset_color%}%{$limegreen%}:%{$white%}%~%{$reset_color%} $vcs_info_msg_0_%{$reset_color%}$(virtualenv_info)
${time} ${PR_STATE}'

# elaborate exitcode on the right when >0
return_code_enabled="%(?..%{$hotpink%}%? ↵%{$reset_color%})"
return_code_disabled=
return_code=$return_code_enabled

RPS1='${return_code}'

function accept-line-or-clear-warning () {
	if [[ -z $BUFFER ]]; then
		time=$time_disabled
		return_code=$return_code_disabled
	else
		time=$time_enabled
		return_code=$return_code_enabled
	fi
	zle accept-line
}
zle -N accept-line-or-clear-warning
bindkey '^M' accept-line-or-clear-warning
