# ~/.zshrc

# --- Prompt ---
# Starship
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi


# --- pyenv ---
export PATH="$HOME/.pyenv/bin:$PATH"

if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi


# --- Environment ---

# Preferred editor
export EDITOR=nvim
export VISUAL=nvim


# --- Aliases ---

alias ghidra='/home/sof/soft/ghidra_12.0_PUBLIC/support/pyghidraRun'


# --- Android SDK ---

export ANDROID_HOME="$HOME/Android/Sdk"

export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"


# --- opencode ---

export PATH="$HOME/.opencode/bin:$PATH"


# --- zoxide ---

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi
