complete -c spellout -s a -l alphabet -d 'Which spelling alphabet to use for the conversion' -r -f -a "{jan	'Joint Army/Navy',lapd	'Los Angeles Police Department',nato	'North Atlantic Treaty Organization',royal-navy	'Royal Navy',us-financial	'United States Financial Industry',western-union	'Western Union'}"
complete -c spellout -s o -l overrides -d 'Define overrides for spelling alphabet code words' -r
complete -c spellout -l generate -d 'Generate auxiliary asset files' -r -f -a "{man-page	'Manual page in ROFF format',bash	'Completions file for Bash shell',elvish	'Completions file for Elvish shell',fish	'Completions file for Fish shell',powershell	'Completions file for PowerShell',zsh	'Completions file for Z shell'}"
complete -c spellout -l dump-alphabet -d 'Display the spelling alphabet and exit'
complete -c spellout -s n -l nonce-form -d 'Expand output into nonce form like "\'A\' as in ALFA"'
complete -c spellout -s v -l verbose -d 'Use verbose output'
complete -c spellout -s h -l help -d 'Print help (see more with \'--help\')'
complete -c spellout -s V -l version -d 'Print version'
