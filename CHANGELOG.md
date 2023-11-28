# Changelog

## 0.1.0 (2023-11-28)


### ⚠ BREAKING CHANGES

* requires appending '/bin' to the git-mux entry in your $PATH. Does not apply to users who installed git-mux with `make`.
* removed os-detect, os-cb, os-open, and matpat scripts to simplify the scope of the repo. The repo will only be for git-mux.
* **git-mux:** more logging changes
* **git-mux:** removed debug command and GIT_MUX_DEBUG config option, use the logging options specified above instead.
* the startup command has been removed, use project "$PWD" instead
* changed the configuration options and added more doc

### Features

* Add better help and error messages ([e2dd3c5](https://github.com/benelan/git-mux/commit/e2dd3c5fd89258f677cb0f79cb8f83695b24167a))
* Add matpat and os utilities ([e74f97a](https://github.com/benelan/git-mux/commit/e74f97a9cbf825561712047cc59f6834a057ae31))
* Add option to only save logs for certain levels ([bd0583b](https://github.com/benelan/git-mux/commit/bd0583b6a140a7fc6dce7bb91d8bcf431533b99c))
* **config:** Combine directories specified in projects and project parents ([b33aacf](https://github.com/benelan/git-mux/commit/b33aacfe974140b7f5115387d9fb03827793a1ee))
* **git-mux:** And config option for executing command in new git worktree ([2395cc2](https://github.com/benelan/git-mux/commit/2395cc2fc1ea43ea3ebd61a06de0e005f283dec3))
* **git-mux:** Logs/docs rework and run commands for new worktrees ([7dc1af7](https://github.com/benelan/git-mux/commit/7dc1af78b2bf8b4c061c741a5f580b1300252de3))
* **matpat:** Add logging ([25f293f](https://github.com/benelan/git-mux/commit/25f293f259dfff7b101c6809f707fc1f4d8110fd))
* **os-cb:** Set osc52 escape code for copying in ssh session ([b9191e2](https://github.com/benelan/git-mux/commit/b9191e25509b7ed5230a5417b216faa2caaf8b3b))


### Bug Fixes

* Actually add matpat and os utilities ([e177112](https://github.com/benelan/git-mux/commit/e17711270ee2ee49af87c4d5092489c5a651bc77))
* Log level off by one error ([9960fe6](https://github.com/benelan/git-mux/commit/9960fe6c660afd56f3c1b7e378072173a25c75c4))
* Only add branch prefix if one doesn't exist ([097c6e2](https://github.com/benelan/git-mux/commit/097c6e2033fc2be2e765428b4fff0af3ac8cf5e4))
* Prevent trying to write to a nonexistent log file ([c375081](https://github.com/benelan/git-mux/commit/c3750814ee89791575666d849f8aaf6261720d1e))
* Remove trailing space in tmux window name for new git tasks ([00b911d](https://github.com/benelan/git-mux/commit/00b911d4a13639b151c8def1d90af18413b5b851))
* **startup:** Attach to existing session if exists ([f646543](https://github.com/benelan/git-mux/commit/f6465436b79bb967e30f07c39d3ab13074cc1e7d))
* **startup:** Fallback to home dir if path argument is not provided ([26d6165](https://github.com/benelan/git-mux/commit/26d61659ea20d75e921fc735df265f2f5df60843))
* Stop exiting early when checking log level ([9df85b5](https://github.com/benelan/git-mux/commit/9df85b5f481deea5bf9df8507052c5c8f9b7f239))
* **task:** Multiple arguments no longer combined into single string ([7fbf5f3](https://github.com/benelan/git-mux/commit/7fbf5f3369cba27ee1098a94ff55ade58b33b9dc))
* **task:** New-window backwards compatability ([fcf36f7](https://github.com/benelan/git-mux/commit/fcf36f7bcc882c8629f4f249fd1af956a9237b75))


### Code Refactoring

* Changed the configuration options and added more doc ([88487aa](https://github.com/benelan/git-mux/commit/88487aa606154bf3153db36298ee6f2642cb4635))
* Cleanup repo and reduce scope to only cover git-mux ([108097d](https://github.com/benelan/git-mux/commit/108097d87fa021d7158fe656310bc0b0164ee86d))
* **git-mux:** More logging changes ([a0f05e0](https://github.com/benelan/git-mux/commit/a0f05e0d2e357c4edd448def2bba0378804d9f60))
* Move executable to bin/ subdirectory and the manual to docs/ ([214e4de](https://github.com/benelan/git-mux/commit/214e4de56322e57b06610f1b502a3edf0fb3b466))
* Remove startup command in favor of project ([b868d5f](https://github.com/benelan/git-mux/commit/b868d5fe3460beee68e87b632ebf5be1c5cb26bc))
