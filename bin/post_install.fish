#!/usr/bin/env fish

set DEFAULT_PYTHON_BINARY python3.13


# set(reset) default env vars
fish -c "set -Ux PYTHON_BIN $DEFAULT_PYTHON_BINARY"


# create empty python envs
set items pratisoft proto core his
for item in $items
    if not test -d ~/.env/$item
        echo "creating '$item' venv"
        $DEFAULT_PYTHON_BINARY -m venv ~/.env/$item
    else
        echo "skipping '$item', folder exists."
    end
end
