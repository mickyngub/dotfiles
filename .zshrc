# Enable Powerlevel10k instant prompt (if installed)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ -f $HOME/.zsh_env_vars ]] && source $HOME/.zsh_env_vars

function chpwd() {
    emulate -L zsh
    ls -a
}
# oh-my-zsh (if installed)
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  export ZSH="$HOME/.oh-my-zsh"
  ZSH_THEME="powerlevel10k/powerlevel10k"
  plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
  source $ZSH/oh-my-zsh.sh
else
  # Standalone plugin loading (without oh-my-zsh)
  for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
    for dir in /usr/share/zsh-$plugin /usr/share/zsh/plugins/$plugin $HOME/.zsh/plugins/$plugin; do
      [[ -f "$dir/$plugin.zsh" ]] && source "$dir/$plugin.zsh" && break
    done
  done
fi

export NVM_DIR="$HOME/.nvm"
if [[ "$(uname)" == "Darwin" ]]; then
    brew_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}"
    [ -s "$brew_prefix/opt/nvm/nvm.sh" ] && \. "$brew_prefix/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$brew_prefix/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$brew_prefix/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
else
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi

if [[ "$(uname)" == "Darwin" ]]; then
  alias arm="env /usr/bin/arch --arm64 /bin/zsh --login"
  alias intel="env /usr/bin/arch --x86_64 /bin/zsh --login"
else
  # On Debian/Ubuntu, fd is installed as fdfind
  command -v fdfind &>/dev/null && ! command -v fd &>/dev/null && alias fd="fdfind"
fi


eval "$(zoxide init --cmd cd zsh)"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

function git_pull_rebase() {
  command git pull origin $1 --rebase
}

function git_pull_no_rebase() {
  command git pull origin $1 --no-rebase
}

# Wrap git to auto-symlink .env files after `git worktree add`
function git() {
  command git "$@"
  local exit_code=$?

  if [[ $exit_code -eq 0 && "$1" == "worktree" && "$2" == "add" ]]; then
    local args=("${@:3}")
    local worktree_path=""
    local skip_next=false

    # Parse the <path> arg (skip flags that take values)
    for arg in "${args[@]}"; do
      if $skip_next; then
        skip_next=false
        continue
      fi
      case "$arg" in
        -b|-B|--reason) skip_next=true ;;
        --*|-*) ;;
        *)
          if [[ -z "$worktree_path" ]]; then
            worktree_path="$arg"
          fi
          ;;
      esac
    done

    if [[ -n "$worktree_path" && -d "$worktree_path" ]]; then
      local main_wt
      main_wt=$(command git worktree list --porcelain | head -1 | sed 's/^worktree //')
      worktree_path=${worktree_path:a}

      if [[ "$main_wt" != "$worktree_path" && -d "$main_wt" ]]; then
        local count=0
        while IFS= read -r -d '' env_file; do
          local rel="${env_file#$main_wt/}"
          # Only link if not already present (avoids overwriting tracked files)
          if [[ ! -e "$worktree_path/$rel" ]]; then
            mkdir -p "$worktree_path/$(dirname "$rel")"
            ln -sf "$env_file" "$worktree_path/$rel"
            ((count++))
          fi
        done < <(find "$main_wt" -name '.env*' \
          -not -path '*/node_modules/*' \
          -not -path '*/.next/*' \
          -not -path '*/.git/*' \
          -not -path '*/.turbo/*' \
          -not -path '*/dist/*' \
          -print0 2>/dev/null)

        if [[ $count -gt 0 ]]; then
          printf '\n\xF0\x9F\x94\x97 Linked %d .env file(s) from main worktree\n' "$count"
        fi
      fi
    fi
  fi

  return $exit_code
}

function compress_mov() {
  ffmpeg -i "$HOME/Desktop/$1.mov" -qscale 0 "$HOME/Desktop/$1.mp4" && rm "$HOME/Desktop/$1.mov"
}

# --- Context launchers (tmux session wraps herdr session) ---
# Each tmux session sources common + context-specific env files then launches herdr.
# `work` / `personal` work from outside tmux (attach) or inside another tmux session (switch).

function _ensure_herdr_session() {
  local name="$1"
  tmux has-session -t "$name" 2>/dev/null && return
  tmux new-session -d -s "$name" \
    "[ -f ~/.zsh_env_vars ] && source ~/.zsh_env_vars; [ -f ~/.zsh_env_vars.${name} ] && source ~/.zsh_env_vars.${name}; herdr --session ${name}"
}

function work() {
  _ensure_herdr_session work
  if [[ -n "$TMUX" ]]; then tmux switch-client -t work; else tmux attach-session -t work; fi
}

function personal() {
  _ensure_herdr_session personal
  if [[ -n "$TMUX" ]]; then tmux switch-client -t personal; else tmux attach-session -t personal; fi
}

# Ensure both sessions exist and land in work on first terminal of the day.
function create_tmux_sessions_and_attach() {
  _ensure_herdr_session work
  _ensure_herdr_session personal
  tmux attach-session -t work
}

# Only auto-attach when not already inside tmux and in an interactive shell
if [[ -z "$TMUX" && $- == *i* ]]; then
  create_tmux_sessions_and_attach
fi


alias killv="pkill -9 nvim && pkill -9 eslint_d"
alias cdnvim="cd ~/.config/nvim"
alias cddot="cd ~/dotfiles"
alias cddev="cd ~/Documents/Dev"
alias ls="ls -a"
alias v="nvim"
alias vo="fd --type f --hidden --exclude .git | fzf-tmux -p | xargs nvim"
alias gpr='git_pull_rebase'
alias gpnr='git_pull_no_rebase'
alias cpv='compress_mov'

alias claude-yolo='claude --dangerously-skip-permissions'


if [[ "$(uname)" == "Darwin" ]]; then
  export PATH="/opt/homebrew/opt/mozjpeg/bin:$PATH"
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# npm global
export PATH="$HOME/.npm-global/bin:$PATH"




# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Use brew's Python 3.13 for gcloud (bundled Python install failed on macOS Tahoe)
export CLOUDSDK_PYTHON=/opt/homebrew/opt/python@3.13/libexec/bin/python

# Per-tmux-session env overlay — catches raw shells spawned inside tmux:work / tmux:personal
# outside the herdr launcher's reach. No-op if context env file doesn't exist yet.
if [[ -n "$TMUX" ]]; then
  case "$(tmux display-message -p '#S')" in
    work)     [[ -f ~/.zsh_env_vars.work ]]     && source ~/.zsh_env_vars.work ;;
    personal) [[ -f ~/.zsh_env_vars.personal ]] && source ~/.zsh_env_vars.personal ;;
  esac
fi
