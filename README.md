# git mux

A git + tmux lovechild for blazingly fast movement between. See the
[MANUAL](./docs/MANUAL.md) for usage instructions.

**NOTE:** the README is a WIP; [RTFM](./docs/MANUAL.md).

## Installation

The recommended installation method for a single user is to clone the
repo and add the `bin` directory to your `$PATH`. This allows you to easily update
the script with a single command (`git pull`). For example, bash users can run the
following:

```sh
git clone https://github.com/benelan/git-mux.git ~/.git-mux
echo 'export PATH="$PATH:~/.git-mux/bin"' >> ~/.bashrc
bash -l
```

Alternatively, you can use `curl` or `wget` to download the `git-mux`
executable and man page to somewhere on your `$PATH`.

```sh
mkdir -p ~/.local/bin/man/man1
curl -sSLo ~/.local/bin/man/man1/git-mux.1 \
    https://raw.githubusercontent.com/benelan/git-mux/master/man/man1/git-mux.1
curl -sSLo ~/.local/bin/git-mux \
    https://raw.githubusercontent.com/benelan/git-mux/master/git-mux
chmod +x ~/.local/bin/git-mux
```

To install `git-mux` for a multi-user system:

```sh
git clone https://github.com/benelan/git-mux.git /tmp/git-mux
cd /tmp/git-mux
make
sudo make install
```

## Tips

I have the following keybindings in my `.tmux.conf` for blazingly fast navigation.

```conf
%if #{>=:#{version},3.2}
    bind C-p popup -E -E git mux project
    bind C-t popup -E -E git mux task
%else
    bind C-p new-window -c '#{pane_current_path}' git mux project
    bind C-t new-window -c '#{pane_current_path}' git mux task
%endif

bind C-h run 'git mux project $HOME'
bind C-n run 'git mux project ~/dev/notes'
bind C-c run 'git mux project ~/dev/work/acme-components'
```

I also have have the following in my `.bashrc`, which creates and/or attaches to a tmux session on startup.

```sh
# ensure tmux is running
[ -z "$TMUX" ] && command -v git-mux >/dev/null 2>&1 && git-mux project "$PWD"
```
