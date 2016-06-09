# <a name="command-line-introduction"></a>Command Line introduction

* [File System](#file-system)
* [Command Line Interface](#command-line-interface)
* [Command Help](#command-help)
* [Do one thing and do it well](#do-one-thing-well)


For any thing that is repetitive or programmable, there likely is a relevant command. Ask your peers or search online before you start writing a script. Just remember that Unix was first introduced in late 1960s - there is likely to be a command for what you need

Starting trouble with command line (for those accustomed to GUI) is the sudden trouble of interacting with the computer using just text commands. After using for a week or so, things will seem very systematic and GUI feels ill suited for frequent tasks. With continuous use, recalling various commands becomes easier. Short-cuts, history, aliases and tab-completion help in the process

* Commands presented here are GNU/Linux specific and generally behave similarly across distros
* Commands in GNU/Linux usually have a few different options and syntax than [POSIX](http://en.wikipedia.org/wiki/POSIX) specification
    * check the `man` page of a command to see if it supports POSIX options
* If any command is not found in a particular distro, either it has to be manually installed or not available for that distro

<br>
### <a name="file-system"></a>File System

Before we dive into ocean of commands, lets get a brief on Linux file system. If you've used Windows, you would be familiar with `C:` `D:` etc.  
In Linux, directory structure starts with `/` symbol, which is referred as the `root` directory

* `man hier` gives description of the filesystem hierarchy. A few examples:
    * `/` This is the root directory. This is where the whole tree starts.
    * `/bin` This directory contains executable programs which are needed in single user mode and to bring the system up or repair it.
    * `/home` On machines with home directories for users, these are usually beneath this directory, directly or not. The structure of this directory depends on local administration decisions.
    * `/tmp` This directory contains temporary files which may be deleted with no notice, such as by a regular job or at system boot up.
    * `/usr` This directory is usually mounted from a separate partition. It should hold only sharable, read-only data, so that it can be mounted by various machines running Linux.
    * `/usr/bin` This is the primary directory for executable programs. Most programs executed by normal users which are not needed for booting or for repairing the system and which are not installed locally should be placed in this directory.
    * `/usr/share` This directory contains subdirectories with specific application data, that can be shared among different architectures of the same OS. Often one finds stuff here that used to live in /usr/doc or /usr/lib or /usr/man.

**Absolute and Relative paths**

Quoting [wikipedia](https://en.wikipedia.org/wiki/Path_%28computing%29#Absolute_and_relative_paths)

>An **absolute or full path** points to the same location in a file system regardless of the current working directory. To do that, it must contain the root directory.

>By contrast, a **relative path** starts from some given working directory, avoiding the need to provide the full absolute path. A filename can be considered as a relative path based at the current working directory. If the working directory is not the file's parent directory, a file not found error will result if the file is addressed by its name.

* `/home/learnbyexample` absolute path
* `../design` relative path
* [~/Documents is a relative or an absolute path?](https://unix.stackexchange.com/questions/221970/is-documents-a-relative-or-an-absolute-path)

**Further Reading**

* [Learning the Linux File System - video tutorial](https://www.youtube.com/watch?v=HIXzJ3Rz9po)
* [Overview of file system](http://tldp.org/LDP/intro-linux/html/sect_03_01.html)

<br>
### <a name="command-line-interface"></a>Command Line Interface

Command Line Interface (CLI) allows us interact with computer using text commands  
For example, opening a Terminal, typing `ls` and pressing **Enter** key - the `ls` command lists the contents of a directory. To do the same thing in GUI, you double-click on the directory to view its content

Shell and Terminal are sometimes interchangeably used to mean the same thing - a prompt where user enters and executes commands. They are [quite different](https://unix.stackexchange.com/questions/4126/what-is-the-exact-difference-between-a-terminal-a-shell-a-tty-and-a-con)

* **Shell** command line interpreter
* **Terminal** text input/output environment 
* `cat /etc/shells` to know which shells are available
* `echo "$SHELL"` to know which is your login-shell
* The **bash** shell is used throughout this material, which is usually the default shell on most distros

<br>
### <a name="command-help"></a>Command Help

* `man man` get help about manual pages
	* usually displayed using `less` command, press `q` key to quit the man page and `h` key to get help
	* for GNU/Linux commands, use the `info` command to get more detailed manual
* `man bash` manual page for `bash`
	* `gvim <(man bash)` open the manual page in text editor instead of displaying in terminal
* `man -k printf` search manual pages for `printf`
    * `man -k` is equivalent for `apropos` command
* `type` Display information about command type
	* `type cd` cd is a shell builtin
	* `type sed` sed is /bin/sed
	* `type ls` ls is aliased to `ls --color=auto`
* Use `help` for builtin commands instead of `man`
	* `help help` help page on `help` command
	* `help -m cd` display usage in pseudo-manpage format for `cd` command
	* `help -d compgen` use -d option to output short description for each topic
	* `help` display all shell commands that are defined internally
* `whatis` display one-line manual page descriptions
    * `whatis grep` print lines matching a pattern
* `whereis` locate the binary, source, and manual page files for a command
    * `whereis awk` awk: /usr/bin/awk /usr/bin/X11/awk /usr/share/awk /usr/share/man/man1/awk.1.gz
* `history` Display or manipulate the history list
* [explainshell](http://explainshell.com/) write down a command-line to see the help text that matches each argument
    * example: [find . -type f -print0](http://explainshell.com/explain?cmd=find%20.%20-type%20f%20-print0)

Excellent resource: [How do I use man pages to learn how to use commands?](https://unix.stackexchange.com/questions/193815/how-do-i-use-man-pages-to-learn-how-to-use-commands)

<br>
### <a name="do-one-thing-well"></a>Do one thing and do it well

[Unix Philosophy](https://en.wikipedia.org/wiki/Unix_philosophy)

>Write programs that do one thing and do it well.

>Write programs to work together.

>Write programs to handle text streams, because that is a universal interface.

Examples given below are for demonstration purposes only, more detail in later chapters

**Command Structure**

only the command

* `clear` clear the terminal screen
* `top` display Linux processes

command with options

* `ls -l` list directory contents, use a long listing format
* `df -h` report file system disk space usage, print sizes in human readable format (e.g., 1K 234M 2G)

command with arguments

* `mkdir project` create directory named 'project' in current working directory
* `man sort` manual page for `sort` command
* `wget http://s.ntnu.no/bashguide.pdf` download file from internet

command with options and arguments

* `rm -r project` remove 'project' directory 
* `find . -name '*log*'` print files in current directory (and its sub-directories) whose name contains the string 'log'

single quotes vs double quotes

* **single quotes** preserves the literal value of each character within the quotes
* **double quotes** preserves the literal value of all characters within the quotes, with the exception of '$', '`', '\', and, when history expansion is enabled, '!'
* [Difference between single and double quotes](https://stackoverflow.com/questions/6697753/difference-between-single-and-double-quotes-in-bash)

Example:

```
$ echo '$SHELL'
$SHELL
$ echo "$SHELL"
/bin/bash
```

**Command Network**

Redirecting output of a command

* to another command
    * `du -sh * | sort -h` calculate size of files/folders, display size in human-readable format which is then sorted
* to a file (instead of displaying on terminal)
    * `ls *.txt > text_files.list` writes/overwrites to file
    * `ls *.txt >> text_files.list` appends to file

Redirecting input

* `wc -l < file.txt` in this case, useful to get just the number of lines, without displaying file name

Redirecting error

* `xyz 2> cmderror.log` assuming a non-existent command `xyz`, it would give an error and gets redirected to specified file

Redirecting output of command as input file

* `comm -23 <(sort file1.txt) <(sort file2.txt)` allows to create named pipes, effectively avoiding need to create temporary files

Combining output of several commands

* `(head -5 ~/.vimrc ; tail -5 ~/.vimrc) > vimrc_snippet.txt` multiple commands can be grouped in `()` and redirected as if single command output

Substituting output of command in a string

* `sed -i -r "s/(.*)/$(basename $PWD)\/\1/" dir_list.txt` add current directory name and forward-slash character at the start of every line
    * Note the use of double quotes

More detailed discussion in [Shell](./Shell.md) chapter

**stdin, stdout and stderr**

* `<` or `0<` is stdin filehandle
* `>` or `1>` is stdout filehandle
* `2>` is stderr filehandle
* [read more](https://stackoverflow.com/questions/3385201/confused-about-stdin-stdout-and-stderr)

