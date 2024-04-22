# git mux

A git + tmux lovechild for blazingly fast movement between projects and tasks.

> **NOTE:** the README is a WIP; [RTFM](./docs/MANUAL.md).

## Installation

The `stable` tag will always point to the latest release. Active development
occurs on the `master` branch, which you can think of as `nightly`. See the
[changelog](./CHANGELOG.md) for details about features and fixes released in
each version.

Use one of the following methods to install `git-mux`.

### `curl`

The **recommended** way to install `git-mux` is by using `curl` or `wget` to download
the executable and `man` page to somewhere on your `$PATH`. For example, with
`curl`:

```sh
mkdir -p ~/.local/bin ~/.local/share/man/man1
curl -Lo ~/.local/share/man/man1/git-mux.1 \
    https://raw.githubusercontent.com/benelan/git-mux/stable/bin/man/man1/git-mux.1
curl -Lo ~/.local/bin/git-mux \
    https://raw.githubusercontent.com/benelan/git-mux/stable/bin/git-mux
chmod +x ~/.local/bin/git-mux
```

To uninstall:

```sh
rm -f ~/.local/bin/git-mux ~/.local/share/man/man1/git-mux.1
```

### `git clone`

Another option is to clone the repo and add the `bin` directory to your `$PATH`.
This allows you to easily update the script with a single command (e.g.,
`git -C ~/.git-mux pull`). For example, bash users can run the following:

```sh
git clone -b stable https://github.com/benelan/git-mux.git ~/.git-mux
echo 'export PATH="$PATH:~/.git-mux/bin"' >> ~/.bashrc && bash -l
```

To uninstall, remove `~/.git-mux` and the `PATH` addition line in `~/.bashrc`.

An alternative to the `PATH` addition is using `make install` after cloning the
repo:

```sh
pushd ~/.git-mux && sudo make install && popd
```

You can remove `~/.git-mux` after installing with this method, since the
necessary files will be copied to system directories.

The above command will install `git-mux` for all users on the system. If you
don't have `sudo` privileges or only want to install for the current user, you
can specify the installation directory's `PREFIX`:

```sh
make install PREFIX=~/.local
```

When uninstalling, make sure to specify the `PREFIX` if you changed it during
installation:

```sh
pushd ~/.git-mux && make uninstall PREFIX=~/.local && popd && rm -rf ~/.git-mux
```

## Usage

See `man git-mux` in the terminal, or the [markdown version](./docs/MANUAL.md)
in the browser.

## Tips

You can add bash completion of git branch names to `git-mux`, which is useful
for the `task` command.

```sh
# Load git completion so it can be applied to executables and aliases
if ! declare -F __git_complete >/dev/null 2>&1; then
    _completion_loader git >/dev/null 2>&1
fi

# only works for `git-mux task`, not `git mux task`
__git_complete git-mux git_checkout

# Or create an alias since only the task command needs git branch completion
alias gxt="git mux task"
__git_complete gxt git_checkout
```

I have the following keybindings in my `~/.tmux.conf` for blazingly fast
navigation.

```sh
%if #{>=:#{version},3.2}
    bind C-p popup -E -E git-mux project
    bind C-t popup -E -E git-mux task
%else
    bind C-p new-window -c "#{pane_current_path}" git-mux project
    bind C-t new-window -c "#{pane_current_path}" git-mux task
%endif

bind C-n run "git-mux project ~/dev/notes"
bind C-x run "git-mux project ~/dev/personal/git-mux"
bind C-c run "git-mux project ~/dev/work/acme-components"
```

I also have the following in my `~/.bashrc`, which creates and/or attaches
to a tmux session on startup.

```sh
[ -z "$TMUX" ] && command -v git-mux >/dev/null 2>&1 && git-mux project "$PWD"
```
