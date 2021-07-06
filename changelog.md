## 1.1.9

- add "--always-commit", "--ac" option. This will skip checking of code changing.

## 1.1.8

- add hook "before_deploy_commit" to .hf.yml
- fix self-update if we on in master (contributing to hotfix)

## 1.1.7

- Add git locale

### 1.1.6

- fix git status checking

#--------------------------

### 1.0.2

```
hf save develop
```
now return you back to your hotfix branch


### 1.0.3

```
hf save develop --no-push
```
Skip push to remote


### 1.0.4

Autopull target branch (master or develop etc.) on merge

### 1.0.5

Deploy feature

### 1.0.6

- Autopull hotfix/xxx branch on checkout
- delete-merged - will clean up local & remote merged into master hotfix/* branches

### 1.0.7

- Switch branches during deploy
- Autopull hotfix/xxx branch on save & deploy

### 1.0.8

- Add `hf config` command
- Validate comment

### 1.1.0

- Add feature mode.

### 1.1.2

- Add config nested search

### 1.1.3

- Add `hf reset` command to remove all changes

### 1.1.4

- Add `hf get` command to get current branch from remote

### 1.1.5

- Add `hf st` command to get git status

### 1.2.2

- Add `hf set-mode hotfix` action
- Add `--yes|--y` option - auto confirmation
- Add `--quiet|--q` option - skip some messages
- Change config `colorize: false` to `skip_colorize: true`

### 1.2.3

- Add `--echo` option - only render commands instead of executing. Can be used for testing

### 1.2.4

- Add `hf init [ORIGIN_URL]` action - init repo & .gitignore

# 2.0.1

- changed config (FULLY NEW config logic)
- few commands were deleted
- commit message templates
- branch name templates
- source branch config

Config (.hf.yml) example:

```
deploy:
  master: 'echo ''I will speak on: hf deploy master'' '
  develop: 'echo ''I will speak on: hf deploy develop'' '
before_deploy_commit: 'echo ''Before committing with deploy'' '
locale: en
skip_colorize: false

source_branch: master
mode: feature
task_branch_name_tpl: "{mode}/{task_name}"

project_name: HF
commit_massage_tpl: "[{project_name}] #{task_name}: {commit_message} (hf is awesome!)"

```

## 2.0.2

- added `hf r [SCRIPT_NAME]` command


## 2.0.12

- added ability to change default editor


## 2.0.14

- added `hf my` command, upd readme


## 2.0.16

- added support for mac, updated readme


## 2.0.18

- added pre save hook. hf.yml config: `before_save_commit: 'echo ''Before save'' '`
