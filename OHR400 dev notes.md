# Development notes

## Developing with docker (recommended)

- Install docker desktop
- If on Windows:
  - `docker run -ti ubuntu:latest bash # to develop in a Unix environment`
- `git clone https://github.com/foorenxiang/ohr400docker`
- `cd ohr400docker && git checkout cpu-dev # this will build a docker image that mounts the OHR400Dashboard git repository as a volume`
- `cd .. && git clone http://github.com/foorenxiang/OHR400Dashboard`
- Alternatively:
  - `cd ohr400docker && git checkout cpu # the local OHR400Dashboard repository will be hosted within the docker container`
- `git checkout -b newfeaturebranch # (only if working on subfeature)`
- `./buildAndRunCPU.sh # alternatively buildAndRunGPU.sh if working on GPU enabled docker image`

## Running existing container

- `./run.sh`

## Merging changes back into production cpu and gpu

### Method A (recommended: Using pull request)

- `git checkout cpu`
- `git pull`
- `git checkout -b cpu-PR-NEWPRNUM`
- `git checkout cpu-dev # or the sub feature branch`
- `git rebase cpu-dev`
- `git rebase DEVSPECFICCOMMITS~ # pop dev specific commits from history`
- `# PR cpu-PR-NEWPRNUM to cpu and finish PR merge`
- `git checkout gpu`
- `git rebase cpu`
- `git checkout yourfeaturebranch # to continue working`
- `#OPTIONAL`
  - `# SAVE ALL COMMITS SPECIFIC TO DEV BRANCH FIRST!`
  - `# REBUILD CPU-DEV BRANCH FROM REBASED CPU BRANCH`
  - `git checkout cpu`
  - `git branch -D cpu-dev`
  - `git checkout -b cpu-dev`


### Method B (cherry-picking)

- `git log cpu..cpu-dev # or your feature branch # this will show the list of commits to be added`
- `git checkout cpu`

#### Perform git cherry-pick commits to be added to cpu branch (master):

- Option A: Single commit cherry-pick
  - `git cherry-pick _a_commit_`
- Option B: Block cherry-pick
  - `git cherry-pick first_commit..last_commit # for consecutive block of commits`

### Popping last few commits

- `git rebase -i HEAD~numOfCommitsToPop`

### Popping single commit from history (non-linear)

- `git rebase -i particularCommit~`
