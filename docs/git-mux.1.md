% git-mux(1) git-mux user manual
% Ben Elan <no-reply@benelan.dev>
% Aug 9, 2023

# NAME

git-mux - a git and tmux tool for managing multiple projects and tasks

# SYNOPSIS

git mux <option> [arg...]

# OPTIONS

    c,  clone       Clone and configure a bare git repo for use with worktrees.
    p,  project     Create or switch to a project (tmux session).
                    Projects are usually (but not required to be) a git repo.
    t,  task        Create, switch, or send text to a task (tmux window).
                    Tasks are usually (but not required to be) a git worktree.
        config      Print the current configuration values to stdout.
    h,  help        Show this message.

# DESCRIPTION

# EXAMPLES

    - Select a project and create or switch to its tmux session
        $ git mux p

    - Directly create or switch to a project (useful for aliases/keymaps/startup)
        $ git mux project ~/projects/my-app

    - Select a git branch and create or switch to its git worktree and tmux window
        $ git mux t

    - If 'feature/123' is a valid path, it will be used for the task.
      Otherwise assume it is a git branch, creating the branch if it doesn't exist.
      If the project is a bare repo, create and/or switch to its worktree.
      Otherwise checkout the new branch.
      All 3 cases create and/or switch to a tmux window named '123' (basename).
      The window name can be specified with an additional argument.
          $ git mux task feature/123

    - Run commands in a tmux window named npm_stuff without switching to it
      Specifying a window name is required when sending commands
          $ git mux task ~/projects/my-app npm_stuff npm i && npm run build

# COMPATIBILITY

git-mux is POSIX compliant (according to ShellCheck), meaning you should be
able to use git-mux. Please log an issue on GitHub if you experience
compliance problems. The following dependencies are used:

- tmux (required)
- git (required)
- grep (required)
- fzf (see `man git-mux-config` for replacement option)
- find (see `man git-mux-config` to prevent usage)

