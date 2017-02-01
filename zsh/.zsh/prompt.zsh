autoload -U colors && colors

PROMPT='${PR_BOLD_BLUE}%~%{$reset_color%} $ '
RPROMPT='${vcs_info_msg_0_}'

if [[ $USER != 'tadej' ]]; then
	PROMPT='${PR_BOLD_GREEN}%n%{$reset_color%}:${PR_BOLD_BLUE}%~%{$reset_color%} $ '
fi

if (($+SSH_CONNECTION)); then
	if [[ $IS_SINGULARITY -eq 1 ]]; then
		PROMPT='${PR_BOLD_GREEN}%n%{$reset_color%}@${PR_BOLD_GREEN}%m+singularity%{$reset_color%}:${PR_BOLD_BLUE}%2~%{$reset_color%} $ '
	else
		PROMPT='${PR_BOLD_GREEN}%n%{$reset_color%}@${PR_BOLD_GREEN}%m%{$reset_color%}:${PR_BOLD_BLUE}%2~%{$reset_color%} $ '
	fi
fi
