# git mux

A git + tmux lovechild for blazingly fast movement between. See the
[MANUAL](./MANUAL.md) for usage instructions.

## Installation

The recommended installation method for a single user is to clone the
repo and add it's location to your `$PATH`. This allows you to easily update
the script with a single command (`git pull`). For example, bash users can run the
following:

```sh
git clone https://github.com/benelan/git-mux.git ~/.git-mux
echo 'export PATH="$PATH:~/.git-mux"' >> ~/.bashrc
bash -l
```

Alternatively, you can use `curl` or `wget` to download the `git-mux`
executable and man page to your `$PATH`.

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


