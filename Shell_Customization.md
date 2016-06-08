# <a name="shell-customization"></a>Shell Customization

* [Variables](#variables)
* [Config files](#config-files)
* [Emac mode Readline shortcuts](#emac-mode-readline-shortcuts)

<br>
### <a name="variables"></a>Variables

Quoting from [article on BASH Environment & Shell Variables](http://www.tricksofthetrades.net/2015/06/14/notes-bash-env-variables/)

>Variables provide a simple way to share configuration settings between multiple applications and processes in Linux, and are mainly set in either a terminal or shell configuration file upon start up.

>They are either environmental or shell variables by convention. Both of which are usually defined using all capital letters. This helps users distinguish environmental variables from within other contexts.

>“Environment variables” have been defined for use in the current shell and will be inherited by any child shells or processes spawned as a result of the parent. Environmental variables can also be used to pass information into processes that are spawned by the shell

>“Shell variables” are contained exclusively within the shell in which they were set or defined. They are mostly used to keep track of ephemeral temporal data, like the current working directory in a session

Some example Variables:

* `HOME` The home directory of the current user; the default argument for the `cd` builtin command. The value of this variable is also used when performing tilde expansion
* `SHELL` The full pathname to the shell is kept in this environment variable. If it is not set when the shell starts, bash assigns to it the full pathname of the current user's login shell
* `PATH` The search path for commands. It is a colon-separated list of directories in which the shell looks for commands. A common value is `/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin`
* `HISTFILESIZE,HISTSIZE,HISTCONTROL,HISTFILE` command history related variables
* `PS1` The value of this parameter is expanded and used as the primary prompt string. The default value is `\s-\v\$ `
* `printenv` command to display names and values of Environment variables
* `set` builtin command to display the names and values of all the variables when used without options/arguments
* `echo "$HOME"` use `$` when Variable value is needed

**User defined variables**

User can define variables as well - for temporary use, in shell script, etc.  
Using lowercase is preferred to avoid potential conflict with shell or environment variables

```
$ #array of 8-bit binary numbers in ascending order
$ dec2bin=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1})
$ echo "${dec2bin[2]}"
00000010
$ echo "${dec2bin[120]}"
01111000
$ echo "${dec2bin[255]}"
11111111
```

**Further Reading**

* Section 'Shell Variables' in `info bash`
* [Difference between shell and environment variables](https://stackoverflow.com/questions/3341372/differnce-between-the-shell-and-environment-variable-in-bash)
* [Variable behavior varies with different type of shells](http://sc.tamu.edu/help/general/unix/vars.html)
* [How to correctly modify PATH variable](https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path)
* [Read more on the dec2bin brace expansion example](https://twitter.com/climagic/status/593842202314420224)
* [Parameter expansion](http://wiki.bash-hackers.org/syntax/pe#simple_usage) - from simple ways to get Variable values to complicated manipulations

<br>
### <a name="config-files"></a>Config files

Through use of aliases, functions, shell variables, etc one can customize the shell as per their needs

From 'FILES' section in `info bash`

* `/etc/profile` The systemwide initialization file, executed for login shells
* `/etc/bash.bashrc` The systemwide per-interactive-shell startup file
* `/etc/bash.bash.logout` The systemwide login shell cleanup file, executed when a login shell exits
* `~/.bash_profile` The personal initialization file, executed for login shells
* `~/.bashrc` The individual per-interactive-shell startup file
* `~/.bash_logout` The individual login shell cleanup file, executed when a login shell exits
* `~/.inputrc` Individual readline initialization file

**~/.bashrc**

From 'INVOCATION' section in `info bash`

>When an interactive shell that is not a login shell is started, bash reads and executes commands from /etc/bash.bashrc and ~/.bashrc, if these files exist. This may be inhibited by using the --norc option. The --rcfile file option will force bash to read and execute commands from file instead of /etc/bash.bashrc and ~/.bashrc.

* `shopt` Set and unset shell options
    * `shopt -s autocd` change directory by typing just the name, without having to explicity type the `cd` command (`-s` sets/enables this option)
    * `shopt -u autocd` unset/disable autocd option
    * `shopt -s dotglob` include files starting with `.` also for wildcard expansion
    * [shopt builtin command](http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html)
* `set` Set or unset values of shell options and positional parameters
    * `set -o emacs` Use emacs-style line editing interface
    * `set -o vi` Use vi-style line editing interface
    * `set -o history` enable command history
    * `set +o history` disable command history, useful to temporarily disable logging command history for current session until it is re-enabled
    * `set -o` see current status of various options - are they on/off
    * [set builtin command](http://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html#The-Set-Builtin)
* aliases
    * aliases and functions are generally used to construct new commands or invoke commands with preferred options
    * `source ~/.bash_aliases` to avoid cluttering the bashrc file, it is recommended to put them in a separate file and use `source` command to add to bashrc
* history
    * By default, history commands are stored in ~/.bash_history, can be changed using `HISTFILE` variable
    * `HISTSIZE=5000` this variable affects how many commands are in history of current shell session. Use negative number for unlimited size
    * `HISTFILESIZE=10000` this variable affects how many commands are stored in the history file. Use negative number for unlimited file size
    * `HISTCONTROL=ignorespace:erasedups` don't save commands with leading space and erase all previous duplicates matching current command line
    * `shopt -s histappend` append to history file instead of overwriting
    * [using bash history efficiently](http://jorge.fbarr.net/2011/03/24/making-your-bash-history-more-efficient/)
    * [common history across sessions](https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history)
* Setting prompt using the `PS1` variable
    * `PS1="$ "` simple prompt '$ '
    * `PS1="\s-\v\$ "` default prompt, adds bash version number, for ex: 'bash-4.3$ '
    * `PS1="\u@\h\\$ \[$(tput sgr0)\]"` is way of saying to set the prompt as 'username@hostname$ '
    * [easy way to generate PS1](http://bashrcgenerator.com/) - above example was generated using this site, has options to add color as well
* [What does the ~/.bashrc file do?](http://askubuntu.com/questions/540683/what-is-a-bashrc-file-and-what-does-it-do)
* Distros like Ubuntu come with `~/.bashrc` already created with useful configurations like `bash_completion`
* [sample bashrc](https://github.com/learnbyexample/scripting_course/blob/master/.bashrc)

**~/.inputrc**

Key bindings for command line (readline) are customized in this file. By default, emacs-style is on and can be changed using the `set` command as discussed in previous section  
Some of the default key bindings are discussed later in this chapter

* `"\e[A": history-search-backward` up arrow to match history starting with partly typed text
* `"\e[B": history-search-forward` down arrow to search in forward direction
* `"\C-d": unix-filename-rubout` Ctrl+d to delete from cursor backwards to filename boundary
* `set echo-control-characters off` turn off control characters like `^C` (Ctrl+C) from showing on screen
* `set completion-ignore-case on` ignore case for Tab completion
* `set show-all-if-ambiguous on` combines single and double Tab presses behavior into single Tab press
* [Simpler introduction to Readline](https://wiki.archlinux.org/index.php/readline)
* [discussion on GNU Readline library](https://cnswww.cns.cwru.edu/php/chet/readline/readline.html) library allows user to interact/edit command line
* [sample inputrc](https://github.com/learnbyexample/scripting_course/blob/master/.inputrc)

**~/.bash_aliases**

Before creating an alias or function, use `type alias_name` to check if an existing command or alias exists with that name

* `alias` used without argument shows all aliases currently set, sorted in alphabetical order
* `alias c='clear'` alias `clear` command to just the single letter `c`
    * Note that there should be no white-space around = operator
* `alias b1='cd ../'` alias b1 to go back one hierarchy above
* `alias app='cd /home/xyz/Android/xyz/app/src/main/java/com/xyz/xyzapp/'` alias frequently used long paths. Particularly useful when working on multiple projects spanning multiple years
    * and if aliases are forgotten over the years, they can recalled by opening ~/.bash_aliases file or using `alias` command
* `alias oa='gvim ~/.bash_aliases'` open aliases file with your favorite editor
* `alias sa='source ~/.bash_aliases'` useful to apply changes to current session
* `alias ls='ls --color=auto'` colorize output to distinguish file types
* `alias l='ls -ltrh'` map favorite options, plus color output as previously set alias will be substituted for `ls`
* `alias grep='grep --color=auto'` colorize file names, line numbers, matched pattern, etc
* `alias s='du -sh * | sort -h'` sort files/directories by size and display in human-readable format
* `\ls` override alias and use original command by using the `\` prefix
* `ch() { man $1 | sed -n "/^\s*$2/,/^$/p" ; }` simple command help (ch) function to get information on a command option
    * for example: `ch ls -F` , `ch grep -o` , etc
	* `ch() { whatis $1; man $1 | sed -n "/^\s*$2/,/^$/p" ; }` also prints description of command
	* [explain](http://www.tecmint.com/explain-shell-commands-in-the-linux-shell/) command does a much better job
	* [explainshell](http://explainshell.com/) does similarly online
* `o() { gnome-open "$@" &> /dev/null ; }` open files with their default applications, discards output and error messages
    * for example: `o bashguide.pdf`
    * `$1` first positional argument
    * `$2` second positional argument
    * `$@` all the arguments
* [sample bash_aliases](https://github.com/learnbyexample/scripting_course/blob/master/.bash_aliases)

**Further Reading**

* [Sensible bash customizations](http://mrzool.cc/writing/sensible-bash/)
* [shell config files](http://blog.sanctum.geek.nz/shell-config-subfiles/)
* [command line navigation](http://cupfullofcode.com/blog/2013/07/03/efficient-command-line-navigation/index.html)
* [difference between bashrc and bash_profile](http://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile/183980#183980)
* [when to use alias, functions and scripts](https://unix.stackexchange.com/questions/30925/in-bash-when-to-alias-when-to-script-and-when-to-write-a-function/30964#30964)
* [what does rc in bashrc stand for](https://unix.stackexchange.com/questions/3467/what-does-rc-in-bashrc-stand-for)

<br>
### <a name="emac-mode-readline-shortcuts"></a>Emac mode Readline shortcuts

* `Ctrl+c` sends SIGINT signal, requesting the current running process to terminate
    * [how Ctrl+c works](https://stackoverflow.com/questions/6108953/how-does-ctrl-c-terminate-a-child-process)
* `Ctrl+c` can also be used to abort the currently typed command and give fresh command prompt
* `Ctrl+z` suspends the current running process
* `Tab` the tab key completes the command (even aliases) or filename if it is unique, double Tab gives list of possible matches if it is not unique
    * `set show-all-if-ambiguous on` combines single and double Tab presses behavior into single Tab press
* `Ctrl+r` Search command history. After pressing this key sequence, type characters you wish to match from history, then press `Esc` key to return to command prompt or press `Enter` to execute the command
* `Esc+b` move cursor backward by one word
* `Esc+f` move cursor forward by one word
* `Esc+Backspace` delete backwards upto word boundary
* `Ctrl+a` or `Home` move cursor to beginning to prompt
* `Ctrl+e` or `End` move cursor to end of command line
* `Ctrl+l` preserve whatever is typed in command prompt and clear the terminal screen
* `Ctrl+u` delete from beginning of command line upto cursor
* `Ctrl+k` delete from cursor to end of command line
* `Ctrl+t` swap the previous two characters around
    * For example: if you typed sp instead of ps, press Ctrl+t when the cursor is to right of sp and it will change to ps
* `Esc+t` swap the previous two words around
* `!$` last used argument
    * for example: if `cat temp.txt` was the last command used, `rm !$` will delete temp.txt file
	* `Esc+.` will insert the last used argument, useful when you need to modify before execution. Also multiple presses allows to traverse through second last command and so on
* `Mouse scroll button click` highlight text you want to copy and then press scroll button of mouse in destination to paste the text
    * to disable pasting text on `Mouse scroll button click` , use the `xinput` command and get the number corresponding to your mouse.. say it is `11`
	* `xinput set-button-map 11 1 0 3` to disable
    * `xinput set-button-map 11 1 2 3` to enable back
