# Install

git clone https://github.com/r1dd1ck777/git-hotfix.git && cd git-hotfix && chmod +x hf && sudo ln -s $PWD/hf /usr/bin/hf

# Update

```
hf self-update
```
or
sudo rm /usr/bin/hf && git clone https://github.com/r1dd1ck777/git-hotfix.git && cd git-hotfix && chmod +x hf && sudo ln -s $PWD/hf /usr/bin/hf

# Usage hints

```
hf TASK_NUMBER
hf save [branches]+ ["comment"]
hf deploy [branches]+ ["comment"]
hf delete-merged
hf sync
hf self-update
hf config
hf reset
hf get
```

# Examples

###Create new branch 'hotfix/123' from master:

```
hf 123
```
From ANY branch. It will exec "git checkout master && git checkout -b hotfix/123"

###Goto 'hotfix/123' if it exists:

```
hf 123
```
From ANY branch. It will exec "git checkout hotfix/123"

###Commit with comment 'foo' and push to remote:

```
hf save "foo"
```
It will save CURRENT hotfix branch with "git add . && git commit -a -m '#123 foo' && git push origin hotfix/123"
Running any "save" command you will see WHAT you actually exec.
Try it! You can prevent execution with Ctrl+C

###Merge 'hotfix/123' into master, push master to remote:

```
hf save master
```

###Commit with comment 'foo', push to remote, merge 'hotfix/123' into master & develop, push master & develop to remote:

```
hf save master develop "foo"
```

###Same as "save" + running deploy scripts from .hf.yml
You can change deploy commands with `hf config` or in .hf.yml
```
hf deploy master develop "foo"
```

###Config deployment & mode

###Merge main branch into current branch
You can change main branch with `hf config` or in .hf.yml

```
hf sync
```

###Remove all merged (into main branch) hotfix branches (local & remote):
You can change main branch with `hf config` or in .hf.yml
```
hf delete-merged
```

###Update current branch with remote version
```
hf get
```

###Browse git status

```
hf st
```

# TODO

- remove single hotfix from local & remote
- cli autocomplete