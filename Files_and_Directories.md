# <a name="files-and-directories"></a>Files and Directories

**Table of Contents**

* [pwd](#pwd)
* [cd](#cd)
* [clear](#clear)
* [ls](#ls)
* [mkdir](#mkdir)
* [touch](#touch)
* [rm](#rm)
* [cp](#cp)
* [mv](#mv)
* [rename](#rename)
* [ln](#ln)
* [tar and gzip](#tar-and-gzip)

<br>

Let's look at commonly used commands to navigate directories, create and modify files and directories. For certain commands, a list of commonly used options are also given

Make it a habit to use `man` command to read about a new command - for example `man ls`

Short descriptions for commands are shown as quoted text (taken from `whatis` or `help -d`)

<br>

## <a name="pwd"></a>pwd

>print name of current/working directory

* apart from knowing your current working directory, often used to copy the absolute path to be pasted elsewhere, like in a script
* some Terminal emulators display the current directory path as window/tab title

```bash
$ pwd
/home/learnbyexample
```

<br>

## <a name="cd"></a>cd

>Change the shell working directory

* Like `pwd`, the `cd` command is a shell builtin
* Let's see an example of changing working directory to some other directory and coming back
* Specifying `/` at end of path argument is optional

```bash
$ pwd
/home/learnbyexample

$ # providing an absolute path as argument
$ cd /etc
$ pwd
/etc

$ # to go back to previous working directory
$ # if there's a directory named '-', use './-' to go that directory
$ cd -
/home/learnbyexample
$ pwd
/home/learnbyexample
```

* Relative paths are well, relative to current working directory
* `.` refers to current directory
* `..` refers to directory one hierarchy above
* `../..` refers to directory two hierarchies above and so on

```bash
$ pwd
/home/learnbyexample

$ # go to directory one hierarchy above
$ cd ..
$ pwd
/home

$ # go to directory 'learnbyexample' present in current directory
$ # './' is optional in this case
$ cd ./learnbyexample
$ pwd
/home/learnbyexample

$ # go to directory two hierarchies above
$ cd ../..
$ pwd
/
```

* `cd ~/` or `cd ~` or `cd` will go to directory specified by `HOME` shell variable (which is usually set to user's home directory)

```bash
$ pwd
/
$ echo "$HOME"
/home/learnbyexample

$ cd
$ pwd
/home/learnbyexample
```

**Further Reading**

* Use `help cd` for documentation
* [cd Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/cd-command?sort=votes&pageSize=15)
* [cd Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/cd?sort=votes&pageSize=15)
* [bash manual: Tilde Expansion](https://www.gnu.org/software/bash/manual/html_node/Tilde-Expansion.html)

<br>

## <a name="clear"></a>clear

>clear the terminal screen

You can also use `Ctrl+l` short-cut to clear the Terminal screen (in addition, this retains any typed text)

<br>

## <a name="ls"></a>ls

>list directory contents

* by default, `ls` output is sorted alphabetically

```bash
$ # if no argument is given, current directory contents are displayed
$ ls
backups  hello_world.py  palindrome.py  projects    todo
ch.sh    ip.txt          power.log      report.log  workshop_brochures

$ # absolute/relative paths can be given as arguments
$ ls /var/
backups  crash  local  log   metrics  run   spool
cache    lib    lock   mail  opt      snap  tmp
$ # for multiple arguments, listing is organized by directory
$ ls workshop_brochures/ backups/
backups:
chrome_bookmarks_02_07_2018.html  dot_files

workshop_brochures:
Python_workshop_2017.pdf  Scripting_course_2016.pdf

$ # single column listing
$ ls -1 backups/
chrome_bookmarks_02_07_2018.html
dot_files
```

* `-F` appends a character to each file name indicating the file type (other than regular files)
    * `/` for directories
    * `*` for executable files
    * `@` for symbolic links
    * `|` for FIFOs
    * `=` for sockets
    * `>` for doors
    * the indicator details are described in `info ls`, not in `man ls`

```bash
$ ls -F
backups/  hello_world.py*  palindrome.py*  projects@   todo
ch.sh*    ip.txt           power.log       report.log  workshop_brochures/

$ # if you just need to distinguish file and directory, use -p
$ ls -p
backups/  hello_world.py  palindrome.py  projects    todo
ch.sh     ip.txt          power.log      report.log  workshop_brochures/
```

* or use the color option

![ls color output](./images/ls_color.png)

* long listing format
* shows details like file permissions, ownership, size, timestamp, etc
    * See [chmod](./Working_with_Files_and_Directories.md#chmod) section for details on permissions, groups, etc
* file types are distinguished as `d` for directories, `-` for regular files, `l` for symbolic links, etc

```bash
$ ls -l
total 84
drwxrwxr-x 3 learnbyexample eg  4096 Jul  4 18:23 backups
-rwxr-xr-x 1 learnbyexample eg  2746 Mar 30 11:38 ch.sh
-rwxrwxr-x 1 learnbyexample eg    41 Aug 21  2017 hello_world.py
-rw-rw-r-- 1 learnbyexample eg    34 Jul  4 09:01 ip.txt
-rwxrwxr-x 1 learnbyexample eg  1236 Aug 21  2017 palindrome.py
-rw-r--r-- 1 learnbyexample eg 10449 Mar  8  2017 power.log
lrwxrwxrwx 1 learnbyexample eg    12 Jun 21 12:08 projects -> ../projects/
-rw-rw-r-- 1 learnbyexample eg 39120 Feb 25  2017 report.log
-rw-rw-r-- 1 learnbyexample eg  5987 Apr 11 11:06 todo
drwxrwxr-x 2 learnbyexample eg  4096 Jul  5 12:05 workshop_brochures

$ # to show size in human readable format instead of byte count
$ ls -lh power.log
-rw-r--r-- 1 learnbyexample eg 11K Mar  8  2017 power.log

$ # use -s option instead of -l if only size info is needed
$ ls -1sh power.log report.log
12K power.log
40K report.log
```

* changing sorting criteria
* use `-t` to sort by timestamp, often combined with `-r` to reverse the order so that most recently modified file shows as last item
* `-S` option sorts by file size (not suitable for directories)
* `-v` option does version sorting (suitable for filenames with numbers in them)
* `-X` option allows to sort by file extension (i.e characters after the last `.` in filename)

```bash
$ ls -lhtr
total 84K
-rw-rw-r-- 1 learnbyexample eg  39K Feb 25  2017 report.log
-rw-r--r-- 1 learnbyexample eg  11K Mar  8  2017 power.log
-rwxrwxr-x 1 learnbyexample eg 1.3K Aug 21  2017 palindrome.py
-rwxrwxr-x 1 learnbyexample eg   41 Aug 21  2017 hello_world.py
-rwxr-xr-x 1 learnbyexample eg 2.7K Mar 30 11:38 ch.sh
-rw-rw-r-- 1 learnbyexample eg 5.9K Apr 11 11:06 todo
lrwxrwxrwx 1 learnbyexample eg   12 Jun 21 12:08 projects -> ../projects/
-rw-rw-r-- 1 learnbyexample eg   34 Jul  4 09:01 ip.txt
drwxrwxr-x 3 learnbyexample eg 4.0K Jul  4 18:23 backups
drwxrwxr-x 2 learnbyexample eg 4.0K Jul  5 12:05 workshop_brochures

$ ls -X
backups   todo                power.log   hello_world.py  ch.sh
projects  workshop_brochures  report.log  palindrome.py   ip.txt
```

* filenames starting with `.` are considered as hidden files

```bash
$ # -a option will show hidden files too
$ ls -a backups/dot_files/
.  ..  .bashrc  .inputrc  .vimrc

$ # . and .. are special directories pointing to current and parent directory
$ # if you recall, we have used them in specifying relative paths
$ # so, 'ls', 'ls .' and 'ls backups/..' will give same result
$ ls -aF backups/dot_files/
./  ../  .bashrc  .inputrc  .vimrc

$ # use -A option to show hidden files excluding . and .. special directories
$ ls -A backups/dot_files/
.bashrc  .inputrc  .vimrc
```

* use `-R` option to recursively list sub-directories too

```bash
$ ls -ARF
.:
backups/  hello_world.py*  palindrome.py*  projects@   todo
ch.sh*    ip.txt           power.log       report.log  workshop_brochures/

./backups:
chrome_bookmarks_02_07_2018.html  dot_files/

./backups/dot_files:
.bashrc  .inputrc  .vimrc

./workshop_brochures:
Python_workshop_2017.pdf  Scripting_course_2016.pdf
```

* `tree` command displays contents of a directory recursively as a tree like structure
* you might have to install this command or have an equivalent command like `gvfs-tree`

```bash
$ # -h option will show hidden files
$ gvfs-tree -h
file:///home/learnbyexample/ls_ex
|-- backups
|   |-- chrome_bookmarks_02_07_2018.html
|   `-- dot_files
|       |-- .bashrc
|       |-- .inputrc
|       `-- .vimrc
|-- ch.sh
|-- hello_world.py
|-- ip.txt
|-- palindrome.py
|-- power.log
|-- projects -> ../projects/
|-- report.log
|-- todo
`-- workshop_brochures
    |-- Python_workshop_2017.pdf
    `-- Scripting_course_2016.pdf
```

* often, we want to prune which files/directories are to be listed
* commands like `find` provide extensive features in this regard
* the shell itself provides a matching technique called glob/wildcards
    * see [Shell wildcards](./Shell.md#wildcards) section for more examples and details
* beginners incorrectly associate globbing with `ls` command, so globbing results are shown below using `echo` command as a demonstration

```bash
$ # all unquoted arguments are subjected to shell globbing interpretation
$ echo *.py *.log
hello_world.py palindrome.py power.log report.log
$ echo '*.py' *.log
*.py power.log report.log

$ # long list only files ending with .py
$ ls -l *.py
-rwxrwxr-x 1 learnbyexample eg   41 Aug 21  2017 hello_world.py
-rwxrwxr-x 1 learnbyexample eg 1236 Aug 21  2017 palindrome.py

$ # match all filenames starting with alphabets c/d/e/f/g/h/i
$ echo [c-i]*
ch.sh hello_world.py ip.txt
$ ls -sh [c-i]*
4.0K ch.sh  4.0K hello_world.py  4.0K ip.txt
```

* use `-d` option to not show directory contents

```bash
$ echo b*
backups
$ # since backups is a directory, ls will list its contents
$ ls b*
chrome_bookmarks_02_07_2018.html  dot_files
$ # -d option will show the directory entry instead of its contents
$ ls -d b*
backups

$ # a simple way to get only the directory entries
$ # assuming simple filenames without spaces/newlines/etc
$ echo */
backups/ projects/ workshop_brochures/
$ ls -d */
backups/  projects/  workshop_brochures/
```

**Further Reading**

* `man ls` and `info ls` for more options and complete documentation
* [ls Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/ls?sort=votes&pageSize=15)
* [ls Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/ls?sort=votes&pageSize=15)
* [mywiki.wooledge: avoid parsing output of ls](https://mywiki.wooledge.org/ParsingLs)
* [unix.stackexchange: why not parse ls?](https://unix.stackexchange.com/questions/128985/why-not-parse-ls)
* [unix.stackexchange: What are ./ and ../ directories?](https://unix.stackexchange.com/questions/63081/what-are-and-directories)

<br>

## <a name="mkdir"></a>mkdir

>make directories

* Linux filenames can use any character other than `/` and the ASCII NUL character
* quote the arguments if name contains characters like space, `*`, etc to prevent shell interpretation
    * shell considers space as argument separator, `*` is a globbing character, etc
* unless otherwise needed, try to use only alphabets, numbers and underscores for filenames

```bash
$ # one or more absolute/relative paths can be given to create directories
$ mkdir reports 'low power adders'

$ # listing can be confusing when filename contains characters like space
$ ls
low power adders  reports
$ ls -1
low power adders
reports
```

* use `-p` option to create multiple directory hierarchies in one go
* it is also useful in scripts to create a directory without having to check if it already exists
* special variable `$?` gives exit status of last executed command
    * `0` indicates success and other values indicate some kind of failure
    * see documentation of respective commands for details

```bash
$ mkdir reports
mkdir: cannot create directory ‘reports’: File exists
$ echo $?
1
$ # when -p is used, mkdir won't give an error if directory already exists
$ mkdir -p reports
$ echo $?
0

$ # error because 'a/b' doesn't exist
$ mkdir a/b/c
mkdir: cannot create directory ‘a/b/c’: No such file or directory
$ # with -p, any non-existing directory will be created as well
$ mkdir -p a/b/c
$ ls -1R a
a:
b

a/b:
c

a/b/c:
```

**Further Reading**

* [mkdir Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/mkdir?sort=votes&pageSize=15)
* [mkdir Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/mkdir?sort=votes&pageSize=15)
* [unix.stackexchange: Characters best avoided in filenames](https://unix.stackexchange.com/questions/269093/characters-best-avoided-in-filenames-when-used-in-bash-e-g)

<br>

## <a name="touch"></a>touch

* Usually files are created using a text editor or by redirecting output of a command to a file
* But sometimes, for example to test file renaming, creating empty files comes in handy
* the `touch` command is primarily used to change timestamp of a file (see [touch](./Working_with_Files_and_Directories.md#touch) section of next chapter)
* if a filename given to `touch` doesn't exist, an empty file gets created with current timestamp

```bash
$ touch ip.txt
$ ls -1F
a/
ip.txt
low power adders/
reports/
```

<br>

## <a name="rm"></a>rm

>remove files and directories

* to delete files, specify them as separate arguments
* to delete directories as well, use `-r` option (deletes recursively)
* use `-f` option to force remove without prompt for non-existing files and write protected files (provided user has appropriate permissions)

```bash
$ ls
a  ip.txt  low power adders  reports
$ rm ip.txt
$ ls
a  low power adders  reports

$ rm reports
rm: cannot remove 'reports': Is a directory
$ rm -r reports
$ ls
a  low power adders

$ # to remove only empty directory, same as 'rmdir' command
$ rm -d a
rm: cannot remove 'a': Directory not empty
```

* typos like misplaced space, wrong glob, etc could wipe out files not intended for deletion
* apart from having backups and snapshots, one could take some mitigating steps
    * using `-i` option to interactively delete each file
    * using `echo` as a dry run to see how the glob expands
    * using a trash command (see links below) instead of `rm`

```bash
$ rm -ri 'low power adders'
rm: remove directory 'low power adders'? n
$ ls
a  low power adders

$ rm -ri a
rm: descend into directory 'a'? y
rm: descend into directory 'a/b'? y
rm: remove directory 'a/b/c'? y
rm: remove directory 'a/b'? y
rm: remove directory 'a'? y
$ ls
low power adders
```

**Further Reading**

* See if a trash command is available for your distro (for ex: `gvfs-trash` on Ubuntu) - this will send items to trash instead of deletion
    * or, [unix.stackexchange: creating a simple trash command](https://unix.stackexchange.com/questions/452496/create-a-recycle-bin-feature-without-using-functions)
* Files removed using `rm` can still be recovered with time/skill. Use `shred` command to overwrite files
    * [unix.stackexchange: recover deleted files](https://unix.stackexchange.com/questions/80270/unix-linux-undelete-recover-deleted-files)
    * [unix.stackexchange: recovering accidentally deleted files](https://unix.stackexchange.com/questions/2677/recovering-accidentally-deleted-files)
    * [wiki.archlinux: Securely wipe disk](https://wiki.archlinux.org/index.php/Securely_wipe_disk)
* [rm Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/rm?sort=votes&pageSize=15)
* [rm Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/rm?sort=votes&pageSize=15)

<br>

## <a name="cp"></a>cp

>copy files and directories

* to copy a single file or directory, specify the source as first argument and destination as second argument
* similar to `rm` command, use `-r` for directories

```bash
$ # when destination is a directory, specified sources are placed inside that directory
$ # recall that . is a relative path referring to current directory
$ cp /usr/share/dict/words .
$ ls
low power adders  words

$ cp /usr/share/dict .
cp: omitting directory '/usr/share/dict'
$ cp -r /usr/share/dict .
$ ls -1F
dict/
low power adders/
words
```

* often, we want to copy for the purpose of modifying it
* in such cases, a different name can be given while specifying the destination
* if the destination filename already exists, it will be overwritten (see options `-i` and `-n` to avoid this)

```bash
$ cp /usr/share/dict/words words_ref.txt
$ cp -r /usr/share/dict word_lists

$ ls -1F
dict/
low power adders/
word_lists/
words
words_ref.txt
```

* multiple files and directories can be copied at once if the destination is a directory
* using `-t` option, one could specify destination directory first followed by sources (this is helpful with `find` command and other places)

```bash
$ mkdir bkp_dot_files

$ # here, ~ will get expanded to user's home directory
$ cp ~/.bashrc ~/.bash_profile bkp_dot_files/
$ ls -A bkp_dot_files
.bash_profile  .bashrc
```

* see `man cp` and `info cp` for more options and complete documentation
* some notable options are
    * `-u` copy files from source only if they are newer than those in destination or if it doesn't exist in destination location
    * `-b` and `--backup` for back up options if file with same name already exists in destination location
    * `--preserve` option to copy files along with source file attributes like timestamp

**Further Reading**

* [cp Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/cp?sort=votes&pageSize=15)
* [cp Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/cp?sort=votes&pageSize=15)
* `rsync` a fast, versatile, remote (and local) file-copying tool
    * [rsync examples](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps)
    * [rsync Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/rsync?sort=votes&pageSize=15)
    * [rsync Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/rsync?sort=votes&pageSize=15)

<br>

## <a name="mv"></a>mv

>move (rename) files

* as name suggests, `mv` can move files from one location to another
* if multiple files need to be moved, destination argument should be a directory (or specified using `-t` option)
* unlike `rm` and `cp`, both files and directories have same syntax, no additional option required
* use `-i` option to be prompted instead of overwriting file of same name in destination location

```bash
$ ls
bkp_dot_files  dict  low power adders  word_lists  words  words_ref.txt
$ mkdir backups

$ mv bkp_dot_files/ backups/
$ ls -F
backups/  dict/  low power adders/  word_lists/  words  words_ref.txt
$ ls -F backups/
bkp_dot_files/

$ mv dict words backups/
$ ls -F
backups/  low power adders/  word_lists/  words_ref.txt
$ ls -F backups/
bkp_dot_files/  dict/  words
```

* like `cp` command, for single file/directory one can provide a different destination name
* so, when source and destination has same parent directory, `mv` acts as renaming command

```bash
$ mv backups/bkp_dot_files backups/dot_files
$ ls -F backups/
dict/  dot_files/  words
```

**Further Reading**

* [mv Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/mv?sort=votes&pageSize=15)
* [mv Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/mv?sort=votes&pageSize=15)

<br>

## <a name="rename"></a>rename

>renames multiple files

Note: The `perl` based `rename` is presented here which is different from [util-linux-ng version](https://linux.die.net/man/1/rename). Check `man rename` for details

```bash
$ ls
backups  low power adders  word_lists  words_ref.txt
$ # here, the * glob will expand to all non-hidden files in current directory
$ # -n option is for dry run, to see changes before actually renaming files
$ # s/ /_/g means replace all space characters with _ character
$ rename -n 's/ /_/g' *
rename(low power adders, low_power_adders)

$ rename 's/ /_/g' *
$ ls
backups  low_power_adders  word_lists  words_ref.txt
```

**Further Reading**

* [rename Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/rename?sort=votes&pageSize=15)
* See [Perl one liners](https://github.com/learnbyexample/Command-line-text-processing/blob/master/perl_the_swiss_knife.md) for examples and details on Perl substitution command
* Some more `rename` examples - [unix.stackexchange: replace dots except last one](https://unix.stackexchange.com/questions/315586/replacing-dots-in-file-name-with-underscores-except-the-extension/315589#315589) and [stackoverflow: change date format](https://stackoverflow.com/questions/40286513/converting-date-format-in-bash/40288150#40288150)

<br>

## <a name="ln"></a>ln

>make links between files

* there are two types of links - symbolic and hard links
* symbolic links is like a pointer/shortcut to another file or directory
    * if the original file is deleted or moved to another location, symbolic link will no longer work
    * if the symbolic link is moved to another location, it will still work if the link was done using absolute path (for relative path, it will depend on whether or not there's another file with same name in that location)
    * a symbolic link file has its own inode, permissions, timestamps, etc
    * most commands will work the same when original file or the symbolic file is given as command line argument, see their documentation for details

```bash
$ # similar to cp, a different name can be specified if needed
$ ln -s /usr/share/dict/words .
$ ls -F
words@

$ # to know which file the link points to
$ ls -l words
lrwxrwxrwx 1 learnbyexample eg 21 Jul  9 13:41 words -> /usr/share/dict/words
$ readlink words
/usr/share/dict/words
$ # the linked file may be another link
$ # use -f option to get original file
$ readlink -f words
/usr/share/dict/english
```

* hard link can only point to another file (not a directory, and restricted to within the same filesystem)
    * the `.` and `..` special directories are the exceptions, they are hard links which are automatically created
* once a hard link is created, there is no distinction between the two files other than different filename/location - they have same inode, permissions, timestamps, etc
* any of the hard link will continue working even if all the other hard links are deleted
* if a hard link is moved to another location, the links will still be in sync - any change in one of them will be reflected in all the other links

```bash
$ touch foo.txt
$ ln foo.txt baz.txt

$ # the -i option gives inode
$ ls -1i foo.txt baz.txt
649140 baz.txt
649140 foo.txt
```

**Further Reading**

* `unlink` command to delete links (`rm` can be used as well)
* [ln Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/ln?sort=votes&pageSize=15)
* [ln Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/ln?sort=votes&pageSize=15)
* [askubuntu: What is the difference between a hard link and a symbolic link?](https://askubuntu.com/questions/108771/what-is-the-difference-between-a-hard-link-and-a-symbolic-link)
* [unix.stackexchange: What is the difference between symbolic and hard links?](https://unix.stackexchange.com/questions/9575/what-is-the-difference-between-symbolic-and-hard-links)
* [unix.stackexchange: What is a Superblock, Inode, Dentry and a File?](https://unix.stackexchange.com/questions/4402/what-is-a-superblock-inode-dentry-and-a-file)

<br>

## <a name="tar-and-gzip"></a>tar and gzip

* `tar` is an archiving utility
* first, lets see an example of creating single archive file from multiple input files
* note that the archive file so created is a new file and doesn't overwrite input files

```bash
$ ls -F
backups/  low_power_adders/  word_lists/  words_ref.txt

$ # -c option creates a new archive, existing archive will be overwritten
$ # -f option allows to specify name of archive to be created
$ # rest of the arguments are the files to be archived
$ tar -cf bkp_words.tar word_lists words_ref.txt

$ ls -F
backups/  bkp_words.tar  low_power_adders/  word_lists/  words_ref.txt
$ ls -sh bkp_words.tar
2.3M bkp_words.tar
```

* once we have an archive, we can compress it using `gzip`
* this will replace the archive file with compressed version, adding a `.gz` suffix

```bash
$ gzip bkp_words.tar

$ ls -F
backups/  bkp_words.tar.gz  low_power_adders/  word_lists/  words_ref.txt
$ ls -sh bkp_words.tar.gz
652K bkp_words.tar.gz
```

* to uncompress, use `gunzip` or `gzip -d`
* this will replace the compressed version with the uncompressed archive file

```bash
$ gunzip bkp_words.tar.gz

$ ls -F
backups/  bkp_words.tar  low_power_adders/  word_lists/  words_ref.txt
$ ls -sh bkp_words.tar
2.3M bkp_words.tar
```

* to extract the original files from archive, use `-x` option

```bash
$ mkdir test_extract
$ mv bkp_words.tar test_extract/
$ cd test_extract/
$ ls
bkp_words.tar

$ tar -xf bkp_words.tar
$ ls -F
bkp_words.tar  word_lists/  words_ref.txt
$ cd ..
$ rm -r test_extract/
```

* the GNU version of `tar` supports compressing/uncompressing options as well

```bash
$ ls -F
backups/  low_power_adders/  word_lists/  words_ref.txt

$ # -z option gives same compression as gzip command
$ # reverse would be: tar -zxf bkp_words.tar.gz
$ tar -zcf bkp_words.tar.gz word_lists words_ref.txt
$ ls -sh bkp_words.tar.gz
652K bkp_words.tar.gz
```

* there are loads of options for various needs, see documentation for details
    * `-v` for verbose option
    * `-r` to append files to archive
    * `-t` to list contents of archive
    * `--exclude=` to specify files to be ignored from archiving
    * `-j` and `-J` to use `bzip2` or `xz` compression technique instead of `-z` which uses `gzip`
* there are commands starting with `z` to work with compressed files
    * `zcat` to display file contents of compressed file on standard output
    * `zless` to display file contents of compressed file one screenful at a time
    * `zgrep` to search compressed files and so on...

**Further Reading**

* [tar Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/tar?sort=votes&pageSize=15)
* [tar Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/tar?sort=votes&pageSize=15)
* [superuser: gzip without tar? Why are they used together?](https://superuser.com/questions/252065/gzip-without-tar-why-are-they-used-together)
* `zip` and `unzip` commands

