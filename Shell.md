# <a name="shell"></a>Shell

* [What is Shell?](#what-is-shell)
* [Popular Shells](#popular-shells)
* [Wildcards](#wildcards)
* [Redirection](#redirection)
* [Process Control](#process-control)
* [Running jobs in background](#running-jobs-in-background)

<br>
### <a name="what-is-shell"></a>What is Shell?

Quoting from [wikipedia](https://en.wikipedia.org/wiki/Unix_shell)

>A Unix shell is a command-line interpreter or shell that provides a traditional Unix-like command line user interface. Users direct the operation of the computer by entering commands as text for a command line interpreter to execute, or by creating text scripts of one or more such commands. Users typically interact with a Unix shell using a terminal emulator, however, direct operation via serial hardware connections, or networking session, are common for server systems. All Unix shells provide filename wildcarding, piping, here documents, command substitution, variables and control structures for condition-testing and iteration

* Interprets user commands
	* from terminal, from a file or as a shell script
	* expand wildcards, command/variable substitution
* Command history, command completion and command editing
* Managing processes
* Shell variables to customize the environment
* [Difference between shell, tty and console](https://www.reddit.com/r/programming/comments/41u5hw/what_is_the_exact_difference_between_a_terminal_a/)

<br>
### <a name="popular-shells"></a>Popular Shells

Like any indispensible software, Shell has undergone transformation from the days of basic `sh` shell that was used in 1970s Unix. While `bash` is default shell in most distros and most commonly used, powerful and feature rich shells are still being developed and released

* `sh` bourne shell (light weight Linux distros might come with `sh` shell only)
* `bash` bourne again shell
* `csh` C shell
* `tcsh` tenex C shell
* `ksh` Korn shell
* `zsh` Z shell (bourne shell with improvements, including features from bash, tcsh, ksh)
* `cat /etc/shells` displays list of login shells available in the current Linux distro
* `echo $SHELL` path of current user's login shell
    * The material presented here is primarily for interactive shell
    * [difference between login shell and non-login shell](https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell)

**Further Reading**

* [Comparison of command shells](https://en.wikipedia.org/wiki/Comparison_of_command_shells)
* [Features and differences between various shells](http://www.faqs.org/faqs/unix-faq/shell/shell-differences/)
* [syntax comparison on different shells with examples](http://hyperpolyglot.org/unix-shells)
* `bash` shell has also been ported on Windows platform
    * [git bash](https://git-for-windows.github.io/)
    * [Cygwin](https://www.cygwin.com/)
    * [MinGW](http://www.mingw.org/)
    * [Linux Subsystem for Windows](http://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/)
* [Shell, choosing shell and changing default shells](https://wiki.ubuntu.com/ChangingShells)

<br>
### <a name="wildcards"></a>Wildcards

It is easy to specify complete filenames as command arguments when they are few in number. But suppose, one has to delete hundreds of log files, spread across different sub-directories? Wildcards, or also known as globbing patterns help in such cases, provided the filenames have a commonality to exploit. We have already seen regular expressions used in commands like `grep` and `sed`. Shell wildcards are similar

**wildcards**

* `*` match any character, 0 or more times
    * as a special case, `*` won't match the starting `.` of hidden files and has to be explicity specified
* `?` match any character exactly 1 time
* `[aeiou]` match any vowel character
* `[!aeiou]` exclude vowel characters, i.e match a consonant
* `[!0-9]` match any character except digits
* `[a-z]` match any lower case alphabets
* `[0-9a-fA-F]` match any hexademical character
* `{word1,word2}` match either of the specified words
    * words can themselves be made of wildcards

**Examples**

* `ls txt*` list all files starting with txt
* `ls *txt*` list all files containing txt anywhere in its name
* `ls *txt` list all files ending with txt in the current directory
* `ls -d .*` list only hidden files and directories
* `rm *.???` remove any file ending with . character followed by exactly three characters
* `ls bkp/201[0-5]` list files in bkp directory matching 2010/2011/2012/2013/2014/2015
* `echo *txt` for dry runs, use `echo` command to see how the wildcard expands

**Brace Expansion**

* `ls *{txt,log}` list all files ending with txt or log in the current directory
* `cp ~/projects/adders/verilog/{half_,full_}adder.v .` copy half_adder.v and full_adder.v to current directory
* `mv story.txt{,.bkp}` rename story.txt as story.txt.bkp
* `cp story.txt{,.bkp}` to create bkp file as well retain original
* `mv story.txt{.bkp,}` rename story.txt.bkp as story.txt
* `mv story{,_old}.txt` rename story.txt as story_old.txt
* `touch file{1..4}.txt` same as `touch file1.txt file2.txt file3.txt file4.txt`
* `touch file_{x..z}.txt` same as `touch file_x.txt file_y.txt file_z.txt`
* `rm file{1..4}.txt` same as `rm file1.txt file2.txt file3.txt file4.txt`
* `echo story.txt{,.bkp}` displays the expanded version 'story.txt story.txt.bkp' , useful to dry run before executing actual command

**Further Reading**

* [Glob](http://mywiki.wooledge.org/glob)
* See topic 'Pathname Expansion' in `info bash`
* [brace expansion wiki](http://wiki.bash-hackers.org/syntax/expansion/brace)
* [when to use brace expansion](https://unix.stackexchange.com/questions/6035/when-do-you-use-brace-expansion)

<br>
### <a name="redirection"></a>Redirection

By default all results of a command are displayed on the terminal, which is the default destination for **standard output**. But often, one might want to save or discard them or send as input to another command. Similarly, inputs to a command can be given from files or from another command. Errors are special outputs generated on a wrong usage of command or command name

* `<` or `0<` is stdin filehandle
* `>` or `1>` is stdout filehandle
* `2>` is stderr filehandle

**Redirecting output of a command to a file**

* `grep -i error report/*.log > error.log` create new file, overwrite if file already exists
* `grep -i fail test_results_20mar2015.log >> all_fail_tests.log` creates new file if file doesn’t exist, otherwise append the result to existing file
* `./script.sh > /dev/null` redirect output to a special file `/dev/null` that just discards everything written to it, whatever may be the size
* [explicitly override the setting of noclobber with the >| redirection operator](https://unix.stackexchange.com/questions/45201/bash-what-does-do/45203#45203)

**Redirecting output of a command to another command**

* `ls -l | grep '^d'` the 'pipe' operator redirects standard output of `ls` command to `grep` command as standard input
* `du -sh * | sort -h` calculate size of files/folders, display size in human-readable format which is then sorted
* `./script.sh | tee output.log` the `tee` command displays standard output on terminal as well as writes to file

**Combining output of several commands**

* `(head -5 ~/.vimrc ; tail -5 ~/.vimrc) > vimrc_snippet.txt` multiple commands can be grouped in `()` and redirected as if single command output
    * commands grouped in () gets executed in a subshell environment
* `{ head -5 ~/.vimrc ; tail -5 ~/.vimrc ; } > vimrc_snippet.txt` gets executed in current shell context
* [Command grouping](http://www.gnu.org/software/bash/manual/bashref.html#Command-Grouping)

**Substituting output of command**

* `sed -i -r "s/(.*)/$(basename $PWD)\/\1/" dir_list.txt` add current directory name and forward-slash character at the start of every line
    * Note the use of double quotes to perform command substitution
* `rm -r $(cat remove_files.txt)` remove all files/folders mentioned in remove_files.txt
* `gvim "$(ls -t *.txt | head -1)"` open the latest modified file ending with txt in current directory
* [Command Substitution](http://mywiki.wooledge.org/CommandSubstitution)

**Process Substitution - redirecting output of command as file**

* `comm -23 <(sort file1.txt) <(sort file2.txt)` allows to create named pipes, effectively avoiding need to create temporary files
* [Process Substitution](http://wiki.bash-hackers.org/syntax/expansion/proc_subst)
* [input and output process substitution examples](https://unix.stackexchange.com/questions/17107/process-substitution-and-pipe)

**Redirecting error**

* `xyz 2> cmderror.log` assuming a non-existent command `xyz`, it would give an error and gets redirected to specified file
* `./script.sh 2> /dev/null` discard error messages

**Combining stdout and stderr**

* `grep 'test' report.log test_list.txt &> grep_test.txt` redirect both stdout and stderr to a file
* `./script.sh &> /dev/null` discard output and error messages
* `grep 'test' report.log test_list.txt &>> grep_test.txt` append both stdout and stderr to a file
* [redirect a stream to another file descriptor using >&](https://stackoverflow.com/questions/818255/in-the-shell-what-does-21-mean)
    * `1>&2` redirect stdout to stderr
    * `2>&1` redirect stderr to stdout
* [difference between 2>&1 >foo and >foo 2>&1](http://mywiki.wooledge.org/BashFAQ/055)
* [redirect and append both stdout and stderr to a file](https://stackoverflow.com/questions/876239/how-can-i-redirect-and-append-both-stdout-and-stderr-to-a-file-with-bash)

**Redirecting input**

* `tr a-z A-Z < test_list.txt` convert lowercase to uppercase, `tr` command only reads from `stdin` and doesn't have the ability to read from a file directly 
    * `cat test_list.txt | tr a-z A-Z` can also be used
* `wc < report.log` fancy way to avoid filename in `wc` output
* `grep 'test' report.log | diff - test_list.txt` output of `grep` as one of the input file for `diff` command
* [difference between << , <<< and < <](http://askubuntu.com/questions/678915/whats-the-difference-between-and-in-bash)

**Using xargs to redirect output of command as input to another command**

* `cat dir_list.txt | xargs mkdir` create directories listed in dir_list.txt file
    * enclose directory name in single quotes if it contains special characters like space
* [When to use xargs](https://unix.stackexchange.com/questions/24954/when-is-xargs-needed)
    * has a good example for [parallel processing jobs with xargs](https://unix.stackexchange.com/questions/24954/when-is-xargs-needed/24979#24979)

**Further Reading**

* See topic 'REDIRECTION' in `info bash`
* [stdin, stdout and stderr](https://stackoverflow.com/questions/3385201/confused-about-stdin-stdout-and-stderr)
* [Illustrated Redirection Tutorial](http://wiki.bash-hackers.org/howto/redirection_tutorial)
* [short introduction](http://mywiki.wooledge.org/BashGuide/InputAndOutput#Redirection)
* [Redirections explained](http://www.catonmat.net/blog/bash-one-liners-explained-part-three/)

<br>
### <a name="process-control"></a>Process Control

* `Process` is any running program
    * Program is a set of instructions written to perform a task
* `Daemon` to simply put, are background processes
* `Job` in Shell parlance is a process that is not a daemon, i.e an interactive program with user control

**ps**

>report a snapshot of the current processes

* First column indicates the process id (PID)
* `-e` select all processes
* `-f` full-format listing
* [ps Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/ps?sort=votes&pageSize=15)
* [ps Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/ps?sort=votes&pageSize=15)
* [ps tutorial](https://linuxjourney.com/lesson/monitor-processes-ps-command)

**kill**

>send a signal to a process

* `kill -l` list signal names
* `kill PID` send default 'SIGTERM' signal to a process (specified by the PID) asking the process to terminate
* [gracefully shutdown processes](https://stackoverflow.com/questions/690415/in-what-order-should-i-send-signals-to-gracefully-shutdown-processes/690631#690631)
* [why kill -9 should be avoided](https://unix.stackexchange.com/questions/8916/when-should-i-not-kill-9-a-process)
* [kill Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/kill?sort=votes&pageSize=15)
* [kill Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/kill?sort=votes&pageSize=15)
* See also `pkill` and `killall` commands

**top**

>display Linux processes

* Press `M` (uppercase) to sort the processes by memory usage
* Press `q` to quit the command
* Press `W` (uppercase) to write your favorite view of top command to `~/.toprc` file and quit immediately, so that next time you use top command, it will display in the format you like
* [htop](https://www.reddit.com/r/linux/comments/3ih6n9/why_do_people_seem_to_prefer_htop_over_top/) is better/prettier alternative to top
    * install instructions [here](http://ccm.net/faq/41400-linux-how-to-install-htop)
* [top Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/top?sort=votes&pageSize=15)

**free**

>Display amount of free and used memory in the system

* `free -h` shows amount of free and used memory in human readable format

**pgrep**

>look up or signal processes based on name and other attributes

* `pgrep -l foobar` search for process names containing foobar, displays PID and full process name
* `pgrep -x gvim` search for processes exactly named gvim
* `pgrep -c chrom` total number of processes matching chrom
* `pgrep -nl chrom` most recently started process matching chrom

<br>
**Further Reading**

* [Process Management](http://ryanstutorials.net/linuxtutorial/processes.php)
* [Managing Linux Processes](https://www.digitalocean.com/community/tutorials/how-to-use-ps-kill-and-nice-to-manage-processes-in-linux)
* [Linux Processes](http://www.tldp.org/LDP/tlk/kernel/processes.html)
* [what is daemon](http://en.wikipedia.org/wiki/Daemon_(computing))
* [Job Control commands](http://linuxcommand.org/lc3_lts0100.php)
* [Useful examples for top command](http://www.thegeekstuff.com/2010/01/15-practical-unix-linux-top-command-examples/#more-2515)

<br>
### <a name="running-jobs-in-background"></a>Running jobs in background

Often commands and scripts can take more than few minutes to complete, but user might still need to continue using the shell. Opening a new shell might not serve the purpose if local shell variable settings are needed too. Shell provides the `&` operator to push the commad (or script) execution to background and return the command prompt to the user. However, the standard outputs and errors would still get displayed on the terminal unless appropriately redirected

* `tkdiff result_v1.log result_v2.log &` tkdiff, if installed, shows differences between two files in a GUI. If `&` is not used, the program would hog the command prompt

**Pushing current job to background**

What if you forgot to add `&` and using `kill` on the process might corrupt lot of things?

* `Ctrl+z` suspends the current running job
* `bg` push the recently suspended job to background
* Continue using shell
* `fg` bring the recently pushed background job to foreground
* `jobs` built-in command - Display status of jobs
* `nohup` command - run a command immune to hangups, with output to a non-tty
* [job control](https://www.digitalocean.com/community/tutorials/how-to-use-bash-s-job-control-to-manage-foreground-and-background-processes)
