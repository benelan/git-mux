# git mux

A git + tmux lovechild for blazingly fast movement between projects and tasks.

> **NOTE:** the README is a WIP; [RTFM](./docs/MANUAL.md).

## Installation

The easiest way to install `git-mux` is by using `curl` or `wget` to download the
executable and `man` page to somewhere on your `$PATH`. For example, with `curl`:

```sh
mkdir -p ~/.local/bin/man/man1
curl -Lo ~/.local/bin/man/man1/git-mux.1 \
    https://raw.githubusercontent.com/benelan/git-mux/stable/bin/man/man1/git-mux.1
curl -Lo ~/.local/bin/git-mux \
    https://raw.githubusercontent.com/benelan/git-mux/stable/bin/git-mux
chmod +x ~/.local/bin/git-mux

# To uninstall:
# rm -rf ~/.local/bin/git-mux ~/.local/bin/man/man1/git-mux.1
```

Another option is to clone the repo and add the `bin` directory to your `$PATH`.
This allows you to easily update the script with a single command
(`git -C ~/.git-mux pull`). For example, bash users can run the following:

```sh
git clone -b stable https://github.com/benelan/git-mux.git ~/.git-mux
echo 'export PATH="$PATH:~/.git-mux/bin"' >> ~/.bashrc && bash -l

# To uninstall, remove ~/.git-mux and the line added to your shell startup script
```

To install `git-mux` for a multi-user system:

```sh
git clone -b stable https://github.com/benelan/git-mux.git ~/.git-mux
cd ~/.git-mux && make && sudo make install && cd - && rm -rf ~/.git-mux

# To uninstall, use the first line above to re-clone the repo and run:
# cd ~/.git-mux && sudo make uninstall && cd - && rm -rf ~/.git-mux
```

> **NOTE:** The `stable` tag will always point to the latest release. Active
> development occurs on the `master` branch, which you can think of as `nightly`.

## Usage

See `man git-mux` in the terminal, or the [markdown version](./docs/MANUAL.md)
in the browser.

## Tips

I have the following keybindings in my `~/.tmux.conf` for blazingly fast navigation.

```sh
%if #{>=:#{version},3.2}
    bind C-p popup -E -E git mux project
    bind C-t popup -E -E git mux task
%else
    bind C-p new-window -c "#{pane_current_path}" git mux project
    bind C-t new-window -c "#{pane_current_path}" git mux task
%endif

bind C-h run "git mux project $HOME"
bind C-n run "git mux project ~/dev/personal/git-mux"
bind C-c run "git mux project ~/dev/work/acme-components"
```

I also have have the following in my `~/.bashrc`, which creates and/or attaches
to a tmux session on startup.

```sh
# ensure tmux is running
[ -z "$TMUX" ] && command -v git-mux >/dev/null 2>&1 && git-mux project "$PWD"
```
