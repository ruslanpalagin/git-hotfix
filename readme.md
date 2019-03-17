# Version 2.0.2 released (not BC, read changelog)

# Why hf? 

`hf`'s goal is to reduce amount of work with git. 
Similar to (and inspired by) git-flow: https://danielkummer.github.io/git-flow-cheatsheet/index.ru_RU.html
ANY command will ask your confirmation so do not afraid to test it!

# Install

```
git clone https://github.com/ruslanpalagin/git-hotfix.git && cd git-hotfix && chmod +x hf && sudo ln -s $PWD/hf /usr/bin/hf
```

#### Do not have ruby?

```
sudo apt-get install ruby
```

# Update

```
hf self-update
```

# Usage hints

```
Version: 1.2.2

Examples:

hf 777
hf save "its a comment"
hf save master develop "its a comment"
hf deploy master develop "its a comment"
hf delete-merged
hf config
hf self-update [VERSION]
hf sync
hf reset
hf get
hf st

Options: 

No push: (--local|--l) prevents pushes to remote
Silent: (--quiet|--q) Skips some messages
Auto confirmation: (--yes|--y)
Always commit (todo rethink this option): (--ac)
Print only (do not exec): (--echo)
Override mode (autosave to config): --mode=hotfix OR --m=hotfix
Override project_name (autosave to config): --project_name=customName OR --p=customName
Skip adding changes from working tree to staging area: --dry

```

# Examples

Imagine that your task number is "123". You've just started to work on "123"

### Create new branch 'hotfix/123' from master:

```
hf 123
```
hf will detect that branch is missing on local or remote and create a new one.

### Let's make some coding and try to save our progress

```
hf save "fix typo, rm comments, add a joke into a code"
```
hf will commit ALL your changes (using commit-message's template defined in .hf.yml config) and push to remote. Yey!

### Now let's imagine your mate want to check your progress.

```
hf 123
```
Wow it's same command as on the first step but now hf detects that branch exists and pull it from remote!

### Merge 'hotfix/123' into master, push master to remote:

```
hf save master
```
Small project? No PRs? Still let's separate tasks with different branches!

### Commit with comment 'foo', push to remote, merge 'hotfix/123' into master & develop, push master & develop to remote:

```
hf save master develop "foo"
```

### Same as "save" + running deploy scripts from .hf.yml
You can change deploy commands with `hf config` or in .hf.yml
```
hf deploy master develop "foo"
```

# More examples

### Open closest .hf.yml config file. Create a new one if missing
```
hf config
```
See config specs below.

### Merge source branch into current branch
```
hf sync
```
Note: config source branch with `hf config` or in .hf.yml

### Update current branch with remote version
```
hf get
```

### Browse git status
```
hf st
```

### RESET HARD changes
```
hf reset
```

### run custom command from config
```
hf r test
```
Where "r" is a shortcut for "run" and "test" is script name (see config example to get a clue).

### init repo
```
hf init git@github.com:r1dd1ck777/blockchain_academy_management_dapp.git
```
This command will:
- init repo
- create .gitignore
- create first commit
- create develop branch
- push all to remote

### Remove all merged (into source branch) hotfix branches (local & remote):
```
hf delete-merged
```
Note: not tested in v2.0.0+

# Example config file:
```
deploy:
  master: 'echo ''I will speak on: hf deploy master'' '
  develop: 'echo ''I will speak on: hf deploy develop'' '
before_deploy_commit: 'echo ''Before committing with deploy'' '
locale: en
skip_colorize: false

source_branch: master
mode: hotfix
task_branch_name_tpl: "{mode}/{task_name}"

project_name: HF
commit_massage_tpl: "[{project_name}] #{task_name}: {commit_message} (hf is awesome!)"

run:
  test: 'echo "run test"'
```

### config template variables
- task_name - hf takes it from current branch name. For branch "feature/123" task_name is "123" 
- commit_message - arg variable from cli. For command `hf save "fix typo"` commit_message is "fix typo"
- the rest are self-explainable (I hope ;))

# TODO
- remove single hotfix from local & remote
- cli autocomplete

# Run tests
`tests/run.rb`
