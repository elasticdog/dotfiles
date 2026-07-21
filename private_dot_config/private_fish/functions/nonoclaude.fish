# https://claude.com/claude-code
function nonoclaude --description "nono sandbox wrapper for claude code"
    _nono_run --profile nolabs-ai/claude -- claude --dangerously-skip-permissions $argv
end
