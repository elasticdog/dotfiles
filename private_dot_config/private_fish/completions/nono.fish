# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_nono_global_optspecs
    string join \n s/silent theme= log-file= h/help V/version
end

function __fish_nono_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_nono_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_nono_using_subcommand
    set -l cmd (__fish_nono_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c nono -n "__fish_nono_needs_command" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_needs_command" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_needs_command" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_needs_command" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_needs_command" -s V -l version -d 'Print version'
complete -c nono -n "__fish_nono_needs_command" -f -a "setup" -d 'Set up nono on this system'
complete -c nono -n "__fish_nono_needs_command" -f -a "run" -d 'Run a command inside the sandbox'
complete -c nono -n "__fish_nono_needs_command" -f -a "shell" -d 'Start an interactive shell inside the sandbox'
complete -c nono -n "__fish_nono_needs_command" -f -a "wrap" -d 'Apply sandbox and exec into command (nono disappears). For scripts, piping, and embedding where no parent process is wanted'
complete -c nono -n "__fish_nono_needs_command" -f -a "learn" -d '[deprecated] Use `nono run` to learn from sandbox denials DEPRECATED(canonical="nono run", introduced="v0.50.1", remove_by="v1.0.0", issue="#445")'
complete -c nono -n "__fish_nono_needs_command" -f -a "why" -d 'Check why filesystem, network, scope, or command access would be allowed or denied'
complete -c nono -n "__fish_nono_needs_command" -f -a "proxy" -d 'Run the network filtering / credential proxy as a standalone server'
complete -c nono -n "__fish_nono_needs_command" -f -a "rollback" -d 'Manage rollback sessions (browse, restore, cleanup)'
complete -c nono -n "__fish_nono_needs_command" -f -a "audit" -d 'View audit trail of sandboxed commands'
complete -c nono -n "__fish_nono_needs_command" -f -a "trust" -d 'Manage file trust and attestation'
complete -c nono -n "__fish_nono_needs_command" -f -a "ps" -d 'List running sandboxed sessions'
complete -c nono -n "__fish_nono_needs_command" -f -a "stop" -d 'Stop a running sandboxed session'
complete -c nono -n "__fish_nono_needs_command" -f -a "detach" -d 'Detach from a running sandboxed session and return to the shell'
complete -c nono -n "__fish_nono_needs_command" -f -a "attach" -d 'Attach to a detached or running session from another terminal'
complete -c nono -n "__fish_nono_needs_command" -f -a "logs" -d 'View event log for a session'
complete -c nono -n "__fish_nono_needs_command" -f -a "inspect" -d 'Show detailed information about a session'
complete -c nono -n "__fish_nono_needs_command" -f -a "prune" -d 'Clean up old session files'
complete -c nono -n "__fish_nono_needs_command" -f -a "session" -d 'Manage runtime session storage'
complete -c nono -n "__fish_nono_needs_command" -f -a "policy" -d '[deprecated] Use \'nono profile\' instead'
complete -c nono -n "__fish_nono_needs_command" -f -a "profile" -d 'Create, inspect, and compare nono profiles'
complete -c nono -n "__fish_nono_needs_command" -f -a "pull" -d 'Install a signed nono pack from the registry'
complete -c nono -n "__fish_nono_needs_command" -f -a "remove" -d 'Remove an installed nono pack'
complete -c nono -n "__fish_nono_needs_command" -f -a "update" -d 'Update installed nono packs'
complete -c nono -n "__fish_nono_needs_command" -f -a "search" -d 'Search the registry for nono packs'
complete -c nono -n "__fish_nono_needs_command" -f -a "list" -d 'List installed nono packs'
complete -c nono -n "__fish_nono_needs_command" -f -a "pin" -d 'Pin an installed pack to its current version, excluding it from updates'
complete -c nono -n "__fish_nono_needs_command" -f -a "unpin" -d 'Unpin a pack so it is included in updates again'
complete -c nono -n "__fish_nono_needs_command" -f -a "outdated" -d 'Show which installed packs have newer versions available'
complete -c nono -n "__fish_nono_needs_command" -f -a "completion" -d 'Generate shell completion scripts'
complete -c nono -n "__fish_nono_needs_command" -f -a "open-url-helper" -d 'Internal: open a URL via supervisor IPC'
complete -c nono -n "__fish_nono_needs_command" -f -a "pack-update-hint-helper" -d 'Internal: refresh cached pack update hints out of process'
complete -c nono -n "__fish_nono_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c nono -n "__fish_nono_using_subcommand setup" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand setup" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand setup" -l check-only -d 'Only verify installation and sandbox support, don\'t create files'
complete -c nono -n "__fish_nono_using_subcommand setup" -l profiles -d 'Generate example user profiles in ~/.config/nono/profiles/'
complete -c nono -n "__fish_nono_using_subcommand setup" -l shell-integration -d 'Show shell integration instructions'
complete -c nono -n "__fish_nono_using_subcommand setup" -s v -l verbose -d 'Show detailed information during setup'
complete -c nono -n "__fish_nono_using_subcommand setup" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand setup" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand run" -s a -l allow -d 'Allow read+write access to a directory (recursive)' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -s r -l read -d 'Allow read-only access to a directory (recursive)' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -s w -l write -d 'Allow write-only access to a directory (recursive). Directory deletion NOT included' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-file -d 'Allow read+write access to a single file' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l read-file -d 'Allow read-only access to a single file' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l write-file -d 'Allow write-only access to a single file' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-unix-socket -d 'Allow connect() to an AF_UNIX socket at this path (implies --read-file)' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-unix-socket-bind -d 'Allow connect() and bind() on an AF_UNIX socket at this path. If the path exists, implies --allow-file on the socket. If it does not yet exist (the typical bind(2) case), implies --allow on the parent directory so the kernel can create the socket file. Prefer --allow-unix-socket-dir-bind for runtime-generated filenames' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-unix-socket-dir -d 'Allow connect() to any AF_UNIX socket directly within this directory. Non-recursive on macOS and future Linux AF_UNIX mediation; current Linux Landlock filesystem fallback is recursive' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-unix-socket-dir-bind -d 'Allow connect() and bind() on any AF_UNIX socket directly within this directory. Non-recursive on macOS and future Linux AF_UNIX mediation; current Linux Landlock filesystem fallback is recursive. Use for runtime-generated socket filenames (PID-derived paths, etc.)' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-unix-socket-subtree -d 'Allow connect() to any AF_UNIX socket within this directory subtree (recursive; implies --read)' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-unix-socket-subtree-bind -d 'Allow connect() and bind() on any AF_UNIX socket within this directory subtree (recursive; implies --allow)' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l bypass-protection -d 'Override a deny rule for a path. Pair with --allow/--read/--write grant ALIAS(canonical="--bypass-protection", introduced="v0.41.0", remove_by="v1.0.0", issue="#594")' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l suppress-save-prompt -d 'Suppress save-profile prompts for denials under this path. Does not grant access ALIAS(canonical="--suppress-save-prompt", introduced="v0.52.0", remove_by="indefinite", issue="#875")' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l workdir -d 'Working directory for $WORKDIR expansion in profiles' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l network-profile -d 'Enable proxy filtering with a named network profile' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-domain -d 'Add a domain to the proxy allowlist (repeatable). Use a plain hostname for unrestricted access, or a URL with a path glob to restrict to specific endpoints (e.g., https://github.com/org/**) ALIAS(canonical="--allow-domain", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l deny-domain -d 'Block a domain through the proxy. Evaluated before the allowlist. Supports wildcards (e.g. *.ads.example.com). Incompatible with --allow-net' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l listen-port -d 'Allow the sandboxed child to listen on a TCP port (repeatable) ALIAS(canonical="--listen-port", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l open-port -d 'Allow bidirectional localhost TCP on a port: connect + listen (repeatable) ALIAS(canonical="--open-port", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-connect-port -d 'Allow outbound TCP connect to a specific port (repeatable; Linux Landlock V4+ only)' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l upstream-proxy -d 'Chain outbound traffic through an upstream proxy (host:port) ALIAS(canonical="--upstream-proxy", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l upstream-bypass -d 'Route these domains direct instead of through the upstream proxy ALIAS(canonical="--upstream-bypass", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l proxy-port -d 'Fixed port for the credential proxy (default: OS-assigned)' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l proxy-ca-validity -d 'Proxy CA certificate validity in days (1–365, default: 1). Controls how long the ephemeral CA (and its leaf certificates) remain valid' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l credential -d 'Inject credentials via reverse proxy for a service (repeatable) ALIAS(canonical="--credential", introduced="v0.0.0", remove_by="v1.0.0", issue="#143")' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-endpoint -d 'Restrict a credential service to specific HTTP method+path patterns (repeatable). Format: "SERVICE:METHOD:/path/pattern" (e.g., "github:GET:/repos/*/issues") Use "*" for any method: "github:*:/repos/*/issues" Patterns: "*" matches one path segment, "**" matches zero or more' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l env-credential -d 'Load credentials as env vars. For network API keys, prefer --credential' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l env-credential-map -d 'Map a credential reference to an environment variable (repeatable)' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-command -d 'Deprecated startup-only command allowlist override (not child-process enforced)' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l block-command -d 'Deprecated startup-only command denylist extension (not child-process enforced)' -r
complete -c nono -n "__fish_nono_using_subcommand run" -s p -l profile -d 'Use a profile by name or file path' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l extends -d 'Extend the selected profile with an additional base profile for this invocation' -r
complete -c nono -n "__fish_nono_using_subcommand run" -s c -l config -d 'Capability manifest file (JSON). A fully-resolved sandbox specification — mutually exclusive with all other sandbox configuration flags' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l memory -d 'Maximum resident memory for the process tree (e.g. 512M, 1Gi). Enforced on Linux via cgroup v2; requires a supervised run' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l max-processes -d 'Maximum number of processes and threads in the process tree. Enforced on Linux via cgroup v2 (pids.max); requires a supervised run. At the cap the kernel refuses new forks rather than killing anything' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l detach-timeout -d 'How long (seconds) to wait for a detached session to become attachable. Only meaningful with --detached. Env: NONO_DETACH_STARTUP_TIMEOUT' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l rollback-exclude -d 'Exclude from snapshots. Globs match filenames; plain names match path components' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l rollback-include -d 'Force-include an auto-excluded directory (name only, not full path)' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l skip-dir -d 'Skip large directory trees during trust scanning and rollback preflight. Matched as an exact path component name. Repeatable' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l rollback-dest -d 'Override the rollback snapshot destination directory. By default, snapshots are stored in $XDG_STATE_HOME/nono/rollbacks/. The destination must be within a path already granted write access by --allow (or profile); nono will fail with a clear error if not. Useful for Docker volume mounts or shared storage paths' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l startup-timeout -d 'Kill the process if it has not entered alt-screen mode after this many seconds. Startup banners and log lines do not count; only a full-screen TUI transition satisfies the check. Set to 0 to disable. Env: NONO_STARTUP_TIMEOUT' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l audit-sign-key -d 'Sign the audit Merkle root with a keyed signing key loaded from the given secret reference. Accepts bare trust-key IDs, keystore:// names, file:// paths, op:// URIs, apple-password:// URIs, keyring:// URIs, or env:// URIs' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l name -d 'Name for this session (shown in `nono ps`)' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand run" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-cwd -d 'Allow CWD access without prompting (level set by profile, defaults to read-only)'
complete -c nono -n "__fish_nono_using_subcommand run" -l block-net -d 'Block outbound network access (allowed by default) ALIAS(canonical="--block-net", introduced="v0.0.0", remove_by="indefinite", issue="#302")'
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-net -d 'Deprecated compatibility flag. Network is unrestricted by default. ALIAS(canonical="--allow-net", introduced="v0.0.0", remove_by="indefinite", issue="#302")'
complete -c nono -n "__fish_nono_using_subcommand run" -l trust-proxy-ca -d 'Add the proxy CA to the macOS user trust store (enables Go CLI tools). Shares the CA across sessions via Keychain; regenerates daily'
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-launch-services -d 'Allow direct LaunchServices opens on macOS (temporary login/setup flows)'
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-gpu -d 'Allow GPU access (Metal/IOKit on Apple Silicon macOS, render nodes on Linux)'
complete -c nono -n "__fish_nono_using_subcommand run" -l allow-http2 -d 'Allow HTTP/2 multiplexing for upstream proxy connections'
complete -c nono -n "__fish_nono_using_subcommand run" -s v -l verbose -d 'Enable verbose output'
complete -c nono -n "__fish_nono_using_subcommand run" -l dry-run -d 'Show what would be sandboxed without executing'
complete -c nono -n "__fish_nono_using_subcommand run" -l detached -d 'Start the session without attaching the current terminal. The supervisor keeps the sandboxed process running in the background; use `nono attach <session>` later to inspect or interact with it'
complete -c nono -n "__fish_nono_using_subcommand run" -l rollback -d 'Enable atomic rollback snapshots for the session'
complete -c nono -n "__fish_nono_using_subcommand run" -l no-rollback-prompt -d 'Skip the post-exit rollback review prompt'
complete -c nono -n "__fish_nono_using_subcommand run" -l no-rollback -d 'Disable rollback entirely (no snapshots taken)'
complete -c nono -n "__fish_nono_using_subcommand run" -l rollback-all -d 'Include all directories in snapshots. VCS dirs (.git) always excluded'
complete -c nono -n "__fish_nono_using_subcommand run" -l no-diagnostics -d 'Suppress diagnostic footer on command failure'
complete -c nono -n "__fish_nono_using_subcommand run" -l diagnostics-json -d 'After the run, print session diagnostics as JSON on stderr (merged with proxy diagnostics when present)'
complete -c nono -n "__fish_nono_using_subcommand run" -l no-audit -d 'Disable the audit trail for this session'
complete -c nono -n "__fish_nono_using_subcommand run" -l no-audit-integrity -d 'Disable the default Merkleized append-only audit log'
complete -c nono -n "__fish_nono_using_subcommand run" -l audit-integrity -d 'Add filesystem-state hashing over in-scope writable paths'
complete -c nono -n "__fish_nono_using_subcommand run" -l trust-override -d 'Disable trust verification (not recommended for production)'
complete -c nono -n "__fish_nono_using_subcommand run" -l capability-elevation -d 'Enable runtime capability elevation (seccomp-notify + approval prompts). Overrides the profile\'s capability_elevation setting. When enabled, the supervisor can grant access to paths not in the initial capability set via interactive prompts'
complete -c nono -n "__fish_nono_using_subcommand run" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand run" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand shell" -s a -l allow -d 'Allow read+write access to a directory (recursive)' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -s r -l read -d 'Allow read-only access to a directory (recursive)' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -s w -l write -d 'Allow write-only access to a directory (recursive). Directory deletion NOT included' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-file -d 'Allow read+write access to a single file' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l read-file -d 'Allow read-only access to a single file' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l write-file -d 'Allow write-only access to a single file' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-unix-socket -d 'Allow connect() to an AF_UNIX socket at this path (implies --read-file)' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-unix-socket-bind -d 'Allow connect() and bind() on an AF_UNIX socket at this path. If the path exists, implies --allow-file on the socket. If it does not yet exist (the typical bind(2) case), implies --allow on the parent directory so the kernel can create the socket file. Prefer --allow-unix-socket-dir-bind for runtime-generated filenames' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-unix-socket-dir -d 'Allow connect() to any AF_UNIX socket directly within this directory. Non-recursive on macOS and future Linux AF_UNIX mediation; current Linux Landlock filesystem fallback is recursive' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-unix-socket-dir-bind -d 'Allow connect() and bind() on any AF_UNIX socket directly within this directory. Non-recursive on macOS and future Linux AF_UNIX mediation; current Linux Landlock filesystem fallback is recursive. Use for runtime-generated socket filenames (PID-derived paths, etc.)' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-unix-socket-subtree -d 'Allow connect() to any AF_UNIX socket within this directory subtree (recursive; implies --read)' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-unix-socket-subtree-bind -d 'Allow connect() and bind() on any AF_UNIX socket within this directory subtree (recursive; implies --allow)' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l bypass-protection -d 'Override a deny rule for a path. Pair with --allow/--read/--write grant ALIAS(canonical="--bypass-protection", introduced="v0.41.0", remove_by="v1.0.0", issue="#594")' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l suppress-save-prompt -d 'Suppress save-profile prompts for denials under this path. Does not grant access ALIAS(canonical="--suppress-save-prompt", introduced="v0.52.0", remove_by="indefinite", issue="#875")' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l workdir -d 'Working directory for $WORKDIR expansion in profiles' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l network-profile -d 'Enable proxy filtering with a named network profile' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-domain -d 'Add a domain to the proxy allowlist (repeatable). Use a plain hostname for unrestricted access, or a URL with a path glob to restrict to specific endpoints (e.g., https://github.com/org/**) ALIAS(canonical="--allow-domain", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l deny-domain -d 'Block a domain through the proxy. Evaluated before the allowlist. Supports wildcards (e.g. *.ads.example.com). Incompatible with --allow-net' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l listen-port -d 'Allow the sandboxed child to listen on a TCP port (repeatable) ALIAS(canonical="--listen-port", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l open-port -d 'Allow bidirectional localhost TCP on a port: connect + listen (repeatable) ALIAS(canonical="--open-port", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-connect-port -d 'Allow outbound TCP connect to a specific port (repeatable; Linux Landlock V4+ only)' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l upstream-proxy -d 'Chain outbound traffic through an upstream proxy (host:port) ALIAS(canonical="--upstream-proxy", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l upstream-bypass -d 'Route these domains direct instead of through the upstream proxy ALIAS(canonical="--upstream-bypass", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l proxy-port -d 'Fixed port for the credential proxy (default: OS-assigned)' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l proxy-ca-validity -d 'Proxy CA certificate validity in days (1–365, default: 1). Controls how long the ephemeral CA (and its leaf certificates) remain valid' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l credential -d 'Inject credentials via reverse proxy for a service (repeatable) ALIAS(canonical="--credential", introduced="v0.0.0", remove_by="v1.0.0", issue="#143")' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-endpoint -d 'Restrict a credential service to specific HTTP method+path patterns (repeatable). Format: "SERVICE:METHOD:/path/pattern" (e.g., "github:GET:/repos/*/issues") Use "*" for any method: "github:*:/repos/*/issues" Patterns: "*" matches one path segment, "**" matches zero or more' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l env-credential -d 'Load credentials as env vars. For network API keys, prefer --credential' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l env-credential-map -d 'Map a credential reference to an environment variable (repeatable)' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-command -d 'Deprecated startup-only command allowlist override (not child-process enforced)' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l block-command -d 'Deprecated startup-only command denylist extension (not child-process enforced)' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -s p -l profile -d 'Use a profile by name or file path' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l extends -d 'Extend the selected profile with an additional base profile for this invocation' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -s c -l config -d 'Capability manifest file (JSON). A fully-resolved sandbox specification — mutually exclusive with all other sandbox configuration flags' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l memory -d 'Maximum resident memory for the process tree (e.g. 512M, 1Gi). Enforced on Linux via cgroup v2; requires a supervised run' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l max-processes -d 'Maximum number of processes and threads in the process tree. Enforced on Linux via cgroup v2 (pids.max); requires a supervised run. At the cap the kernel refuses new forks rather than killing anything' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l shell -d 'Shell to execute (defaults to $SHELL or /bin/sh)' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l name -d 'Name for this session (shown in `nono ps`)' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l startup-timeout -d 'Kill the process if it has not become interactive after this many seconds. Set to 0 to disable. Env: NONO_STARTUP_TIMEOUT' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand shell" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-cwd -d 'Allow CWD access without prompting (level set by profile, defaults to read-only)'
complete -c nono -n "__fish_nono_using_subcommand shell" -l block-net -d 'Block outbound network access (allowed by default) ALIAS(canonical="--block-net", introduced="v0.0.0", remove_by="indefinite", issue="#302")'
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-net -d 'Deprecated compatibility flag. Network is unrestricted by default. ALIAS(canonical="--allow-net", introduced="v0.0.0", remove_by="indefinite", issue="#302")'
complete -c nono -n "__fish_nono_using_subcommand shell" -l trust-proxy-ca -d 'Add the proxy CA to the macOS user trust store (enables Go CLI tools). Shares the CA across sessions via Keychain; regenerates daily'
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-launch-services -d 'Allow direct LaunchServices opens on macOS (temporary login/setup flows)'
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-gpu -d 'Allow GPU access (Metal/IOKit on Apple Silicon macOS, render nodes on Linux)'
complete -c nono -n "__fish_nono_using_subcommand shell" -l allow-http2 -d 'Allow HTTP/2 multiplexing for upstream proxy connections'
complete -c nono -n "__fish_nono_using_subcommand shell" -s v -l verbose -d 'Enable verbose output'
complete -c nono -n "__fish_nono_using_subcommand shell" -l dry-run -d 'Show what would be sandboxed without executing'
complete -c nono -n "__fish_nono_using_subcommand shell" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand shell" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand wrap" -s a -l allow -d 'Allow read+write access to a directory (recursive)' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -s r -l read -d 'Allow read-only access to a directory (recursive)' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -s w -l write -d 'Allow write-only access to a directory (recursive). Directory deletion NOT included' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-file -d 'Allow read+write access to a single file' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l read-file -d 'Allow read-only access to a single file' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l write-file -d 'Allow write-only access to a single file' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-unix-socket -d 'Allow connect() to an AF_UNIX socket at this path (implies --read-file)' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-unix-socket-bind -d 'Allow connect() and bind() on an AF_UNIX socket at this path. If the path exists, implies --allow-file on the socket. If it does not yet exist (the typical bind(2) case), implies --allow on the parent directory so the kernel can create the socket file. Prefer --allow-unix-socket-dir-bind for runtime-generated filenames' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-unix-socket-dir -d 'Allow connect() to any AF_UNIX socket directly within this directory. Non-recursive on macOS and future Linux AF_UNIX mediation; current Linux Landlock filesystem fallback is recursive' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-unix-socket-dir-bind -d 'Allow connect() and bind() on any AF_UNIX socket directly within this directory. Non-recursive on macOS and future Linux AF_UNIX mediation; current Linux Landlock filesystem fallback is recursive. Use for runtime-generated socket filenames (PID-derived paths, etc.)' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-unix-socket-subtree -d 'Allow connect() to any AF_UNIX socket within this directory subtree (recursive; implies --read)' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-unix-socket-subtree-bind -d 'Allow connect() and bind() on any AF_UNIX socket within this directory subtree (recursive; implies --allow)' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l bypass-protection -d 'Override a deny rule for a path. Pair with --allow/--read/--write grant ALIAS(canonical="--bypass-protection", introduced="v0.41.0", remove_by="v1.0.0", issue="#594")' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l suppress-save-prompt -d 'Suppress save-profile prompts for denials under this path. Does not grant access ALIAS(canonical="--suppress-save-prompt", introduced="v0.52.0", remove_by="indefinite", issue="#875")' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l workdir -d 'Working directory for $WORKDIR expansion in profiles' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l listen-port -d 'Allow the sandboxed child to listen on a TCP port (repeatable) ALIAS(canonical="--listen-port", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand wrap" -l open-port -d 'Allow bidirectional localhost TCP on a port: connect + listen (repeatable) ALIAS(canonical="--open-port", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-connect-port -d 'Allow outbound TCP connect to a specific port (repeatable; Linux Landlock V4+ only)' -r
complete -c nono -n "__fish_nono_using_subcommand wrap" -l env-credential -d 'Load credentials as env vars' -r
complete -c nono -n "__fish_nono_using_subcommand wrap" -l env-credential-map -d 'Map a credential reference to an environment variable (repeatable)' -r
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-command -d 'Deprecated startup-only command allowlist override (not child-process enforced)' -r
complete -c nono -n "__fish_nono_using_subcommand wrap" -l block-command -d 'Deprecated startup-only command denylist extension (not child-process enforced)' -r
complete -c nono -n "__fish_nono_using_subcommand wrap" -s p -l profile -d 'Use a profile by name or file path' -r
complete -c nono -n "__fish_nono_using_subcommand wrap" -l extends -d 'Extend the selected profile with an additional base profile for this invocation' -r
complete -c nono -n "__fish_nono_using_subcommand wrap" -s c -l config -d 'Capability manifest file (JSON). A fully-resolved sandbox specification — mutually exclusive with all other sandbox configuration flags' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand wrap" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-cwd -d 'Allow CWD access without prompting (level set by profile, defaults to read-only)'
complete -c nono -n "__fish_nono_using_subcommand wrap" -l block-net -d 'Block outbound network access (allowed by default) ALIAS(canonical="--block-net", introduced="v0.0.0", remove_by="indefinite", issue="#302")'
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-launch-services -d 'Allow direct LaunchServices opens on macOS (temporary login/setup flows)'
complete -c nono -n "__fish_nono_using_subcommand wrap" -l allow-gpu -d 'Allow GPU access (Metal/IOKit on Apple Silicon macOS, render nodes on Linux)'
complete -c nono -n "__fish_nono_using_subcommand wrap" -s v -l verbose -d 'Enable verbose output'
complete -c nono -n "__fish_nono_using_subcommand wrap" -l dry-run -d 'Show what would be sandboxed without executing'
complete -c nono -n "__fish_nono_using_subcommand wrap" -l no-diagnostics -d 'Suppress diagnostic footer on command failure'
complete -c nono -n "__fish_nono_using_subcommand wrap" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand wrap" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand learn" -s p -l profile -d 'Use a named profile to compare against (shows only missing paths)' -r
complete -c nono -n "__fish_nono_using_subcommand learn" -l extends -d 'Extend the selected profile with an additional base profile for this comparison' -r
complete -c nono -n "__fish_nono_using_subcommand learn" -l timeout -d 'Timeout in seconds (default: run until command exits)' -r
complete -c nono -n "__fish_nono_using_subcommand learn" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand learn" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand learn" -l json -d 'Output discovered paths as JSON fragment for profile'
complete -c nono -n "__fish_nono_using_subcommand learn" -l all -d 'Show all accessed paths, not just those that would be blocked'
complete -c nono -n "__fish_nono_using_subcommand learn" -l no-rdns -d 'Skip reverse DNS lookups for discovered IPs'
complete -c nono -n "__fish_nono_using_subcommand learn" -l trace -d 'On macOS, use legacy unsandboxed fs_usage/nettop tracing'
complete -c nono -n "__fish_nono_using_subcommand learn" -s v -l verbose -d 'Enable verbose output'
complete -c nono -n "__fish_nono_using_subcommand learn" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand learn" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand why" -l command -d 'Tool-sandbox command name to check (ETI command policy)' -r
complete -c nono -n "__fish_nono_using_subcommand why" -l caller -d 'Caller edge for command policy checks (default: session)' -r
complete -c nono -n "__fish_nono_using_subcommand why" -l path -d 'Path to check' -r -F
complete -c nono -n "__fish_nono_using_subcommand why" -l op -d 'Operation to check: read, write, or readwrite' -r -f -a "read\t'Read-only access'
write\t'Write-only access'
readwrite\t'Read and write access'"
complete -c nono -n "__fish_nono_using_subcommand why" -l host -d 'Network host or URL to check (e.g. github.com or https://github.com/org/repo)' -r
complete -c nono -n "__fish_nono_using_subcommand why" -l scope -d 'Landlock scope to check' -r -f -a "signal\t'Signal scoping'
abstract-unix-socket\t'Abstract UNIX socket scoping'"
complete -c nono -n "__fish_nono_using_subcommand why" -l port -d 'Network port (default 443)' -r
complete -c nono -n "__fish_nono_using_subcommand why" -s a -l allow -d 'Directories to allow read+write access (for query context)' -r -F
complete -c nono -n "__fish_nono_using_subcommand why" -s r -l read -d 'Directories to allow read-only access (for query context)' -r -F
complete -c nono -n "__fish_nono_using_subcommand why" -s w -l write -d 'Directories to allow write-only access (for query context)' -r -F
complete -c nono -n "__fish_nono_using_subcommand why" -l allow-file -d 'Single files to allow read+write access (for query context)' -r -F
complete -c nono -n "__fish_nono_using_subcommand why" -l read-file -d 'Single files to allow read-only access (for query context)' -r -F
complete -c nono -n "__fish_nono_using_subcommand why" -l write-file -d 'Single files to allow write-only access (for query context)' -r -F
complete -c nono -n "__fish_nono_using_subcommand why" -s p -l profile -d 'Use a named profile for query context' -r
complete -c nono -n "__fish_nono_using_subcommand why" -l extends -d 'Extend the selected profile with an additional base profile for this query' -r
complete -c nono -n "__fish_nono_using_subcommand why" -l workdir -d 'Working directory for $WORKDIR expansion in profiles' -r -F
complete -c nono -n "__fish_nono_using_subcommand why" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand why" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand why" -l json -d 'Output JSON instead of human-readable format'
complete -c nono -n "__fish_nono_using_subcommand why" -l self -d 'Query current sandbox state (use inside a sandboxed process)'
complete -c nono -n "__fish_nono_using_subcommand why" -l block-net -d 'Block network access (for query context) ALIAS(canonical="--block-net", introduced="v0.0.0", remove_by="indefinite", issue="#302")'
complete -c nono -n "__fish_nono_using_subcommand why" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand why" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand proxy" -l listen -d 'Address the proxy listens on (loopback only unless --no-auth is omitted)' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l port -d 'Port to listen on (0 = OS-assigned ephemeral port)' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l pass -d 'Use this exact password as the proxy credential instead of a randomly generated session token. Clients present it via Proxy-Authorization (Basic password or Bearer token). Prefer NONO_PROXY_PASS to avoid leaking the secret in shell history / process listings' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -s p -l profile -d 'Use a profile by name or file path (loads its network/credential settings)' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l max-connections -d 'Maximum concurrent client connections (0 = unlimited). Raise this when driving highly parallel clients such as `docker pull`, which opens many simultaneous tunnels and can exhaust the default limit' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l network-profile -d 'Enable proxy filtering with a named network profile' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l allow-domain -d 'Add a domain to the proxy allowlist (repeatable). Plain hostname for unrestricted access, or a URL with a path glob to restrict to specific endpoints (e.g., https://github.com/org/**) ALIAS(canonical="--allow-domain", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l deny-domain -d 'Block a domain through the proxy. Evaluated before the allowlist. Supports wildcards (e.g. *.ads.example.com)' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l upstream-proxy -d 'Chain outbound traffic through an upstream proxy (host:port) ALIAS(canonical="--upstream-proxy", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l upstream-bypass -d 'Route these domains direct instead of through the upstream proxy ALIAS(canonical="--upstream-bypass", introduced="v0.0.0", remove_by="indefinite", issue="#415")' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l proxy-ca-validity -d 'Proxy CA certificate validity in days (1–365, default: 1)' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l proxy-ca-cert -d 'Sign intercepted TLS connections with this existing CA certificate (PEM) instead of a fresh per-session CA. Reuses the same CA across proxy runs so clients only have to trust it once. Requires --proxy-ca-key. Validity comes from the supplied certificate, so it cannot be combined with --proxy-ca-validity' -r -F
complete -c nono -n "__fish_nono_using_subcommand proxy" -l proxy-ca-key -d 'Private key (PKCS#8 PEM) for --proxy-ca-cert. Prefer NONO_PROXY_CA_KEY to keep the path out of shell history; the key file itself should be readable only by you' -r -F
complete -c nono -n "__fish_nono_using_subcommand proxy" -l credential -d 'Inject credentials via reverse proxy for a service (repeatable) ALIAS(canonical="--credential", introduced="v0.0.0", remove_by="v1.0.0", issue="#143")' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l allow-endpoint -d 'Restrict a credential service to specific HTTP method+path patterns (repeatable). Format: "SERVICE:METHOD:/path/pattern" (e.g., "github:GET:/repos/*/issues") Use "*" for any method: "github:*:/repos/*/issues" Patterns: "*" matches one path segment, "**" matches zero or more' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand proxy" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand proxy" -l no-auth -d 'Disable session-token auth: accept every request on the bind address. Refused for non-loopback bind addresses. Use with care'
complete -c nono -n "__fish_nono_using_subcommand proxy" -l allow-http2 -d 'Allow HTTP/2 multiplexing for upstream proxy connections'
complete -c nono -n "__fish_nono_using_subcommand proxy" -l trust-proxy-ca -d 'Add the proxy CA to the macOS user trust store (enables Go CLI tools)'
complete -c nono -n "__fish_nono_using_subcommand proxy" -s v -l verbose -d 'Enable verbose output (-v info, -vv debug, -vvv trace)'
complete -c nono -n "__fish_nono_using_subcommand proxy" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand proxy" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nono -n "__fish_nono_using_subcommand rollback; and not __fish_seen_subcommand_from list show restore verify cleanup" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand rollback; and not __fish_seen_subcommand_from list show restore verify cleanup" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand rollback; and not __fish_seen_subcommand_from list show restore verify cleanup" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand rollback; and not __fish_seen_subcommand_from list show restore verify cleanup" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand rollback; and not __fish_seen_subcommand_from list show restore verify cleanup" -f -a "list" -d 'List rollback sessions'
complete -c nono -n "__fish_nono_using_subcommand rollback; and not __fish_seen_subcommand_from list show restore verify cleanup" -f -a "show" -d 'Show changes in a session'
complete -c nono -n "__fish_nono_using_subcommand rollback; and not __fish_seen_subcommand_from list show restore verify cleanup" -f -a "restore" -d 'Restore files from a past session'
complete -c nono -n "__fish_nono_using_subcommand rollback; and not __fish_seen_subcommand_from list show restore verify cleanup" -f -a "verify" -d 'Verify session integrity'
complete -c nono -n "__fish_nono_using_subcommand rollback; and not __fish_seen_subcommand_from list show restore verify cleanup" -f -a "cleanup" -d 'Clean up old sessions'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from list" -l recent -d 'Show only the N most recent sessions' -r
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from list" -l path -d 'Filter sessions by tracked path (matches if session tracked this path or a parent/child)' -r -F
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from list" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from list" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from list" -l all -d 'Compatibility flag; rollback sessions are shown by default'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from list" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from list" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from show" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from show" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from show" -l diff -d 'Show unified diff (git diff style)'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from show" -l side-by-side -d 'Show side-by-side diff'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from show" -l full -d 'Show full file content from snapshot'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from show" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from show" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from show" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from restore" -l snapshot -d 'Snapshot number to restore to (default: last snapshot)' -r
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from restore" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from restore" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from restore" -l dry-run -d 'Show what would change without modifying files'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from restore" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from restore" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from verify" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from verify" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from verify" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from verify" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from cleanup" -l keep -d 'Retain N newest sessions (default: from config, usually 10)' -r
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from cleanup" -l older-than -d 'Remove sessions older than N days' -r
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from cleanup" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from cleanup" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from cleanup" -l dry-run -d 'Show what would be removed without deleting'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from cleanup" -l all -d 'Remove all sessions (requires confirmation)'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from cleanup" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand rollback; and __fish_seen_subcommand_from cleanup" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand audit; and not __fish_seen_subcommand_from list show verify cleanup" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and not __fish_seen_subcommand_from list show verify cleanup" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand audit; and not __fish_seen_subcommand_from list show verify cleanup" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand audit; and not __fish_seen_subcommand_from list show verify cleanup" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand audit; and not __fish_seen_subcommand_from list show verify cleanup" -f -a "list" -d 'List all sandboxed sessions'
complete -c nono -n "__fish_nono_using_subcommand audit; and not __fish_seen_subcommand_from list show verify cleanup" -f -a "show" -d 'Show audit details for a session'
complete -c nono -n "__fish_nono_using_subcommand audit; and not __fish_seen_subcommand_from list show verify cleanup" -f -a "verify" -d 'Verify audit integrity by recomputing hashes from the event log'
complete -c nono -n "__fish_nono_using_subcommand audit; and not __fish_seen_subcommand_from list show verify cleanup" -f -a "cleanup" -d 'Remove old audit sessions'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -l since -d 'Show sessions since date (YYYY-MM-DD)' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -l until -d 'Show sessions until date (YYYY-MM-DD)' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -l command -d 'Filter by command name (e.g., claude, cat)' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -l path -d 'Filter by tracked path' -r -F
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -l recent -d 'Show only the N most recent sessions' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -l today -d 'Show only sessions from today'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from list" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from show" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from show" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from show" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from show" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from show" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from verify" -l public-key-file -d 'Public key file to match against the attested signer key (PEM or base64 DER)' -r -F
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from verify" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from verify" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from verify" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from verify" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from verify" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from cleanup" -l keep -d 'Retain N newest audit sessions' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from cleanup" -l older-than -d 'Remove sessions older than N days' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from cleanup" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from cleanup" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from cleanup" -l dry-run -d 'Show what would be removed without deleting'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from cleanup" -l all -d 'Remove all audit sessions (skips active sessions)'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from cleanup" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand audit; and __fish_seen_subcommand_from cleanup" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -f -a "init" -d 'Create a trust-policy.json in the current directory'
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -f -a "sign" -d 'Sign a file, producing a .bundle alongside it'
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -f -a "sign-policy" -d 'Sign a trust policy file, producing a .bundle alongside it'
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -f -a "verify" -d 'Verify a file\'s bundle against the trust policy'
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -f -a "list" -d 'List files and their verification status'
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -f -a "keygen" -d 'Generate a new ECDSA P-256 signing key pair'
complete -c nono -n "__fish_nono_using_subcommand trust; and not __fish_seen_subcommand_from init sign sign-policy verify list keygen export-key" -f -a "export-key" -d 'Export the public key for a signing key (base64 DER)'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from init" -l include -d 'Glob patterns for files to include in the trust policy (e.g., "*.md", "*.py", "SKILLS.md")' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from init" -l key -d 'Key ID to include as a publisher (default: "default")' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from init" -l keyref -d 'Key reference URI (keystore://name or file:///path/to/key.pem)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from init" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from init" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from init" -l user -d 'Create a user-level policy at ~/.config/nono/ instead of the current directory'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from init" -l force -d 'Overwrite existing trust-policy.json'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from init" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign" -l key -d 'Key ID to use from the system keystore (default: "default")' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign" -l keyref -d 'Key reference URI (keystore://name or file:///path/to/key.pem)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign" -l policy -d 'Trust policy file (default: auto-discover)' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign" -l all -d 'Sign all files matching trust policy patterns in CWD'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign" -l keyless -d 'Use Sigstore keyless signing (Fulcio + Rekor via ambient OIDC)'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign" -l multi-subject -d 'Produce a single .nono-trust.bundle containing all subjects instead of per-file bundles'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign-policy" -l key -d 'Key ID to use from the system keystore (default: "default")' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign-policy" -l keyref -d 'Key reference URI (keystore://name or file:///path/to/key.pem)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign-policy" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign-policy" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign-policy" -l user -d 'Sign the user-level trust policy at ~/.config/nono/trust-policy.json'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign-policy" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from sign-policy" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from verify" -l policy -d 'Trust policy file (default: auto-discover)' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from verify" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from verify" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from verify" -l all -d 'Verify all files matching trust policy patterns in CWD'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from verify" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from verify" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from list" -l policy -d 'Trust policy file (default: auto-discover)' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from list" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from list" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from list" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from list" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from keygen" -l id -d 'Key identifier (stored in system keystore under this name)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from keygen" -l keyref -d 'Key reference URI (keystore://name or file:///path/to/key.pem)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from keygen" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from keygen" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from keygen" -l force -d 'Overwrite existing key with the same ID'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from keygen" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from keygen" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from export-key" -l id -d 'Key identifier to export (default: "default")' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from export-key" -l keyref -d 'Key reference URI (keystore://name or file:///path/to/key.pem)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from export-key" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from export-key" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from export-key" -l pem -d 'Output as PEM instead of base64 DER'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from export-key" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand trust; and __fish_seen_subcommand_from export-key" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand ps" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand ps" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand ps" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand ps" -l all -d 'Include exited sessions'
complete -c nono -n "__fish_nono_using_subcommand ps" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand ps" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand stop" -l timeout -d 'Grace period in seconds before SIGKILL (default: 10)' -r
complete -c nono -n "__fish_nono_using_subcommand stop" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand stop" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand stop" -l force -d 'Force stop (SIGKILL instead of SIGTERM)'
complete -c nono -n "__fish_nono_using_subcommand stop" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand stop" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand detach" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand detach" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand detach" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand detach" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand attach" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand attach" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand attach" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand attach" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand logs" -l tail -d 'Show last N events' -r
complete -c nono -n "__fish_nono_using_subcommand logs" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand logs" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand logs" -s f -l follow -d 'Follow events in real-time'
complete -c nono -n "__fish_nono_using_subcommand logs" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand logs" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand logs" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand inspect" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand inspect" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand inspect" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand inspect" -l events -d 'Include event log'
complete -c nono -n "__fish_nono_using_subcommand inspect" -l changes -d 'Include file changes'
complete -c nono -n "__fish_nono_using_subcommand inspect" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand inspect" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand prune" -l older-than -d 'Remove sessions older than N days' -r
complete -c nono -n "__fish_nono_using_subcommand prune" -l keep -d 'Keep only the N most recent sessions' -r
complete -c nono -n "__fish_nono_using_subcommand prune" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand prune" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand prune" -l dry-run -d 'Show what would be removed without deleting'
complete -c nono -n "__fish_nono_using_subcommand prune" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand prune" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand session; and not __fish_seen_subcommand_from cleanup help" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand session; and not __fish_seen_subcommand_from cleanup help" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand session; and not __fish_seen_subcommand_from cleanup help" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand session; and not __fish_seen_subcommand_from cleanup help" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand session; and not __fish_seen_subcommand_from cleanup help" -f -a "cleanup" -d 'Remove old runtime sessions'
complete -c nono -n "__fish_nono_using_subcommand session; and not __fish_seen_subcommand_from cleanup help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c nono -n "__fish_nono_using_subcommand session; and __fish_seen_subcommand_from cleanup" -l older-than -d 'Remove sessions older than N days' -r
complete -c nono -n "__fish_nono_using_subcommand session; and __fish_seen_subcommand_from cleanup" -l keep -d 'Keep only the N most recent sessions' -r
complete -c nono -n "__fish_nono_using_subcommand session; and __fish_seen_subcommand_from cleanup" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand session; and __fish_seen_subcommand_from cleanup" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand session; and __fish_seen_subcommand_from cleanup" -l dry-run -d 'Show what would be removed without deleting'
complete -c nono -n "__fish_nono_using_subcommand session; and __fish_seen_subcommand_from cleanup" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand session; and __fish_seen_subcommand_from help" -f -a "cleanup" -d 'Remove old runtime sessions'
complete -c nono -n "__fish_nono_using_subcommand session; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c nono -n "__fish_nono_using_subcommand policy; and not __fish_seen_subcommand_from groups profiles show diff validate help" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand policy; and not __fish_seen_subcommand_from groups profiles show diff validate help" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand policy; and not __fish_seen_subcommand_from groups profiles show diff validate help" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand policy; and not __fish_seen_subcommand_from groups profiles show diff validate help" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand policy; and not __fish_seen_subcommand_from groups profiles show diff validate help" -f -a "groups" -d '[deprecated] Use \'nono profile groups\' instead'
complete -c nono -n "__fish_nono_using_subcommand policy; and not __fish_seen_subcommand_from groups profiles show diff validate help" -f -a "profiles" -d '[deprecated] Use \'nono profile list\' instead'
complete -c nono -n "__fish_nono_using_subcommand policy; and not __fish_seen_subcommand_from groups profiles show diff validate help" -f -a "show" -d '[deprecated] Use \'nono profile show\' instead'
complete -c nono -n "__fish_nono_using_subcommand policy; and not __fish_seen_subcommand_from groups profiles show diff validate help" -f -a "diff" -d '[deprecated] Use \'nono profile diff\' instead'
complete -c nono -n "__fish_nono_using_subcommand policy; and not __fish_seen_subcommand_from groups profiles show diff validate help" -f -a "validate" -d '[deprecated] Use \'nono profile validate\' instead'
complete -c nono -n "__fish_nono_using_subcommand policy; and not __fish_seen_subcommand_from groups profiles show diff validate help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from groups" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from groups" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from groups" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from groups" -l all-platforms -d 'Show all platforms (not just current)'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from groups" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from profiles" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from profiles" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from profiles" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from profiles" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from show" -l format -d 'Output format: \'profile\' (default) or \'manifest\' (capability manifest JSON)' -r -f -a "profile\t''
manifest\t''"
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from show" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from show" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from show" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from show" -l raw -d 'Show raw paths before expansion (e.g., $HOME instead of /Users/luke)'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from show" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from diff" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from diff" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from diff" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from diff" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from validate" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from validate" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from validate" -l draft -d 'Treat the argument as a draft name under ~/.config/nono/profile-drafts'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from validate" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from validate" -l strict -d 'Treat deprecated schema warnings as errors (exit code 2 if any are found)'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from validate" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from validate" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from help" -f -a "groups" -d '[deprecated] Use \'nono profile groups\' instead'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from help" -f -a "profiles" -d '[deprecated] Use \'nono profile list\' instead'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from help" -f -a "show" -d '[deprecated] Use \'nono profile show\' instead'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from help" -f -a "diff" -d '[deprecated] Use \'nono profile diff\' instead'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from help" -f -a "validate" -d '[deprecated] Use \'nono profile validate\' instead'
complete -c nono -n "__fish_nono_using_subcommand policy; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -f -a "init" -d 'Generate a skeleton profile JSON file'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -f -a "list" -d 'List all available profiles (built-in and user)'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -f -a "show" -d 'Show a fully resolved profile'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -f -a "diff" -d 'Diff two profiles'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -f -a "validate" -d 'Validate a profile JSON file'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -f -a "promote" -d 'Review and apply a profile draft from ~/.config/nono/profile-drafts'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -f -a "groups" -d 'List policy groups or show details for a specific group'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -f -a "schema" -d 'Output the JSON Schema for profile files'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -f -a "guide" -d 'Print the profile authoring guide'
complete -c nono -n "__fish_nono_using_subcommand profile; and not __fish_seen_subcommand_from init list show diff validate promote groups schema guide help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from init" -l extends -d 'Base profile to extend' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from init" -l groups -d 'Security groups to include (comma-separated)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from init" -l description -d 'Profile description' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from init" -s o -l output -d 'Output file path (default: ~/.config/nono/profiles/<name>.json)' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from init" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from init" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from init" -l full -d 'Generate a full skeleton with all sections'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from init" -l force -d 'Overwrite existing file'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from init" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from list" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from list" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from list" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from list" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from show" -l format -d 'Output format: \'profile\' (default) or \'manifest\' (capability manifest JSON)' -r -f -a "profile\t''
manifest\t''"
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from show" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from show" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from show" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from show" -l raw -d 'Show raw paths before expansion (e.g., $HOME instead of /Users/luke)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from show" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from diff" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from diff" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from diff" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from diff" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from validate" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from validate" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from validate" -l draft -d 'Treat the argument as a draft name under ~/.config/nono/profile-drafts'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from validate" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from validate" -l strict -d 'Treat deprecated schema warnings as errors (exit code 2 if any are found)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from validate" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from validate" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from promote" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from promote" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from promote" -l diff -d 'Show the proposed diff without applying it'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from promote" -l yes -d 'Apply without interactive confirmation'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from promote" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from promote" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from groups" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from groups" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from groups" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from groups" -l all-platforms -d 'Show all platforms (not just current)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from groups" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from schema" -s o -l output -d 'Write schema to a file instead of stdout' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from schema" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from schema" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from schema" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from guide" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from guide" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from guide" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "init" -d 'Generate a skeleton profile JSON file'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all available profiles (built-in and user)'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "show" -d 'Show a fully resolved profile'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "diff" -d 'Diff two profiles'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "validate" -d 'Validate a profile JSON file'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "promote" -d 'Review and apply a profile draft from ~/.config/nono/profile-drafts'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "groups" -d 'List policy groups or show details for a specific group'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "schema" -d 'Output the JSON Schema for profile files'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "guide" -d 'Print the profile authoring guide'
complete -c nono -n "__fish_nono_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c nono -n "__fish_nono_using_subcommand pull" -l registry -d 'Registry base URL' -r
complete -c nono -n "__fish_nono_using_subcommand pull" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand pull" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand pull" -l force -d 'Overwrite conflicts and accept signer changes'
complete -c nono -n "__fish_nono_using_subcommand pull" -l init -d 'Copy project instructions into the current directory'
complete -c nono -n "__fish_nono_using_subcommand pull" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand pull" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand remove" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand remove" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand remove" -l force -d 'Continue removal even if some wiring directives fail to reverse. Without this flag, partial reversal failures keep the lockfile entry intact so the user can retry, since silently forgetting a half-removed pack would orphan agent wiring (e.g. a hook entry in `~/.codex/hooks.json` left active with no record of who put it there)'
complete -c nono -n "__fish_nono_using_subcommand remove" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand remove" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand update" -l registry -d 'Registry base URL' -r
complete -c nono -n "__fish_nono_using_subcommand update" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand update" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand update" -l dry-run -d 'Show what would be updated without making changes'
complete -c nono -n "__fish_nono_using_subcommand update" -l force -d 'Update pinned packs and accept signer changes'
complete -c nono -n "__fish_nono_using_subcommand update" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand update" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand search" -l registry -d 'Registry base URL' -r
complete -c nono -n "__fish_nono_using_subcommand search" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand search" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand search" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand search" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand search" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand list" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand list" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand list" -l installed -d 'Show installed nono packs'
complete -c nono -n "__fish_nono_using_subcommand list" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand list" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand list" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand pin" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand pin" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand pin" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand pin" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand unpin" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand unpin" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand unpin" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand unpin" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand outdated" -l registry -d 'Registry base URL' -r
complete -c nono -n "__fish_nono_using_subcommand outdated" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand outdated" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand outdated" -l json -d 'Output as JSON'
complete -c nono -n "__fish_nono_using_subcommand outdated" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand outdated" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand completion" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand completion" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand completion" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand completion" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand open-url-helper" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand open-url-helper" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand open-url-helper" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand open-url-helper" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand pack-update-hint-helper" -l theme -d 'Color theme for output (mocha, latte, frappe, macchiato, tokyo-night, minimal)' -r
complete -c nono -n "__fish_nono_using_subcommand pack-update-hint-helper" -l log-file -d 'Write logs to a file instead of stderr' -r -F
complete -c nono -n "__fish_nono_using_subcommand pack-update-hint-helper" -s s -l silent -d 'Silent mode - suppress all nono output (banner, summary, status)'
complete -c nono -n "__fish_nono_using_subcommand pack-update-hint-helper" -s h -l help -d 'Print help'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "setup" -d 'Set up nono on this system'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "run" -d 'Run a command inside the sandbox'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "shell" -d 'Start an interactive shell inside the sandbox'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "wrap" -d 'Apply sandbox and exec into command (nono disappears). For scripts, piping, and embedding where no parent process is wanted'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "learn" -d '[deprecated] Use `nono run` to learn from sandbox denials DEPRECATED(canonical="nono run", introduced="v0.50.1", remove_by="v1.0.0", issue="#445")'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "why" -d 'Check why filesystem, network, scope, or command access would be allowed or denied'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "proxy" -d 'Run the network filtering / credential proxy as a standalone server'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "rollback" -d 'Manage rollback sessions (browse, restore, cleanup)'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "audit" -d 'View audit trail of sandboxed commands'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "trust" -d 'Manage file trust and attestation'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "ps" -d 'List running sandboxed sessions'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "stop" -d 'Stop a running sandboxed session'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "detach" -d 'Detach from a running sandboxed session and return to the shell'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "attach" -d 'Attach to a detached or running session from another terminal'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "logs" -d 'View event log for a session'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "inspect" -d 'Show detailed information about a session'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "prune" -d 'Clean up old session files'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "session" -d 'Manage runtime session storage'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "policy" -d '[deprecated] Use \'nono profile\' instead'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "profile" -d 'Create, inspect, and compare nono profiles'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "pull" -d 'Install a signed nono pack from the registry'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "remove" -d 'Remove an installed nono pack'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "update" -d 'Update installed nono packs'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "search" -d 'Search the registry for nono packs'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "list" -d 'List installed nono packs'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "pin" -d 'Pin an installed pack to its current version, excluding it from updates'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "unpin" -d 'Unpin a pack so it is included in updates again'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "outdated" -d 'Show which installed packs have newer versions available'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "completion" -d 'Generate shell completion scripts'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "open-url-helper" -d 'Internal: open a URL via supervisor IPC'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "pack-update-hint-helper" -d 'Internal: refresh cached pack update hints out of process'
complete -c nono -n "__fish_nono_using_subcommand help; and not __fish_seen_subcommand_from setup run shell wrap learn why proxy rollback audit trust ps stop detach attach logs inspect prune session policy profile pull remove update search list pin unpin outdated completion open-url-helper pack-update-hint-helper help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from rollback" -f -a "list" -d 'List rollback sessions'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from rollback" -f -a "show" -d 'Show changes in a session'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from rollback" -f -a "restore" -d 'Restore files from a past session'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from rollback" -f -a "verify" -d 'Verify session integrity'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from rollback" -f -a "cleanup" -d 'Clean up old sessions'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from audit" -f -a "list" -d 'List all sandboxed sessions'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from audit" -f -a "show" -d 'Show audit details for a session'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from audit" -f -a "verify" -d 'Verify audit integrity by recomputing hashes from the event log'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from audit" -f -a "cleanup" -d 'Remove old audit sessions'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from trust" -f -a "init" -d 'Create a trust-policy.json in the current directory'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from trust" -f -a "sign" -d 'Sign a file, producing a .bundle alongside it'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from trust" -f -a "sign-policy" -d 'Sign a trust policy file, producing a .bundle alongside it'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from trust" -f -a "verify" -d 'Verify a file\'s bundle against the trust policy'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from trust" -f -a "list" -d 'List files and their verification status'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from trust" -f -a "keygen" -d 'Generate a new ECDSA P-256 signing key pair'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from trust" -f -a "export-key" -d 'Export the public key for a signing key (base64 DER)'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from session" -f -a "cleanup" -d 'Remove old runtime sessions'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from policy" -f -a "groups" -d '[deprecated] Use \'nono profile groups\' instead'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from policy" -f -a "profiles" -d '[deprecated] Use \'nono profile list\' instead'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from policy" -f -a "show" -d '[deprecated] Use \'nono profile show\' instead'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from policy" -f -a "diff" -d '[deprecated] Use \'nono profile diff\' instead'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from policy" -f -a "validate" -d '[deprecated] Use \'nono profile validate\' instead'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "init" -d 'Generate a skeleton profile JSON file'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "list" -d 'List all available profiles (built-in and user)'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "show" -d 'Show a fully resolved profile'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "diff" -d 'Diff two profiles'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "validate" -d 'Validate a profile JSON file'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "promote" -d 'Review and apply a profile draft from ~/.config/nono/profile-drafts'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "groups" -d 'List policy groups or show details for a specific group'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "schema" -d 'Output the JSON Schema for profile files'
complete -c nono -n "__fish_nono_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "guide" -d 'Print the profile authoring guide'
