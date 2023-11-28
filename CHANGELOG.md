# Changelog

## 0.1.0 (2023-11-28)

### Features

* Add better help/error messages and make sure they go to stderr ([e2dd3c5](https://github.com/benelan/git-mux/commit/e2dd3c5fd89258f677cb0f79cb8f83695b24167a))
* Add `$GIT_MUX_LOG_LEVEL` config option to only save logs for certain levels ([bd0583b](https://github.com/benelan/git-mux/commit/bd0583b6a140a7fc6dce7bb91d8bcf431533b99c))
* Combine directories specified in `$GIT_MUX_PROJECTS` and `$GIT_MUX_PROJECT_PARENTS` config options ([b33aacf](https://github.com/benelan/git-mux/commit/b33aacfe974140b7f5115387d9fb03827793a1ee))
* And `$GIT_MUX_NEW_WORKTREE_CMD` config option for executing a command in git worktrees after they are created ([2395cc2](https://github.com/benelan/git-mux/commit/2395cc2fc1ea43ea3ebd61a06de0e005f283dec3)), ([7dc1af7](https://github.com/benelan/git-mux/commit/7dc1af78b2bf8b4c061c741a5f580b1300252de3))

### Bug Fixes

* Log level off by one error ([9960fe6](https://github.com/benelan/git-mux/commit/9960fe6c660afd56f3c1b7e378072173a25c75c4))
* **task**: Only add branch prefix if one doesn't exist ([097c6e2](https://github.com/benelan/git-mux/commit/097c6e2033fc2be2e765428b4fff0af3ac8cf5e4))
* Prevent trying to write to a nonexistent log file ([c375081](https://github.com/benelan/git-mux/commit/c3750814ee89791575666d849f8aaf6261720d1e))
* **task:** Remove trailing space in tmux window name for new git tasks ([00b911d](https://github.com/benelan/git-mux/commit/00b911d4a13639b151c8def1d90af18413b5b851))
* **project:** Attach to existing tmux session if it exists ([f646543](https://github.com/benelan/git-mux/commit/f6465436b79bb967e30f07c39d3ab13074cc1e7d))
* **project:** Fallback to creating the tmux session in `$HOME` if the path argument is not provided ([26d6165](https://github.com/benelan/git-mux/commit/26d61659ea20d75e921fc735df265f2f5df60843))
* Stop exiting early when checking log level ([9df85b5](https://github.com/benelan/git-mux/commit/9df85b5f481deea5bf9df8507052c5c8f9b7f239))
* **task:** Stop combining multiple arguments into a single string ([7fbf5f3](https://github.com/benelan/git-mux/commit/7fbf5f3369cba27ee1098a94ff55ade58b33b9dc))
* **task:** Change `tmux new-window` command options for backwards compatibility ([fcf36f7](https://github.com/benelan/git-mux/commit/fcf36f7bcc882c8629f4f249fd1af956a9237b75))
