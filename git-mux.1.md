% git-mux(1) git-mux user manual
% Ben Elan <no-reply@benelan.dev>
% Aug 9, 2023

# NAME

__git-mux__ - a git + tmux lovechild for jumping between projects and tasks, blazingly fast.


# SYNOPSIS

__git mux__ _clone_ \<_repository_\>

__git mux__ _project_ [\<_path_\>]

__git mux__ _task_ \<_branch-name_\>] [\<_window-name_\>]

__git mux__ _task_ \<_path_\> [\<_window-name_\>] [\<_remote-command_\>...]

__git mux__ _config_

__git mux__ _help_


# COMMANDS

- __c__, __clone__

  Clone and configure a bare __git__(1) \<_repository_\> for use with worktrees.

- __p__, __project__

  Create or switch to a _project_, which is a __tmux__(1) session.
  Projects are also usually (but not required to be) a git repo.

- __t__, __task__

  Create, switch, or send text to a _task_, which is a __tmux__(1) window.
  Tasks are also usually (but not required to be) a __git-worktree__(1)
  or __git-branch__(1).

- __h__, __help__

  Print a concise help message to _stdout_.

- __config__

  Print the current configuration values to _stdout_.


# EXAMPLES

- __git mux p__

  Select a _project_, then create and/or switch to its __tmux__(1) session.

- __git mux project ~/projects/my-app__

  Directly create and/or switch to a _project_ (useful for aliases/keybindings).

- __git mux t__

  Select a __git-branch__(1), then create and/or switch to its
  __git-worktree__(1) and __tmux__(1) window.

- __git mux task feature/123__

  If "feature/123" is a valid \<_path_\>, it will be used for the _task_.
  Otherwise assume it is a \<_branch-name_\>, creating the branch if it doesn't exist.
  If the _project_ is a bare repo, create and/or switch to its __git-worktree__(1).
  Otherwise checkout the __git-branch__(1).
  
  By default, all of the above cases create and/or switch to a __tmux__(1) window
  named "123", via __basename__(1). The tmux \<_window-name_\> can be specified
  with an additional argument.

- __git mux task ~/projects/my-app npm_stuff npm i && npm run build__

  Run commands in a __tmux__(1) window named "npm_stuff" without switching to it.
  Specifying a \<_window-name_\> is required when sending commands.


# ENVIRONMENT VARIABLES

__git-mux__ can be configured with the following environment variables:

- __GIT_MUX_PROJECTS__

  Space-separated list of projects for selection. The _project_ paths
  must be absolute, and can start with "~".

- __GIT_MUX_PROJECT_PARENTS__

  Space-separated list of directories that contain projects.
  Defaults to __\$PROJECTS__ if set, otherwise __\$HOME__.
  Uses __find__(1) to get child directories (depth of 1),
  which are then used for __\$GIT_MUX_PROJECTS__.
  However, this option is ignored if __\$GIT_MUX_PROJECTS__ is already set.

- __GIT_MUX_SELECT_CMD__

  Command used to select a _project_. Defaults to using __fzf__(1).
  This can be changed to any command, as long as it receives the directory
  list from _stdin_ and sends a single, selected directory to _stdout_.

- __GIT_MUX_BRANCH_PREFIX__

  A \<_prefix_\> string to prepend to new branches created via _task_.
  Unset by default.

  When set, the resulting __git-branch__(1) name is
  "\<_prefix_\>/\<_branch-name_\>". This option is ignored if
  the provided \<_branch-name_\> already contains a "/".

  Some common examples are __"feature"__ and __"\$(id -un)"__.

- __GIT_MUX_NEW_WORKTREE_CMD__

  Specify a set of commands to execute in the __tmux__(1) window when a new
  __git-worktree__(1) is created via the _task_ command. Unset by default.

  For example: __"\[ -f "./package.json" \] && npm i"__

- __GIT_MUX_LOGS__

  Path to a log file. Logs are disabled if set to "0" or unset, which
  is the default.

  If set to "1", a default path is determined by first checking
  if __\$XDG_STATE_HOME__ is set, then if __\$HOME/.local/state__ is a directory,
  and finally falling back to __\$HOME__. The log file will be create as
  _./git-mux/logs_ in the determined directory.


# COMPATIBILITY

__git-mux__ is POSIX compliant (according to ShellCheck), meaning it should
work on your system. See the _BUGS_ section below if you experience compatibility problems.

The following dependencies are required:
  __tmux__(1), __git__(1), __grep__(1)

These dependencies are optional:
  __fzf__(1), __find__(1)

See the _ENVIRONMENT VARIABLES_ section for alternatives to the optional dependencies.

# BUGS

If you experience any problems with __git_mux__ or have ideas for a new feature, please submit an issue on GitHub:
https://github.com/benelan/git-mux/issues

# SEE ALSO

__git-repository-layout__(7), __git-worktree__(1), __tmux__(1)

