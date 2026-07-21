set -l openrouter_key (
    security find-generic-password \
        -a "$USER" \
        -s openrouter-api-key \
        -w 2>/dev/null
)

if test $status -eq 0
    set -gx OPENROUTER_API_KEY $openrouter_key
end
