# <a name="files-and-directories"></a>Files and Directories

* [pwd](#pwd)
* [clear](#clear)
* [ls](#ls)
* [cd](#cd)
* [mkdir](#mkdir)
* [touch](#touch)
* [rm](#rm)
* [cp](#cp)
* [mv](#mv)
* [rename](#rename)
* [ln](#ln)
* [tar and gzip](#tar-and-gzip)


Let's look at commonly used commands to move around directories, create and modify files and folders. For certain commands, a list of commonly used options are also given  
Make it a habit to use `man` command to read about a new command - for example `man ls`

Short descriptions shown for a command are taken from `whatis` or `help -d`

<br>
### <a name="pwd"></a>pwd

>print name of current/working directory

Apart from knowing your current working directory, often used to copy the absolute path to be pasted elsewhere, like in a script

<br>
### <a name="clear"></a>clear

>clear the terminal screen

* Use `Ctrl+l` to clear the terminal screen and retain already typed text (if any) on command prompt

<br>
### <a name="ls"></a>ls

>list directory contents

**Options**

* `-a` list hidden files also
* `-1` list in single column (number one, not lowercase of letter L)
* `-l` list contents with extra details about the files (lowercase of letter L, not number one)
* `-h` display file sizes in human readable format
* `-t` sort based on time
* `-r` reverse sorting order
* `-R` recursively display sub-directories
* `-S` sort by file size
    * directory is treated as file and doesn’t display actual size used by directory, use `du` command if directory size is also needed
* `-d` list directory entries instead of contents
* `-F` Append a character to each file name indicating the file type (other than regular files)
    * `/` for directories
    * `*` for executable files
    * `@` for symbolic links
    * `|` for FIFOs
    * `=` for sockets
    * `>` for doors
    * the indicator details are described in `info ls`, not in `man ls`
* `--color=auto` list contents with different color for directories, executables, etc

**Examples**

* `ls` list contents of current directory when argument is not given
* `ls /home` list contents of directory home present under the root directory (absolute path specified)
* `ls ../` list contents of directory one hierarchy above (relative path specified)
* `ls -ltr` list files of current directory with details sorted such that latest created/modified file is displayed last
* [ls Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/ls?sort=votes&pageSize=15)
* [ls Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/ls?sort=votes&pageSize=15)

<br>
### <a name="cd"></a>cd

>Change the shell working directory

```
$ whatis cd
cd: nothing appropriate.
$ type cd
cd is a shell builtin
$ help -d cd
cd - Change the shell working directory.
```

**Examples**

* `cd /etc` go to 'etc' directory under root folder (absolute path specified)
* `cd -` switch back to previous working directory
* `cd ~/` or `cd ~` or `cd` go to home directory
    * as specified by `HOME` environment variable
* `cd ..` go one hierarchy back (relative path specified)
* `cd ../..` two hierarchy back (relative path specified)
* [cd Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/cd-command?sort=votes&pageSize=15)
* [cd Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/cd?sort=votes&pageSize=15)

<br>
### <a name="mkdir"></a>mkdir

>make directories

**Examples**

* `mkdir project_adder` create folder project_adder in current directory
* `mkdir project_adder/report` create folder report in project_adder directory
* `mkdir -p project_adder/report` create both project_adder and report directories in one shot
    * if project_adder already exists, it won't be affected
* `mkdir /home/guest1` add a home directory for user guest1
* [mkdir Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/mkdir?sort=votes&pageSize=15)
* [mkdir Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/mkdir?sort=votes&pageSize=15)

<br>
### <a name="touch"></a>touch

>change file timestamps

When a filename is passed as argument to `touch` command that doesn't exist, it creates an empty file  
More info on this command is covered in a later chapter

* `touch error.log` creates an empty file error.log in current directory if it doesn't exist
* [touch Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/touch?sort=votes&pageSize=15)

<br>
### <a name="rm"></a>rm

>remove files and directories

**Options**

* `-r` remove recursively, used for removing directories
* `-f` force remove without prompt for non-existing files and write protected files (provided user has appropriate permissions)
* `-i` prompt before every removal
* `-d` remove empty directories

**Examples**

* `rm project_adder/power.log` remove file power.log from project_adder directory
* `rm -r project_adder` remove folder project_adder from current directory even if non-empty
* `rm -d project_tmp` remove project_tmp folder provided it is empty
    * `rmdir project_tmp` can also be used
* If available, use `gvfs-trash` command to send items to trash instead of permanent deletion
* Files removed using `rm` can still be recovered with time/skill. Use `shred` command to overwrite files
    * [recover deleted files](https://unix.stackexchange.com/questions/80270/unix-linux-undelete-recover-deleted-files)
    * [recovering accidentally deleted files](https://unix.stackexchange.com/questions/2677/recovering-accidentally-deleted-files)
    * [Securely wipe disk](https://wiki.archlinux.org/index.php/Securely_wipe_disk)
* [rm Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/rm?sort=votes&pageSize=15)
* [rm Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/rm?sort=votes&pageSize=15)

<br>
### <a name="cp"></a>cp

>copy files and directories

The destination path is always specified as the last argument. More than one source file/folder can be specified if destination is a directory

**Options**

* `-r` copy recursively, used for copying directories
* `-i` prompt before overwriting

**Examples**

* `cp /home/raja/Raja_resume.doc Ravi_resume.doc` create a copy of file Raja_resume.doc as Ravi_resume.doc in your current directory
* `cp /home/raja/Raja_resume.doc .` create a copy of file Raja_resume.doc in your current directory - name not changed in this case
    * `.` represents current directory and `..` represents one hierarchy above
* `cp -r /home/guest1/proj_matlab ~/proj_matlab_bug_test` copy proj_matlab to your home directory as proj_matlab_bug_test
* `cp report/output.log report/timing.log .` copy files output.log and timing.log to current directory
* [cp Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/cp?sort=votes&pageSize=15)
* [cp Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/cp?sort=votes&pageSize=15)

Also check out

* `rsync` a fast, versatile, remote (and local) file-copying tool
* [rsync examples](http://ubtutorials.com/tutorial/1136/ubuntu-15-examples-backup-using-rsync-command)
* [rsync Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/rsync?sort=votes&pageSize=15)
* [rsync Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/rsync?sort=votes&pageSize=15)

<br>
### <a name="mv"></a>mv

>move (rename) files

The destination path is always specified as the last argument. More than one source file/folder can be specified if destination is a directory

**Options**

* `-f` don't prompt for overwriting and moving write protected files (provided user has appropriate permissions)
* `-i` prompt before overwriting

**Examples**

* `mv project_adder project_lowpower_adder` rename file or folder
* `mv power.log timing.log area.log project_multiplier/result/` move the specified files to result directory
* [mv Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/mv?sort=votes&pageSize=15)
* [mv Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/mv?sort=votes&pageSize=15)

<br>
### <a name="rename"></a>rename

>renames multiple files

**Options**

* `-f` overwrite existing files
* `-n` show matching input files without actually renaming them

**Examples**

* `rename 's/\.JPG$/.jpg/' *JPG` change the file extension from '.JPG' to '.jpg'
* `rename 's/ /_/g' *` replace all 'space' characters in filenames with '_'
* [rename Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/rename?sort=votes&pageSize=15)

<br>
### <a name="ln"></a>ln

>make links between files

Create hard or soft link of file or folder. Soft link is similar to short-cuts created in Windows. Hard link is like same file with different name, same timestamp and permissions of original file. Hard links can be moved to another directory after creation, will still have content even when original file is deleted. On the other hand, soft links have their own timestamps and permissions, it cannot be moved to another folder unless the link creation was done using full path and of course becomes a dead link when original file is deleted. More differences [here](http://askubuntu.com/questions/108771/what-is-the-difference-between-a-hard-link-and-a-symbolic-link)

**Examples**

* `ln -s results/report.log .` create a symbolic link of report.log from results folder to current directory
* `ln results/report.log report.log` create a hard link of report.log from results folder to current directory, will not lose content even if results/report.log file is deleted
* `unlink report.log` delete link
    * `rm report.log` can also be used
* [ln Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/ln?sort=votes&pageSize=15)
* [ln Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/ln?sort=votes&pageSize=15)

<br>
### <a name="tar-and-gzip"></a>tar and gzip

`tar` is archiving utility. The archived file is same size as combined sizes of archived files  
Usually so often combined with compression utility like `gzip` that there is a way to do it just using the `tar` command.

**Examples**

Archive and Compression

* `tar -cvf backup_mar15.tar project results` create backup_mar15.tar of files/folders project and results
    * `-v` option stands for verbose, i.e displays all the files and directories being archived
* `gzip backup_mar15.tar` overwrites backup_mar15.tar with backup_mar15.tar.gz, a compressed version
* `tar cvfz backup_mar15.tar.gz project results` create backup_mar15.tar and overwrite with backup_mar15.tar.gz

Extract archive and Decompression

* `gunzip backup_mar15.tar.gz` decompress and overwrite as backup_mar15.tar
* `tar -xvf backup_mar15.tar` extract archived files to current directory
* `tar xvfz backup_mar15.tar.gz` decompress and extract archived files to current directory

z commands

* `zcat story.txt.gz` display file contents of compressed file on standard output
* `zless story.txt.gz` display file contents of compressed file one screenful at a time
* There are other commands as well like `zgrep`, `zdiff`, `zcmp` etc to work on compressed files

**Further Reading**

* [tar Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/tar?sort=votes&pageSize=15)
* [tar Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/tar?sort=votes&pageSize=15)
