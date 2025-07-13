# fnm
set FNM_PATH "/home/ae/.local/share/fnm"
if [ -d "$FNM_PATH" ]
    set PATH "$FNM_PATH" $PATH
    fnm env --shell fish | source
    fnm completions --shell fish | source
end
