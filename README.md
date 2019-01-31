# Bash test

A Repo for testing snippets of Bash code

#### Table of contents

1. [Getopts example](#getopts-example)
2. [test.sh](#testsh)

## Getopts example

Usage:

~~~ text
▶ bash test.sh -a -b baz qux quux quuz
You passed baz to -b, -a is true, and then passed qux quux quuz after that
~~~

## test.sh

This is a test script.

## Test

1. It copies the .bash_profile:
```text
cp /PATH-TO-YOUR-PROFILE/.bash_profile /BACKUP-DESTINATION/macOS-.bash_profile-backup
```
2. Then we enter your backup destination:
```text
cd /BACKUP-DESTINATION/macOS-.bash_profile-backup
```
3. Add all files into the GitHub repository:
```text
git add .
```
4. We commit all files with comment from script execution time:
```text
date +'%Y-%m-%d %H:%M:%S'
git commit -a -m "generated files on date +'%Y-%m-%d %H:%M:%S'"
```
5. And at the very end we push to GitHub:
```text
git push origin master
```
