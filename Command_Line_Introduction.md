# <a name="command-line-introduction"></a>Command Line introduction

**Table of Contents**

* [File System](#file-system)
    * [Absolute and Relative paths](#absolute-and-relative-paths)
* [Command Line Interface](#command-line-interface)
* [Command Help](#command-help)
* [Do one thing and do it well](#do-one-thing-and-do-it-well)
    * [Command Structure](#command-structure)
    * [Command Network](#command-network)

<br>

For any thing that is repetitive or programmable, there likely is a relevant command. Ask your peers or search online before you start writing a script. Just remember that Unix was first introduced in late 1960s - there is likely to be a command for what you need

Starting trouble with command line (for those accustomed to GUI) is the sudden trouble of interacting with the computer using just text commands. After using for a week or so, things will seem very systematic and GUI feels ill suited for frequent tasks. With continuous use, recalling various commands becomes easier. Short-cuts, history, aliases and tab-completion help in the process

If you've used a scientific calculator, you'd know that it is handy with too many functionalities cramped into tiny screen and plethora of multi-purpose buttons. Commands and short-cuts pack much more punch than that on a terminal

* Commands presented here are Linux specific and generally behave similarly across distros
* Commands in Linux usually have added features compared to [POSIX](https://en.wikipedia.org/wiki/POSIX) specification
* If any command is not found in a particular distro, either it has to be manually installed or probably an alternate exists
* The **bash** shell version 4+ is used throughout this material
    * [rough overview of changes to Bash over time](http://wiki.bash-hackers.org/scripting/bashchanges)

<br>

## <a name="file-system"></a>File System

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

<br>

#### <a name="absolute-and-relative-paths"></a>Absolute and Relative paths

Quoting [wikipedia](https://en.wikipedia.org/wiki/Path_%28computing%29#Absolute_and_relative_paths)

>An **absolute or full path** points to the same location in a file system regardless of the current working directory. To do that, it must contain the root directory.

>By contrast, a **relative path** starts from some given working directory, avoiding the need to provide the full absolute path. A filename can be considered as a relative path based at the current working directory. If the working directory is not the file's parent directory, a file not found error will result if the file is addressed by its name.

* `/home/learnbyexample` absolute path
* `../design` relative path
* [unix.stackexchange: Is ~/Documents a relative or an absolute path?](https://unix.stackexchange.com/questions/221970/is-documents-a-relative-or-an-absolute-path)

**Further Reading**

* [Learning the Linux File System - video tutorial](https://www.youtube.com/watch?v=HIXzJ3Rz9po)
* [Overview of file system](http://tldp.org/LDP/intro-linux/html/sect_03_01.html)

<br>

## <a name="command-line-interface"></a>Command Line Interface

Command Line Interface (CLI) allows us interact with computer using text commands

For example: the `cd` command would help navigating to a particular directory and `ls` command to view contents of a directory. In GUI, you'd use an explorer for directory navigation by point and click, directory contents are shown by default

Shell and Terminal are sometimes interchangeably used to mean the same thing - a prompt where user types and executes commands. However, they are [quite different](https://unix.stackexchange.com/questions/4126/what-is-the-exact-difference-between-a-terminal-a-shell-a-tty-and-a-con)

* **Shell** is command line interpreter, sets the syntax rules for invoking commands, etc
* **Terminal** text input/output environment, responsible for visual details like font size, color, etc

We'll learn more about Shell in later chapters. For now, open a Terminal and try these commands by typing them and pressing Enter key. You can spot the command lines by the prompt `$` at start of line

```bash
$ cat /etc/shells
# /etc/shells: valid login shells
/bin/sh
/bin/dash
/bin/bash
/bin/rbash
/bin/tcsh
/usr/bin/tcsh

$ echo "$SHELL"
/bin/bash
```

Note: Your command prompt might be different, for now you can leave it as or change it to the simple prompt I prefer by executing `PS1="$ "`

In the above example, `cat` command is used to display contents of a file and `echo` command is used to display contents of a variable - these commands have other uses as well, which will be covered later on

<br>

## <a name="command-help"></a>Command Help

Most distros for personal use come with documentation for commands already installed. Getting used to reading manual from terminal is handy and there are various ways to get specific information

* `man` command is an interface to reference manuals
	* usually displayed using `less` command, press `q` key to quit the man page and `h` key to get help
	* for Linux commands, the `info` command gives the complete documentation
    * you could also read them online, for ex: [GNU Coreutils manual](https://www.gnu.org/software/coreutils/manual/coreutils.html) has manuals for most of the commands covered in this material
* `man man` will give details about the `man` command itself
* `man bash` will give you the manual page for `bash`
	* `man find | gvim -` to open the manual page in your favorite text editor
* `man -k printf` will search the short descriptions in all the manual pages for the string `printf`
    * `-k` here is a command option
    * `man -k` is equivalent for `apropos` command
* Excellent resource [unix.stackexchange: How do I use man pages to learn how to use commands?](https://unix.stackexchange.com/questions/193815/how-do-i-use-man-pages-to-learn-how-to-use-commands)
* See also [wiki.archlinux: man page](https://wiki.archlinux.org/index.php/man_page)

For certain operations, shell provides its own set of commands, referred as builtin commands

* `type` will display information about command type
* typically used to get path of command or expand alias/function, use `help type` for documentation
* See also [unix.stackexchange: What is the difference between a builtin command and one that is not?](https://unix.stackexchange.com/questions/11454/what-is-the-difference-between-a-builtin-command-and-one-that-is-not)
* See also [unix.stackexchange: Why not use “which”? What to use then?](https://unix.stackexchange.com/questions/85249/why-not-use-which-what-to-use-then)

```bash
$ type cd
cd is a shell builtin
$ type sed
sed is /bin/sed

$ multiple commands can be given as arguments
$ type pwd awk
pwd is a shell builtin
awk is /usr/bin/awk

$ type ls
ls is aliased to `ls --color=auto'
$ type -a ls
ls is aliased to `ls --color=auto'
ls is /bin/ls
```

* `help` command provides documentation for builtin commands
	* `help help` help page on `help` command
	* `-m` option will display usage in pseudo-manpage format
	* `-d` option gives short description for each topic, similar to `whatis` command
	* `help` command by itself without any argument displays all shell commands that are defined internally

```
$ help pwd
pwd: pwd [-LP]
    Print the name of the current working directory.
    
    Options:
      -L	print the value of $PWD if it names the current working directory
      -P	print the physical directory, without any symbolic links
    
    By default, `pwd' behaves as if `-L' were specified.
    
    Exit Status:
    Returns 0 unless an invalid option is given or the current directory
    cannot be read.

$ help -d compgen
compgen - Display possible completions depending on the options.
```

Here's some more companion commands

* `whatis` displays one-line manual page descriptions
* `whereis` locates the binary, source, and manual page files for a command
* [explainshell](https://explainshell.com/) is a web app that shows the help text that matches each argument of command line
    * example: [tar xzvf archive.tar.gz](https://explainshell.com/explain?cmd=tar%20xzvf%20archive.tar.gz)
* [ch](https://github.com/learnbyexample/command_help) is a script, inspired by explainshell, to extract option descriptions from man/help pages

```
$ whatis grep
grep (1)             - print lines matching a pattern

$ whereis awk
awk: /usr/bin/awk /usr/share/awk /usr/share/man/man1/awk.1.gz

$ ch sort -k
       sort - sort lines of text files

       -k, --key=KEYDEF
              sort via a key; KEYDEF gives location and type
```

<br>

## <a name="do-one-thing-and-do-it-well"></a>Do one thing and do it well

The [Unix Philosophy](https://en.wikipedia.org/wiki/Unix_philosophy) applies to Linux as well:

>Write programs that do one thing and do it well
>
>Write programs to work together
>
>Write programs to handle text streams, because that is a universal interface

Examples given below are for demonstration purposes only, more detail in later chapters

<br>

#### <a name="command-structure"></a>Command Structure

only the command

* `clear` clear the terminal screen
* `top` display Linux processes

command with options

* `ls -l` list directory contents, use a long listing format
* `df -h` report file system disk space usage, print sizes in human readable format (e.g., 1K 234M 2G)

command with arguments

* `mkdir project` create directory named 'project' in current working directory
* `man sort` manual page for `sort` command
* `wget https://s.ntnu.no/bashguide.pdf` download file from internet

command with options and arguments

* `rm -r project` remove 'project' directory 
* `paste -sd, ip.txt` combine all lines from 'ip.txt' file to single line using `,` as delimiter

single quotes vs double quotes

* **single quotes** preserves the literal value of each character within the quotes
* **double quotes** preserves the literal value of all characters within the quotes, with the exception of '$', '`', '\\', and, when history expansion is enabled, '!'
* See also [stackoverflow: Difference between single and double quotes](https://stackoverflow.com/questions/6697753/difference-between-single-and-double-quotes-in-bash)

```bash
$ echo '$SHELL'
$SHELL

$ echo "$SHELL"
/bin/bash
```

<br>

#### <a name="command-network"></a>Command Network

Redirecting output of a command

* to another command
    * `du -sh * | sort -h` calculate size of files/folders, display size in human-readable format which is then sorted
* to a file (instead of displaying on terminal)
    * `grep 'pass' *.log > pass_list.txt` writes to file (if file already exists, it is overwritten)
    * `grep 'error' *.log >> errors.txt` appends to file (creates new file if necessary)
* to a variable
    * `p=$(pwd)` saves the output of `pwd` command in variable `p`, there should be no spaces around `=`

Redirecting input

* `wc -l < file.txt` useful to get just the number of lines, without displaying file name
* `tr 'a-z' 'A-Z' < ip.txt` some commands like `tr` only work on stdin

Redirecting error

* `xyz 2> cmderror.log` assuming a non-existent command `xyz`, it would give an error and gets redirected to specified file

Redirecting output of command as input file

* `comm -23 <(sort file1.txt) <(sort file2.txt)` process substitution, avoids need to create temporary files

Combining output of several commands

* `(head -n5 ~/.vimrc ; tail -n5 ~/.vimrc) > vimrc_snippet.txt` multiple commands (separated by `;`) can be grouped inside a list

Command substitution

* `sed -i "s|^|$(basename $PWD)/|" dir_list.txt` add current directory path and forward-slash character at the start of every line
    * Note the use of double quotes

stdin, stdout and stderr

* `<` or `0<` is stdin filehandle
* `>` or `1>` is stdout filehandle
* `2>` is stderr filehandle
* See also [stackoverflow: stdin, stdout and stderr](https://stackoverflow.com/questions/3385201/confused-about-stdin-stdout-and-stderr)

More detailed discussion in [Shell](./Shell.md) chapter

