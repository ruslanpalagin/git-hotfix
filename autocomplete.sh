#!/bin/bash

_script()
{
  _script_commands=("run save deploy config sync delete-merged reset get st self-update init")

  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${_script_commands}" -- ${cur}) )

  return 0
}
complete -o nospace -F _script ./hf