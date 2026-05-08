# PATH
export PATH="$HOME/.local/bin:$PATH"

# Oh My Posh
eval "$(oh-my-posh init zsh --config "$(brew --prefix oh-my-posh)/themes/jandedobbeleer.omp.json")"

# Completion
fpath=("$HOME/.zsh/completions" $fpath)
autoload -Uz compinit
compinit

setopt AUTO_LIST
zstyle ":completion:*" menu select
zstyle ":completion:" matcher-list 'm:{a-z}={A-Za-z}' 'r:|= l:|=*'

# Autosuggestions
source "$(brew --prefix zsh-autosuggestions)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Yazi: change shell cwd when exiting yazi
function y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"

  command yazi "$@" --cwd-file="$tmp"

  if IFS= read -r -d '' cwd < "$tmp"; then
    if [[ "$cwd" != "$PWD" && -d "$cwd" ]]; then
      builtin cd -- "$cwd"
    fi
  fi

  rm -f -- "$tmp"
}