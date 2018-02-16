function __fish_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq (count $argv) ]
        for i in (seq (count $argv))
            if [ $cmd[$i] != $argv[$i] ]
                return 1
            end
        end
        return 0
    end
    return 1
end

complete -c rg -n "__fish_using_command rg" -s A -l after-context -d 'Show NUM lines after each match.'
complete -c rg -n "__fish_using_command rg" -s B -l before-context -d 'Show NUM lines before each match.'
complete -c rg -n "__fish_using_command rg" -l color -d 'Controls when to use color.' -r -f -a "never auto always ansi"
complete -c rg -n "__fish_using_command rg" -l colors -d 'Configure color settings and styles.'
complete -c rg -n "__fish_using_command rg" -s C -l context -d 'Show NUM lines before and after each match.'
complete -c rg -n "__fish_using_command rg" -l context-separator -d 'Set the context separator string.'
complete -c rg -n "__fish_using_command rg" -l dfa-size-limit -d 'The upper size limit of the regex DFA.'
complete -c rg -n "__fish_using_command rg" -s E -l encoding -d 'Specify the text encoding of files to search.'
complete -c rg -n "__fish_using_command rg" -s f -l file -d 'Search for patterns from the given file.'
complete -c rg -n "__fish_using_command rg" -s g -l glob -d 'Include or exclude files.'
complete -c rg -n "__fish_using_command rg" -l iglob -d 'Include or exclude files case insensitively.'
complete -c rg -n "__fish_using_command rg" -l ignore-file -d 'Specify additional ignore files.'
complete -c rg -n "__fish_using_command rg" -l line-number-width -d 'Left pad line numbers up to NUM width.'
complete -c rg -n "__fish_using_command rg" -s M -l max-columns -d 'Don\'t print lines longer than this limit.'
complete -c rg -n "__fish_using_command rg" -s m -l max-count -d 'Limit the number of matches.'
complete -c rg -n "__fish_using_command rg" -l max-filesize -d 'Ignore files larger than NUM in size.'
complete -c rg -n "__fish_using_command rg" -l maxdepth -d 'Descend at most NUM directories.'
complete -c rg -n "__fish_using_command rg" -l path-separator -d 'Set the path separator.'
complete -c rg -n "__fish_using_command rg" -l regex-size-limit -d 'The upper size limit of the compiled regex.'
complete -c rg -n "__fish_using_command rg" -s e -l regexp -d 'A pattern to search for.'
complete -c rg -n "__fish_using_command rg" -s r -l replace -d 'Replace matches with the given text.'
complete -c rg -n "__fish_using_command rg" -s j -l threads -d 'The approximate number of threads to use.'
complete -c rg -n "__fish_using_command rg" -s t -l type -d 'Only search files matching TYPE.'
complete -c rg -n "__fish_using_command rg" -l type-add -d 'Add a new glob for a file type.'
complete -c rg -n "__fish_using_command rg" -l type-clear -d 'Clear globs for a file type.'
complete -c rg -n "__fish_using_command rg" -s T -l type-not -d 'Do not search files matching TYPE.'
complete -c rg -n "__fish_using_command rg" -s s -l case-sensitive -d 'Search case sensitively (default).'
complete -c rg -n "__fish_using_command rg" -l column -d 'Show column numbers.'
complete -c rg -n "__fish_using_command rg" -s c -l count -d 'Only show the count of matches for each file.'
complete -c rg -n "__fish_using_command rg" -l debug -d 'Show debug messages.'
complete -c rg -n "__fish_using_command rg" -l files -d 'Print each file that would be searched.'
complete -c rg -n "__fish_using_command rg" -s l -l files-with-matches -d 'Only print the paths with at least one match.'
complete -c rg -n "__fish_using_command rg" -l files-without-match -d 'Only print the paths that contain zero matches.'
complete -c rg -n "__fish_using_command rg" -s F -l fixed-strings -d 'Treat the pattern as a literal string.'
complete -c rg -n "__fish_using_command rg" -s L -l follow -d 'Follow symbolic links.'
complete -c rg -n "__fish_using_command rg" -l no-follow
complete -c rg -n "__fish_using_command rg" -l heading -d 'Print matches grouped by each file.'
complete -c rg -n "__fish_using_command rg" -l no-heading -d 'Don\'t group matches by each file.'
complete -c rg -n "__fish_using_command rg" -l hidden -d 'Search hidden files and directories.'
complete -c rg -n "__fish_using_command rg" -l no-hidden
complete -c rg -n "__fish_using_command rg" -s i -l ignore-case -d 'Case insensitive search.'
complete -c rg -n "__fish_using_command rg" -s v -l invert-match -d 'Invert matching.'
complete -c rg -n "__fish_using_command rg" -s n -l line-number -d 'Show line numbers.'
complete -c rg -n "__fish_using_command rg" -s N -l no-line-number -d 'Suppress line numbers.'
complete -c rg -n "__fish_using_command rg" -s x -l line-regexp -d 'Only show matches surrounded by line boundaries.'
complete -c rg -n "__fish_using_command rg" -l mmap -d 'Search using memory maps when possible.'
complete -c rg -n "__fish_using_command rg" -l no-mmap -d 'Never use memory maps.'
complete -c rg -n "__fish_using_command rg" -l no-config -d 'Never read configuration files.'
complete -c rg -n "__fish_using_command rg" -l no-ignore -d 'Don\'t respect ignore files.'
complete -c rg -n "__fish_using_command rg" -l ignore
complete -c rg -n "__fish_using_command rg" -l no-ignore-parent -d 'Don\'t respect ignore files in parent directories.'
complete -c rg -n "__fish_using_command rg" -l ignore-parent
complete -c rg -n "__fish_using_command rg" -l no-ignore-vcs -d 'Don\'t respect VCS ignore files.'
complete -c rg -n "__fish_using_command rg" -l ignore-vcs
complete -c rg -n "__fish_using_command rg" -l no-messages -d 'Suppress all error messages.'
complete -c rg -n "__fish_using_command rg" -l messages
complete -c rg -n "__fish_using_command rg" -s 0 -l null -d 'Print a NUL byte after file paths.'
complete -c rg -n "__fish_using_command rg" -s o -l only-matching -d 'Print only matches parts of a line.'
complete -c rg -n "__fish_using_command rg" -l passthru -d 'Print both matching and non-matching lines.'
complete -c rg -n "__fish_using_command rg" -s p -l pretty -d 'Alias for --color always --heading --line-number.'
complete -c rg -n "__fish_using_command rg" -s q -l quiet -d 'Do not print anything to stdout.'
complete -c rg -n "__fish_using_command rg" -s z -l search-zip -d 'Search in compressed files.'
complete -c rg -n "__fish_using_command rg" -l no-search-zip
complete -c rg -n "__fish_using_command rg" -s S -l smart-case -d 'Smart case search.'
complete -c rg -n "__fish_using_command rg" -l sort-files -d 'Sort results by file path. Implies --threads=1.'
complete -c rg -n "__fish_using_command rg" -l no-sort-files
complete -c rg -n "__fish_using_command rg" -s a -l text -d 'Search binary files as if they were text.'
complete -c rg -n "__fish_using_command rg" -l no-text
complete -c rg -n "__fish_using_command rg" -l type-list -d 'Show all supported file types.'
complete -c rg -n "__fish_using_command rg" -s u -l unrestricted -d 'Reduce the level of "smart" searching.'
complete -c rg -n "__fish_using_command rg" -l vimgrep -d 'Show results in vim compatible format.'
complete -c rg -n "__fish_using_command rg" -s H -l with-filename -d 'Print the file path with the matched lines.'
complete -c rg -n "__fish_using_command rg" -l no-filename -d 'Never print the file path with the matched lines.'
complete -c rg -n "__fish_using_command rg" -s w -l word-regexp -d 'Only show matches surrounded by word boundaries.'
complete -c rg -n "__fish_using_command rg" -s h -l help -d 'Prints help information. Use --help for more details.'
complete -c rg -n "__fish_using_command rg" -s V -l version -d 'Prints version information'
