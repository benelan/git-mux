% git-mux(1) git-mux user manual
% Ben Elan <no-reply@benelan.dev>
% Aug 9, 2023

# NAME

git-mux - a git+tmux lovechild for jumping between projects and tasks, blazingly fast.

# SYNOPSIS

git mux <option> [arg...]

# COMMANDS

c, clone

    Clone and configure a bare git repo for use with worktrees.

p, project

    Create or switch to a project (tmux session). Projects are usually (but not required to be) a git repo.

t, task

    Create, switch, or send text to a task (tmux window). Tasks are usually (but not required to be) a git worktree.

h, help

    Show this message, or show help for one of the above commands by providing it as an argument.

config

    Print the current configuration values to stdout.

# EXAMPLES

Select a project and create or switch to its tmux session

```sh
$ git mux p
```

Directly create or switch to a project (useful for aliases/keymaps/startup)

```sh
$ git mux project ~/projects/my-app
```

Select a git branch and create or switch to its git worktree and tmux window

```sh
$ git mux t
```

If 'feature/123' is a valid path, it will be used for the task.
Otherwise assume it is a git branch, creating the branch if it doesn't exist.
If the project is a bare repo, create and/or switch to its worktree.
Otherwise checkout the new branch.
All 3 cases create and/or switch to a tmux window named '123' (basename).
The window name can be specified with an additional argument.

```sh
$ git mux task feature/123
```

Run commands in a tmux window named npm_stuff without switching to it
Specifying a window name is required when sending commands

```sh
$ git mux task ~/projects/my-app npm_stuff npm i && npm run build
```

# ENVIRONMENT VARIABLES

git-mux can be configured with the following environment variables:

GIT_MUX_PROJECTS

    Space-separated list of projects for selection.

GIT_MUX_PROJECT_PARENTS

    Space-separated list of directories that contain projects.

    - defaults to $PROJECTS or $HOME
    - selects from child dirs using `find` (depth of 1)
    - ignored if $GIT_MUX_PROJECTS is set

GIT_MUX_SELECT_CMD

    Command used to select a project.
    - defaults to `fzf`
    - receives the directory list from stdin
    - sends a single, selected directory to stdout

GIT_MUX_BRANCH_PREFIX

    A string to prepend to new branches created via task.
    - off by default
    - the resulting branch format is "<prefix>/<name>"
    - ignored if the provided <name> already contains a "/"
    - common examples: "feature" or "$(id -un)"

GIT_MUX_NEW_WORKTREE_CMD

    Commands to execute in the tmux window when a new
    git worktree is created via task.
    - off by default
    - example: [ -f "./package.json" ] && npm i

GIT_MUX_LOGS

    Path to a file for printing logs.
    - Set to "0" to disable logging.
    - default is picked in the following order:
    - "$XDG_STATE_HOME/shutils/git-mux.log"
    - "$HOME/.local/state/shutils/git-mux.log"
    -  <shutils repo clone>/logs/git-mux.log

# COMPATIBILITY

`git-mux` is POSIX compliant (according to ShellCheck), meaning you should be
able to use `git-mux`. Please log an issue on GitHub if you experience
compliance problems. Additionally, the following dependencies are used:

- `tmux` (required)
- `git` (required)
- `grep` (required)
- `fzf` (to replace, see: `man git-mux-config`)
- `find` (to prevent usage, see: `man git-mux-config`)
