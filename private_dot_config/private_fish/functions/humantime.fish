# https://github.com/jorgebucaran/humantime.fish
# Provided under the terms of the MIT License.
# Copyright © Jorge Bucaran <https://jorgebucaran.com>
function humantime --argument-names ms --description "Turn milliseconds into a human-readable string"
    set --query ms[1] || return

    set --local secs (math --scale=1 $ms/1000 % 60)
    set --local mins (math --scale=0 $ms/60000 % 60)
    set --local hours (math --scale=0 $ms/3600000)

    test $hours -gt 0 && set --local --append out $hours"h"
    test $mins -gt 0 && set --local --append out $mins"m"
    test $secs -gt 0 && set --local --append out $secs"s"

    set --query out && echo $out || echo $ms"ms"
end
