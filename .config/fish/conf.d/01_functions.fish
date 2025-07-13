# tmux
function tm --description 'start new or attach to last tmux sessions'
    # Check if we're inside tmux already
    if set -q TMUX
        return 1
    end

    # Check for existing sessions
    set existing_sessions (tmux list-sessions 2>/dev/null)

    if test -n "$existing_sessions"
        # Try to attach to the first session (modify as needed)
        set first_session (echo $existing_sessions | head -n 1 | cut -d: -f1)
        tmux attach -t $first_session
    else
        # No existing sessions - create new one with default name
        tmux_load Home
    end
end

function td --description 'detach from the current tmux session'
    if set -q TMUX
        tmux detach
    end
end

function tmux_store --description 'store a sessions using tmuxp'
    mkdir -p $HOME/.tmux/sessions

    if set -q argv[1]
        set session_name "$argv[1]"
    else
        if not set -q TMUX
            echo "you should provide the session_name, we are not within an attached tmux sessions.\nusage: tmux_store [-R|--remove] [session_name]"
            return 1
        end
        set session_name (tmux display-message -p "#S")
    end

    if not tmux has-session -t "$session_name" 2>/dev/null
        echo "$session_name is not a valid tmux session"
        return 1
    end

    mkdir -p "$HOME/.tmux/sessions/$session_name/"
    tmuxp freeze -y -f yaml -o "$HOME/.tmux/sessions/$session_name/.tmuxp.yaml" "$session_name"

    if contains -- -R $argv; or contains -- --remove $argv
        if tmux has-session -t Home
            tmux attach -t Home
        end
        tmux kill-session -t "$session_name"
    end
end
complete -c tmux_store -xa "(tmux list-sessions -F '#S')"

function tmux_load --description 'load a sessions using tmuxp'
    mkdir -p $HOME/.tmux/sessions

    if not set -q argv[1]
        echo "usage: tmuxp_load <SESSION_NAME>"
        return 1
    end

    set session_name "$argv[1]"
    if not test -f "$HOME/.tmux/sessions/$session_name/.tmuxp.yaml"
        echo "no state saved for $session_name"
        return 1
    end

    if tmux has-session -t "$session_name" 2>/dev/null
        echo "$session_name already exist, attaching."
        tmux attach -t Home
        return 0
    end

    tmuxp load -y -s "$session_name" "$HOME/.tmux/sessions/$session_name"
end
complete -c tmux_load -xa "(fd -d 1 -t dir --base-directory $HOME/.tmux/sessions/ --format {.})"

# python
function activate --description 'activate a python venv by source \'activate\' file'
    # @fish-lsp-disable-next-line 1004
    source "$HOME/.env/$argv[1]/bin/activate.fish"
end
complete -c activate -xa "(fd -d 1 -t dir --base-directory $HOME/.env --format {.})"

function mkvenv --description 'create a python venv'
    $PYTHON_BIN -m venv "$HOME/.env/$argv[1]"
    activate $argv[1]
end

# rclone
function sync_vault --description 'Two-way sync between local and remote Vault'
    if not test -d "$VAULT_LOCAL"
        mkdir -p "$VAULT_LOCAL"
    end

    if rclone bisync "OneDrive:$VAULT_REMOTE" "$VAULT_LOCAL" \
            --verbose \
            --resync \
            --resync-mode newer \
            --exclude "/.DS_Store" \
            --exclude "/.tmp*/**" \
            --progress
        echo "Sync complete between OneDrive:$VAULT_REMOTE and $VAULT_LOCAL"
    else
        echo "Sync aborted between OneDrive:$VAULT_REMOTE and $VAULT_LOCAL"
        return 1
    end
end

function rm_vault --description 'Delete files and sync deletion with Vault'
    if test (count $argv) -eq 0
        echo "Usage: rm_sync <file1> [file2...]"
        return 1
    end

    # Process each file
    for file in $argv
        set -l abs_path (realpath "$file")

        if not test -e "$abs_path"
            echo "Error: '$file' does not exist"
            continue
        end

        # Get relative path within sync folder
        set -l rel_path (string replace -r "^$VAULT_LOCAL/?" "" "$abs_path")

        # Delete local file
        echo "Deleting: $abs_path"
        rm -rf "$abs_path"

        # Delete remote counterpart if in sync folder
        if string match -q "$VAULT_LOCAL*" "$abs_path"
            echo "Syncing deletion to remote..."
            rclone delete "OneDrive:$VAULT_REMOTE/$rel_path" --verbose
        else
            echo "Note: File not in sync folder ($VAULT_LOCAL), remote copy not deleted"
        end
    end

    echo "Deletion sync complete"
end
