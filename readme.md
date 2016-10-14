# Install

git clone https://github.com/r1dd1ck777/git-hotfix.git && cd git-hotfix && chmod +x hf && sudo ln -s $PWD/hf /usr/bin/hf

# Update

```
hf self-update
```
or
sudo rm /usr/bin/hf && git clone https://github.com/r1dd1ck777/git-hotfix.git && cd git-hotfix && chmod +x hf && sudo ln -s $PWD/hf /usr/bin/hf

# Ads

Use https://gist.github.com/Kris-Simpson/ab274db3ca7f5160d5ad4bbba3517547 to show branch in cli directory! It's great!)

# Use

```
hf TASK_NUMBER
hf save [branches]+ ["comment"]
hf deploy [branches]+ ["comment"]
hf delete-merged
hf sync
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

###Same as "save" but with running deploy scripts from .hf.yml

```
hf deploy master develop "foo"
```

#### .hf.yml example
deploy:
  master: "cap production deploy"
  develop: "cap staging deploy"


###Merge master into 'hotfix/123'

```
hf sync master
```

###Remove all merged (into master) hotfix branches (local & remote):

```
hf delete-merged
```

# TODO

- remove single hotfix
- remove old & merged hotfixes