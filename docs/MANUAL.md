# MANUAL

## NAME

**git-mux** - a git + tmux lovechild for blazingly fast movement between
projects and tasks

## SYNOPSIS

**git mux clone** \<repository\> \[\<directory\>\]  
**git mux project** \[\<directory\>\]  
**git mux task** \[\<branch\>\] \[\<window\>\]  
**git mux task** \<directory\> \[\<window\>\] \[\<command\>...\]  
**git mux help**

## COMMANDS

### clone

Clone and configure a bare **git**(1) \<repository\> for use with
worktrees.

Aliases: **c**, **-c**, **--clone**

### project

Create and/or switch to a _project_, which is a **tmux**(1) session.
Projects are also usually a **git**(1) repo, but they can be created for
any directory.

Aliases: **p**, **-p**, **--project**

### task

Create, switch, and/or send commands to a _task_, which is a **tmux**(1)
window. Tasks are also usually a **git-worktree**(1) or
**git-branch**(1), but can be created for any directory.

Aliases: **t**, **-t**, **--task**

### help

Open the **git-mux** man page. Use **h** or **-h** to print a concise
help message to **stderr**(3) instead.

Aliases: **--help**

## EXAMPLES

Select a _project_, then create and/or switch to its **tmux**(1)
session. Selects with **fzf**(1) by default, but the command can be
changed using **\$GIT_MUX_SELECT_CMD**. See the [ENVIRONMENT](#environment) section.

```sh
git mux p
```

Directly create and/or switch to a _project_ (useful for a keymap or
alias).

```sh
git mux project ~/projects/my-app
```

Create and/or switch to a **tmux**(1) \<window\> named "123" via
**basename**(1). If "feature/123" is a valid \<directory\>, the window
will be opened at that location. Otherwise, assume it is a **git**(1)
\<branch\> name. Create and/or switch to the **git-worktree**(1) if the
_project_ is a bare repo, otherwise create and/or checkout the
**git-branch**(1).

```sh
git mux task feature/123
```

Select an existing **git-branch**(1) for the _task_.

```sh
git mux t
```

Install dependencies and run tests in a **tmux**(1) \<window\> named
"test_client" without switching to it. Specifying the \<window\> name
is required when sending commands.

```sh
git mux task packages/client test_client npm i && npm test
```

## ENVIRONMENT

**git-mux** can be configured with the following environment variables.
Specifying the _project_ directories with either **\$GIT_MUX_PROJECTS**
or **\$GIT_MUX_PROJECT_PARENTS** is required, and setting both will
combine their values. All other configuration is optional.

### GIT_MUX_PROJECTS

Space delimited list of individual _project_ directories for selection.
The paths must be absolute or start with "\~" and cannot contain spaces.

```sh
export GIT_MUX_PROJECTS="~/notes ~/.config/nvim"
```

### GIT_MUX_PROJECT_PARENTS

Space delimited list of directories that contain projects, defaults to
**\$PROJECTS** if set. The immediate child directories (depth=1) of each
parent are used for selection. The paths must be absolute or start with
"\~" and cannot contain spaces.

```sh
export GIT_MUX_PROJECT_PARENTS="~/dev/work ~/dev/personal"
```

In the **\$GIT_MUX_PROJECTS** and **\$GIT_MUX_PROJECT_PARENTS**
examples above, the resulting _project_ list used for selection would
be:

```text
~/notes
~/.config/nvim
~/work/acme-cli
~/work/acme-site
~/personal/my-brilliant-app-ideas
~/personal/my-failed-startup
```

Assuming the following file structure:

```text
~/
├─ .config/
│  ├─ nvim/
│  │  ├─ lua/
│  │  ├─ init.lua
├─ notes/
│  ├─ how_to_quit_neovim.md
│  ├─ ada_lawsuit_summary.doc
├─ personal/
│  ├─ my-brilliant-app-ideas/
│  ├─ my-failed-startup/
│  │  ├─ whats_a11y.html
├─ work/
│  ├─ acme-cli/
│  │  ├─ download_more_ram.js
│  ├─ acme-site/
│  │  ├─ src/
│  │  │  ├─ spaghetti.jsx
```

### GIT_MUX_SELECT_CMD

Command used to select a _project_ or _task_. Defaults to **fzf**(1).
This can be any command that receives the directory list from
**stdin**(3) and prints a single, selected directory to **stdout**(3).

For example, create the following script somewhere on your **\$PATH**
(e.g., _\~/.local/bin/\_git-mux-select_), to use **dialog**(1) for
selection:

```sh
##!/usr/bin/env sh
stdin=$(cat)
dialog --no-items --erase-on-exit --menu "GIT MUX" 0 0 0 $stdin 2>&1 >/dev/tty
```

Then add the following to your shell startup scripts (e.g.,
_\~/.bashrc_):

```sh
export GIT_MUX_SELECT_CMD="_git-mux-select"
```

### GIT_MUX_BRANCH_PREFIX

A \<prefix\> string to prepend to the name of new branches created via
the _task_ command. When set, the resulting **git-branch**(1) name is
"\<prefix\>/\<branch\>". This option is ignored if the \<branch\> name
provided to _task_ already contains a "/".

For example, the following would create a **git-branch**(1) named
"JohnDoe/fix-123" if your GitHub username (system user as backup) is
"JohnDoe":

```sh
export GIT_MUX_BRANCH_PREFIX="$(git config --global github.user || id -un)"
git mux task fix-123
```

### GIT_MUX_NEW_WORKTREE_CMD

Command(s) to execute in the **tmux**(1) window when a new
**git-worktree**(1) is created via the _task_ command. Unset by default.
You can assume that **\$PWD** is the root directory of the new worktree.

For example, to install Node.js dependencies in new worktrees (when
relevant):

```sh
export GIT_MUX_NEW_WORKTREE_CMD='[ -f "./package.json" ] && npm i'
```

Creating a script somewhere on your **\$PATH** for more complicated
commands is recommended. See **\$GIT_MUX_SELECT_CMD** above for an
example.

### GIT_MUX_NEW_SESSION_CMD

Command(s) to execute when a new **tmux**(1) session is created via the
**project** command. Unset by default. You can assume that **\$PWD** is
the root directory of the specified project.

For example, to rename the **tmux**(1) window to "scratch":

```sh
export GIT_MUX_NEW_SESSION_CMD='tmux rename-window scratch'
```

Creating a script somewhere on your **\$PATH** for more complicated
commands is recommended. See **\$GIT_MUX_SELECT_CMD** above for an
example.

### GIT_MUX_LOGS

A path to the log file. Logs are disabled if set to "0" or unset, which
is the default. If set to "1", the logs are saved to
_\${XDG_STATE_HOME:-$HOME/.local/state}/git-mux/logs_.

### GIT_MUX_LOG_LEVEL

The minimum level of log entries to save, defaults to all levels if
logging is enabled via **\$GIT_MUX_LOGS**. The log levels are:

_DEBUG_ \< _INFO_ \< _WARN_ \< _ERROR_

For example, to save log entries with _ERROR_ and _WARN_ levels:

```sh
export GIT_MUX_LOG_LEVEL="WARN"
```

## BUGS

The following are known limitations of **git-mux**:

- Project paths cannot contain spaces.

Try these troubleshooting tips if you are experiencing issues:

- Run **git mux config** to print the current config values and make
  sure they're what you expect.

- Enable logs using the **\$GIT_MUX_LOGS** config option and rerun
  the command that caused issues. See the [ENVIRONMENT](#environment) section for
  more info.

If none of the troubleshooting steps helped resolve the issue, please
submit an issue on GitHub:

_<https://github.com/benelan/git-mux/issues>_

## COMPATIBILITY

The following external tools are used by **git-mux**:

- **tmux**(1) - Required.

- **git**(1) - Required by the _task_ command if the next argument is
  not a valid directory. Also required to execute the script as **git
  mux** versus **git-mux**.

- **fzf**(1) - Required by default, but can be changed using the
  **\$GIT_MUX_SELECT_CMD** configuration option. See the
  [ENVIRONMENT](#environment) section.

**git-mux** should be POSIX compliant (other than the non-standard
utilities listed above), meaning it will likely work on your system.
Unless you're using Windows without WSL, in which case I don't know how
you ended up reading this documentation in the first place.

Please log an issue if you experience any compatibility issues on a Unix
machine.

## SEE ALSO

**git-repository-layout**(7), **git-worktree**(1), **tmux**(1),
**fzf**(1)
