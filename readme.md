# Why hf? 

`hf`'s goal is to reduce amount of work on simple projects. 
Similar to (and inspired by) git-flow: https://danielkummer.github.io/git-flow-cheatsheet/index.ru_RU.html

# Install

```
git clone https://github.com/r1dd1ck777/git-hotfix.git && cd git-hotfix && chmod +x hf && sudo ln -s $PWD/hf /usr/bin/hf
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
hf set-mode [feature|hotfix]


Options: 

No push: (--local|--l) prevents pushes to remote
Silent: (--quiet|--q) Skips some messages
Auto confirmation: (--yes|--y)
Always commit (todo rethink this option): (--ac)

```

# Examples

Try it - hf will always print a list of commands and ask your confirmation

### Create new branch 'hotfix/123' from master:

```
hf 123
```
From ANY branch. It will exec "git checkout master && git checkout -b hotfix/123"

### Goto 'hotfix/123' if it exists:

```
hf 123
```
From ANY branch. It will exec "git checkout hotfix/123"

### Commit with comment 'foo' and push to remote:

```
hf save "foo"
```
It will save CURRENT hotfix branch with "git add -A && git commit -a -m '#123 foo' && git push origin hotfix/123"
Running any "save" command you will see WHAT you actually exec.
Try it! You can prevent execution with Ctrl+C

### Merge 'hotfix/123' into master, push master to remote:

```
hf save master
```

### Commit with comment 'foo', push to remote, merge 'hotfix/123' into master & develop, push master & develop to remote:

```
hf save master develop "foo"
```

### Same as "save" + running deploy scripts from .hf.yml
You can change deploy commands with `hf config` or in .hf.yml
```
hf deploy master develop "foo"
```

### Config deployment & mode

### Merge main branch into current branch
You can change main branch with `hf config` or in .hf.yml

```
hf sync
```

### Remove all merged (into main branch) hotfix branches (local & remote):
You can change main branch with `hf config` or in .hf.yml
```
hf delete-merged
```

### Update current branch with remote version
```
hf get
```

### Browse git status

```
hf st
```

### Change mode
This will update config (.hf.yml), commit changes and push current branch
```
hf set-mode feature
hf set-mode hotfix
```

### init repo
This command will:
- init repo
- create .gitignore
- create first commit
- create develop branch
- push all to remote
```
hf init git@github.com:r1dd1ck777/blockchain_academy_management_dapp.git
```

# TODO

- remove single hotfix from local & remote
- cli autocomplete

# Run tests

`tests/run.rb`
