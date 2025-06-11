if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
zoxide init fish | source

function activate
    source ~/.env/$argv[1]/bin/activate.fish
end

function mkvenv
    python -m venv ~/.env/$argv[1]
    activate $argv[1]
end
