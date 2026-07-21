# https://developers.openai.com/codex/cli
function nonocodex --description "nono sandbox wrapper for codex"
    _nono_run --profile nolabs-ai/codex -- codex --dangerously-bypass-approvals-and-sandbox $argv
end
