# Install

git clone https://github.com/r1dd1ck777/git-hotfix.git && cd git-hotfix && chmod +x hf && sudo ln -s $PWD/hf /usr/bin/hf

# Use

```
hf BRANCH_NAME
hf save [branches]+ ["comment"]
hf sync
```

# Examples

###Create new branch 'hotfix/123' from master:

```
hf 123
```

###Goto 'hotfix/123' if it exists:

```
hf 123
```

###Commit with comment 'foo' and push to remote:

```
hf save "foo"
```

###Merge 'hotfix/123' into master, push master to remote:

```
hf save master
```

###Commit with comment 'foo', push to remote, merge 'hotfix/123' into master & develop, push master & develop to remote:

```
hf save master develop "foo"
```

###Merge master into 'hotfix/123'

```
hf sync master
```

