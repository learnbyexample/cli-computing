# <a name="working-with-files-and-directories"></a>Working with Files and Directories

* [cat](#cat)
* [less](#less)
* [tail](#tail)
* [head](#head)
* [Text Editors](#text-editors)
* [grep](#grep)
* [find](#find)
* [locate](#locate)
* [wc](#wc)
* [du](#du)
* [df](#df)
* [touch](#touch)
* [file](#file)
* [identify](#identify)
* [basename](#basename)
* [chmod](#chmod)

In this chapter, we will see how to display contents of a file, search within files, search for files, get file properties and information, what are the permissions for files/directories and how to change them to our requirements

<br>
### <a name="cat"></a>cat

>concatenate files and print on the standard output

**Options**

* `-n` number output lines
* `-s` squeeze repeated empty lines into single empty line

**Examples**

* `cat > sample.txt` create a new file for writing, use `Ctrl+d` on a newline to save the file and quit
    * [difference between Ctrl+c and Ctrl+d to signal end of stdin input in bash](https://unix.stackexchange.com/questions/16333/how-to-signal-the-end-of-stdin-input-in-bash)
* `cat sample.txt` display the contents of file sample.txt
* `cat power.log timing.log area.log > report.log` concatenate the contents of all three files and save to report.log
* `tac sample.txt` display the lines of file sample.txt in reversed order
* [cat Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/cat?sort=votes&pageSize=15)
* [cat Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/cat?sort=votes&pageSize=15)

```
$ cat > sample.txt
This is an example of adding text to a new file using cat command.
Press Ctrl+d on a newline to save and quit.

$ cat sample.txt 
This is an example of adding text to a new file using cat command.
Press Ctrl+d on a newline to save and quit.

$ wc sample.txt 
  2  23 111 sample.txt

$ tac sample.txt 
Press Ctrl+d on a newline to save and quit.
This is an example of adding text to a new file using cat command.
```

<br>
### <a name="less"></a>less

>opposite of more

`cat` command is not suitable for viewing contents of large files on the Terminal. `less` displays contents of a file, automatically fits to size of Terminal, allows scrolling in either direction and other options for effective viewing. Usually, `man` command uses `less` command to display the help page. The navigation options are similar to `vi` editor

**Navigation options**

* `g` go to start of file
* `G` go to end of file
* `q` quit
* `/pattern` search for the given pattern
* `n` go to next pattern in forward direction
* `N` go to next pattern in backward direction
* `h` help

**Example and Further Reading**

* `less -s large_filename` display contents of file large_filename using less command, consecutive blank lines are squeezed as single blank line
* `less` command is an [improved version](https://unix.stackexchange.com/questions/604/isnt-less-just-more) of `more` command
* [differences between most, more and less](https://unix.stackexchange.com/questions/81129/what-are-the-differences-between-most-more-and-less)
* [less Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/less?sort=votes&pageSize=15)

<br>
### <a name="tail"></a>tail

>output the last part of files

**Examples**

* `tail report.log` by default display last 10 lines
* `tail -20 report.log` display last 20 lines
* `tail -5 report.log` display last 5 lines
* `tail power.log timing.log` display last 10 lines of both files preceded by filename header
* `tail -q power.log timing.log > result.log` save last 10 lines of both files without filename header to result.log
* `tail -n +3 report.log` display all lines starting from third line (i.e all lines except first two lines)
* [tail Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/tail?sort=votes&pageSize=15)
* [tail Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/tail?sort=votes&pageSize=15)

<br>
### <a name="head"></a>head

>output the first part of files

**Examples**

* `head report.log` display first 10 lines
* `head -20 report.log | tail report.log` display lines 11 to 20
* `tail -30 report.log | head -5 report.log` display 5 lines prior to last 25 lines of file
* `head -n -2 report.log` display all but last 2 lines
* [head Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/head?sort=votes&pageSize=15)

<br>
### <a name="text-editors"></a>Text Editors

For editing text files, the following applications can be used. Of these, `gedit`, `nano`, `vi` and/or `vim` are available in most distros by default

Easy to use

* [gedit](https://wiki.gnome.org/Apps/Gedit)
* [geany](http://www.geany.org/)
* [nano](http://nano-editor.org/)

Powerful text editors

* [vim](https://github.com/vim/vim)
    * [vim learning resources](https://github.com/learnbyexample/scripting_course/blob/master/Vim_curated_resources.md) and [vim reference](https://github.com/learnbyexample/vim_reference) for further info
* [emacs](https://www.gnu.org/software/emacs/)
* [atom](https://atom.io/)
* [sublime](https://www.sublimetext.com/)

<br>
### <a name="grep"></a>grep

>print lines matching a pattern

`grep` stands for **Global Regular Expression Print**. Used to search for a pattern in given files - whether a particular word or pattern is present (or not present), name of files containing the pattern, etc. By default, matching is performed any part of a line, options and regular expressions can be used to match only the desired part

**Options**

* `--color=auto` display the matched pattern, file names, line numbers etc with color
* `-i` ignore case while matching
* `-v` print non-matching lines, i.e it inverts the selection
* `-r` recursively search all files in specified folders
* `-n` print also line numbers of matched pattern
* `-c` display only the count of number of lines matching the pattern
* `-l` print only the filenames with matching pattern
* `-L` print filenames NOT matching the pattern
* `-w` match pattern against whole word
* `-x` match pattern against whole line
* `-o` print only matching parts
* `-A number` print matching line and 'number' of lines after the matched line
* `-B number` print matching line and 'number' of lines before the matched line
* `-C number` print matching line and 'number' of lines before and after the matched line
* `-m number` restrict printing to upper limit of matched lines specified by 'number'

**Examples**

* `grep 'area' report.log` will print all lines containing the word area in report.log
* `grep 'adder power' report.log` will print lines containing adder power
* `man grep | grep -i -A 5 'exit status'` will print matched line and 5 lines after containing the words 'exit status' independent of case
* `grep -m 5 'error' report.log` will print maximum of 5 lines containing the word error
* `grep "$HOME" /etc/passwd` will print lines matching the value of environment variable HOME
    * Note the use of double quotes for variable substitution
* `grep -w 'or' story.txt` match whole word or, not part of word like for, thorn etc
* `grep -x 'power' test_list.txt` match whole line containing the pattern power

**Regular Expressions**

Regular Expressions help in defining precise patterns, like extracting only alphabets or numbers, matching at start of line, end of line, character sequence, etc  
The following reference is for **ERE - Extended Regular Expressions**

Anchors

* `^` match from start of line
* `$` match end of line
* `\<` match beginning of word
* `\>` match end of word
* `\b` match edge of word
* `\B` match other than edge of word

Character Quantifiers

* `.` match any single character
* `*` match preceding character 0 or more times
* `+` match preceding character 1 or more times
* `?` match preceding character 0 or 1 times
* `{n}` match preceding character exactly n times
* `{n,}` match preceding character n or more times
* `{n,m}` match preceding character n to m times, including n and m
* `{,m}` match preceding character up to m times

Character classes

* `[aeiou]` match any of these characters
* `[^aeiou]` do not match any of these characters
* `[a-z]` match any lowercase alphabet
* `[0-9]` match any digit character
* `\w` match alphabets, digits and underscore character, short cut for `[a-zA-Z0-9_]`
* `\W` opposite of `\w` , short cut for `[^a-zA-Z0-9_]`
* `\s` match white-space characters: tab, newline, vertical tab, form feed, carriage return, and space
* `\S` match other than white-space characters

Pattern groups

* `|` matches either of the given patterns
* `()` patterns within `()` are grouped and treated as one pattern, useful in conjunction with `|`
* `\1` backreference to first grouped pattern within `()`
* `\2` backreference to second grouped pattern within `()` and so on

**Basic vs Extended Regular Expressions**

By default, the pattern passed to `grep` is treated as Basic Regular Expressions(BRE), which can be overridden using options like `-E` for ERE and `-P` for Perl Compatible Regular Expression(PCRE)  
Paraphrasing from `info grep`

>In Basic Regular Expressions the meta-characters `? + { | ( )` lose their special meaning, instead use the backslashed versions `\? \+ \{ \| \( \)`

**Examples**

* `grep -i '[a-z]' report.log` will print all lines having atleast one alphabet
* `grep '[0-9]' report.log` will print all lines having atleast one number
* `grep 'area\|power' report.log` will match lines containing area or power
* `grep -E 'area|power' report.log` will match lines containing area or power
* `grep -E 'hand(y|ful)' short_story.txt` match handy or handful
* `grep -E '(Th|)is' short_story.txt` match This or is
* `grep -iE '([a-z])\1' short_story.txt` match same alphabet appearing consecutively like 'aa', 'oo', 'EE'  etc

**Perl Compatible Regular Expression**

* `grep -P '\d' report.log` will print all lines having atleast one number
* `grep -P '(Th|)is' short_story.txt` match This or is
* `man pcrepattern` syntax and semantics of the regular expressions that are supported by PCRE
* [look-around assertions example](https://unix.stackexchange.com/questions/13466/can-grep-output-only-specified-groupings-that-match)

**Further Reading**

* [how grep command was born](https://medium.com/@rualthanzauva/grep-was-a-private-command-of-mine-for-quite-a-while-before-i-made-it-public-ken-thompson-a40e24a5ef48)
* [why GNU grep is fast](https://lists.freebsd.org/pipermail/freebsd-current/2010-August/019310.html)
* [grep tutorial](http://www.panix.com/~elflord/unix/grep.html)
* [grep examples](http://alvinalexander.com/unix/edu/examples/grep.shtml)
* [Difference between grep, egrep and fgrep](https://unix.stackexchange.com/questions/17949/what-is-the-difference-between-grep-egrep-and-fgrep)
* [grep Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/grep?sort=votes&pageSize=15)
* [grep Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/grep?sort=votes&pageSize=15)
* [ucg](https://github.com/gvansickle/ucg) - UniversalCodeGrep (ucg) is an extremely fast grep-like tool specialized for searching large bodies of source code


<br>
### <a name="find"></a>find

>search for files in a directory hierarchy

**Examples**

Filtering based on file name

* `find . -iname 'power.log'` search and print path of file named power.log (ignoring case) in current directory and its sub-directories
* `find -name '*log'` search and print path of all files whose name ends with log in current directory - using `.` is optional when searching in current directory
* `find -not -name '*log'` print path of all files whose name does NOT end with log in current directory
* `find -regextype egrep -regex '.*/\w+'` use extended regular expression to match filename containing only `[a-zA-Z_]` characters
    * `.*/` is needed to match initial part of file path

Filtering based on file type

* `find /home/guest1/proj -type f` print path of all regular files found in specified directory
* `find /home/guest1/proj -type d` print path of all directories found in specified directory
* `find /home/guest1/proj -type f -name '.*'` print path of all hidden files

Filtering based on file properties

* `find -mtime -2` print files that were modified within last two days in current directory
* `find -mtime +7` print files that were modified more than seven days back in current directory
* `find -size +10k` print files with size greater than 10 kilobytes in current directory
* `find -size -1M` print files with size less than 1 megabytes in current directory
* `find -size 2G` print files of size 2 gigabytes in current directory

Passing filtered files as input to other commands

* `find report -name '*log*' -exec rm {} \;` delete all filenames containing log in report folder and its sub-folders
    * here `rm` command is called for every file matching the search conditions
    * since `;` is a special character for shell, it needs to be escaped using `\`
* `find report -name '*log*' -delete` delete all filenames containing log in report folder and its sub-folders
* `find -name '*.txt' -exec wc {} +` list of files ending with txt are all passed together as argument to `wc` command instead of executing wc command for every file
    * no need to use escape the `+` character in this case
* `find -name '*.log' -exec mv {} ../log/ \;` move files ending with .log to log directory present in one hierarchy above

**Further Reading**

* [using find](http://mywiki.wooledge.org/UsingFind)
* [Collection of find examples](http://alvinalexander.com/unix/edu/examples/find.shtml)
* [find Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/find?sort=votes&pageSize=15)
* [find and tar example](https://unix.stackexchange.com/questions/282762/find-mtime-1-print-xargs-tar-archives-all-files-from-directory-ignoring-t/282885#282885)
* [find Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/find?sort=votes&pageSize=15)

<br>
### <a name="locate"></a>locate

>find files by name

Faster alternative to `find` command when searching for a file by its name. It is based on a database (usually by `updatedb(8)`), which gets updated by a `cron` job. So, newer files may be not present in results. Use this command if it is available in your distro and you remember some part of filename created a day or more ago. Very useful if one has to search entire filesystem in which case `find` command might take a very long time compared to `locate`

**Examples**

* `locate 'power'` print path of files containing power in the whole filesystem
    * matches anywhere in path, ex: '/home/learnbyexample/lowpower_adder/result.log' and '/home/learnbyexample/power.log' are both a valid match
    * implicitly, `locate` would change the string to `*power*` as no globbing characters are present in the string specified
* `locate -b '\power.log'` print path matching the string power.log exactly at end of path
    * '/home/learnbyexample/power.log' matches but not '/home/learnbyexample/lowpower.log'
    * since globbing character '\' is used while specifying search string, it doesn't get implicitly replaced by `*power.log*`
* `locate -b '\proj_adder'` the `-b` option also comes in handy to print only the path of directory name, otherwise every file under that folder would also be displayed
* [find vs locate - pros and cons](https://unix.stackexchange.com/questions/60205/locate-vs-find-usage-pros-and-cons-of-each-other)

<br>
### <a name="wc"></a>wc

>print newline, word, and byte counts for each file

**Examples**

* `wc power.log` outputs no. of lines, words and characters separated by white-space and followed by filename
* `wc -l power.log` outputs no. of lines followed by filename
* `wc -w power.log` outputs no. of words followed by filename
* `wc -c power.log` outputs no. of characters followed by filename
* `wc -l < power.log` output only the number of lines
* `wc -L power.log` length of longest line followed by filename
* [wc Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/wc?sort=votes&pageSize=15)
* [wc Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/wc?sort=votes&pageSize=15)

<br>
### <a name="du"></a>du

>estimate file space usage

* du command is useful for small folders, not for large ones or file systems.

**Examples**

* `du project_report` display size (default unit is 1024 bytes) of folder project_report as well as it sub-directories
* `du --si project_report` display size (unit is 1000 bytes) of folder project_report as well as it sub-directories
* `du -h project_report` display size in human readable format for folder project_report as well as it sub-directories
* `du -ah project_report` display size in human readable format for folder project_report and all of its files and sub-directories
* `du -sh project_report` display size only for project_report folder in human readable format
* `du -sm * | sort -n` sort files and folders of current directory, numbers displayed are in Megabytes
    * use `sort -nr` to reverse sort order, i.e largest at top
* `du -sh * | sort -h` sort files and folders of current directory, output displayed in human-readable format
* [du Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/disk-usage?sort=votes&pageSize=15)
* [du Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/du?sort=votes&pageSize=15)

<br>
### <a name="df"></a>df

>report file system disk space usage

**Examples**

* `df -h` display usage statistics of all available file systems
* `df -h .` display usage of only the file system where the current working directory is located
* [df Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/df?sort=votes&pageSize=15)

<br>
### <a name="touch"></a>touch

>change file timestamps

Used to change file time stamps. But if file doesn't exist, the command will create an empty file with the name provided. Both features are quite useful  

* Some program may require a particular file to be present to work, empty file might even be a valid argument. In such cases, a pre-processing script can scan the destination directories and create empty file if needed
* Similarly, some programs may behave differently according to the time stamps of two or more files - while debugging in such an environment, user might want to just change the time stamp of files

**Examples**

* `touch new_file.txt` create an empty file if it doesn't exist in current directory
* `touch report.log` change the time stamp of report.log to current time (assuming report.log already exists in current directory)
* [touch Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/touch?sort=votes&pageSize=15)

<br>
### <a name="file"></a>file

>determine file type

**Examples**

```
$ file sample.txt 
sample.txt: ASCII text

$ file sunset.jpg 
sunset.jpg: JPEG image data

$ mv sunset.jpg xyz
$ file xyz 
xyz: JPEG image data

$ file perl.png 
perl.png: PNG image data, 32 x 32, 8-bit/color RGBA, non-interlaced
```

<br>
### <a name="identify"></a>identify

>describes the format and characteristics of one or more image files

Although file command can also give information like pixel dimensions and image type, identify is more reliable command for images and gives complete format information

```
$ identify sunset.jpg
sunset.jpg JPEG 740x740 740x740+0+0 8-bit DirectClass 110KB 0.000u 0:00.030

$ identify perl.png 
perl.png PNG 32x32 32x32+0+0 8-bit DirectClass 838B 0.000u 0:00.000
```

<br>
### <a name="basename"></a>basename

>strip directory and suffix from filenames

```
$ pwd
/home/learnbyexample

$ basename $PWD
learnbyexample

$ basename '/home/learnbyexample/proj_adder/power.log'
power.log

$ #use suffix option -s to strip file extension from filename
$ basename -s '.log' '/home/learnbyexample/proj_adder/power.log'
power
```

<br>
### <a name="chmod"></a>chmod

>change file mode bits

```
$ ls -l sample.txt 
-rw-rw-r-- 1 learnbyexample learnbyexample 111 May 25 14:47 sample.txt
```

In the output of `ls -l` command, the first 10 characters displayed are related to type of file and its permissions.

First character indicates the **file type** The most common are

* `-` regular file
* `d` directory
* `l` symbolic link
* for complete list, see `-l` option in `info ls`

The other 9 characters represent three sets of **file permissions** for 'user', 'group' and 'others' - in that order

* `user`  file properties for owner of file - `u`
* `group` file properties for the group the file belongs to - `g`
* `others` file properties for everyone else - `o`

We'll be seeing only `rwx` file properties in this section, for other types of properties, [refer this detailed doc](https://www.mkssoftware.com/docs/man1/ls.1.asp#Long_Output_Format)

**Permission characters and values**

| Character | Meaning | Value | File | Directory |
| ------- | ------- | ------- | ------- | ------ |
| r | read | 4 | file can be read | can see contents of directory |
| w | write | 2 | file can be modified | can add/remove files in directory |
| x | execute | 1 | file can be run as a program | can access contents of directory |
| - | no permission | 0 | permission is disabled | permission is disabled |

**File Permissions**

```
$ pwd
/home/learnbyexample/linux_tutorial
$ ls -lF
total 8
-rw-rw-r-- 1 learnbyexample learnbyexample  40 May 28 13:25 hello_world.pl
-rw-rw-r-- 1 learnbyexample learnbyexample 111 May 25 14:47 sample.txt

$ #Files need execute permission to be run as program
$ ./hello_world.pl
bash: ./hello_world.pl: Permission denied
$ chmod +x hello_world.pl 
$ ls -lF hello_world.pl
-rwxrwxr-x 1 learnbyexample learnbyexample  40 May 28 13:25 hello_world.pl*
$ ./hello_world.pl
Hello World

$ #Read permission
$ cat sample.txt 
This is an example of adding text to a new file using cat command.
Press Ctrl+d on a newline to save and quit.
$ chmod -r sample.txt
$ ls -lF sample.txt 
--w--w---- 1 learnbyexample learnbyexample 111 May 25 14:47 sample.txt
$ cat sample.txt 
cat: sample.txt: Permission denied

$ #Files need write permission to modify its content
$ cat >> sample.txt 
Adding a line of text at end of file
^C
$ cat sample.txt 
cat: sample.txt: Permission denied
$ chmod +r sample.txt 
$ ls -lF sample.txt 
-rw-rw-r-- 1 learnbyexample learnbyexample 148 May 29 11:00 sample.txt
$ cat sample.txt 
This is an example of adding text to a new file using cat command.
Press Ctrl+d on a newline to save and quit.
Adding a line of text at end of file
$ chmod -w sample.txt 
$ ls -lF sample.txt 
-r--r--r-- 1 learnbyexample learnbyexample 148 May 29 11:00 sample.txt
$ cat >> sample.txt 
bash: sample.txt: Permission denied
```

**Directory Permissions**

```
$ ls -ld linux_tutorial/
drwxrwxr-x 2 learnbyexample learnbyexample 4096 May 29 10:59 linux_tutorial/

$ #Read Permission
$ ls linux_tutorial/
hello_world.pl  sample.txt
$ chmod -r linux_tutorial/
$ ls -ld linux_tutorial/
d-wx-wx--x 2 learnbyexample learnbyexample 4096 May 29 10:59 linux_tutorial/
$ ls linux_tutorial/
ls: cannot open directory linux_tutorial/: Permission denied
$ chmod +r linux_tutorial/

$ #Execute Permission
$ chmod -x linux_tutorial/
$ ls -ld linux_tutorial/
drw-rw-r-- 2 learnbyexample learnbyexample 4096 May 29 10:59 linux_tutorial/
$ ls linux_tutorial/
ls: cannot access linux_tutorial/hello_world.pl: Permission denied
ls: cannot access linux_tutorial/sample.txt: Permission denied
hello_world.pl  sample.txt
$ chmod +x linux_tutorial/

$ #Write Permission
$ chmod -w linux_tutorial/
$ ls -ld linux_tutorial/
dr-xr-xr-x 2 learnbyexample learnbyexample 4096 May 29 10:59 linux_tutorial/
$ touch linux_tutorial/new_file.txt
touch: cannot touch ‘linux_tutorial/new_file.txt’: Permission denied
$ chmod +w linux_tutorial/
$ ls -ld linux_tutorial/
drwxrwxr-x 2 learnbyexample learnbyexample 4096 May 29 10:59 linux_tutorial/
$ touch linux_tutorial/new_file.txt
$ ls linux_tutorial/
hello_world.pl  new_file.txt  sample.txt
```

**Changing multiple permissions at once**

```
$ # r(4) + w(2) + 0 = 6
$ # r(4) + 0 + 0 = 4
$ chmod 664 sample.txt 
$ ls -lF sample.txt 
-rw-rw-r-- 1 learnbyexample learnbyexample 148 May 29 11:00 sample.txt

$ # r(4) + w(2) + x(1) = 7
$ # r(4) + 0 + x(1) = 5
$ chmod 755 hello_world.pl 
$ ls -lF hello_world.pl 
-rwxr-xr-x 1 learnbyexample learnbyexample 40 May 28 13:25 hello_world.pl*

$ chmod 775 report/
$ ls -ld report/
drwxrwxr-x 2 learnbyexample learnbyexample 4096 May 29 14:01 report/
```

**Changing single permission selectively**

```
$ chmod o-r sample.txt 
$ ls -lF sample.txt 
-rw-rw---- 1 learnbyexample learnbyexample 148 May 29 11:00 sample.txt

$ chmod go-x hello_world.pl 
$ ls -lF hello_world.pl 
-rwxr--r-- 1 learnbyexample learnbyexample 40 May 28 13:25 hello_world.pl*

$ chmod go+x hello_world.pl 
$ ls -lF hello_world.pl 
-rwxr-xr-x 1 learnbyexample learnbyexample 40 May 28 13:25 hello_world.pl*
```

**Recursively changing permission for directory**

```
$ ls -lR linux_tutorial/
linux_tutorial/:
total 12
-rwxr-xr-x 1 learnbyexample learnbyexample   40 May 28 13:25 hello_world.pl
drwxrwxr-x 2 learnbyexample learnbyexample 4096 May 29 14:32 report
-rw-rw---- 1 learnbyexample learnbyexample  148 May 29 11:00 sample.txt

linux_tutorial/report:
total 0
-rw-rw-r-- 1 learnbyexample learnbyexample 0 May 29 11:46 new_file.txt
$ ls -ld linux_tutorial/
drwxrwxr-x 3 learnbyexample learnbyexample 4096 May 29 14:32 linux_tutorial/

$ #adding/removing files to a directory depends only on parent directory permissions
$ chmod -w linux_tutorial/
$ ls -ld linux_tutorial/
dr-xr-xr-x 3 learnbyexample learnbyexample 4096 May 29 14:32 linux_tutorial/
$ ls -ld linux_tutorial/report/
drwxrwxr-x 2 learnbyexample learnbyexample 4096 May 29 14:32 linux_tutorial/report/
$ rm linux_tutorial/sample.txt 
rm: cannot remove ‘linux_tutorial/sample.txt’: Permission denied
$ touch linux_tutorial/report/power.log
$ ls linux_tutorial/report/
new_file.txt  power.log
$ rm linux_tutorial/report/new_file.txt
$ ls linux_tutorial/report/
power.log

$ chmod +w linux_tutorial/
$ ls -ld linux_tutorial/
drwxrwxr-x 3 learnbyexample learnbyexample 4096 May 29 14:32 linux_tutorial/
$ chmod -w -R linux_tutorial/
$ ls -lR linux_tutorial/
linux_tutorial/:
total 12
-r-xr-xr-x 1 learnbyexample learnbyexample   40 May 28 13:25 hello_world.pl
dr-xr-xr-x 2 learnbyexample learnbyexample 4096 May 29 14:40 report
-r--r----- 1 learnbyexample learnbyexample  148 May 29 11:00 sample.txt

linux_tutorial/report:
total 0
-r--r--r-- 1 learnbyexample learnbyexample 0 May 29 14:39 power.log
$ rm linux_tutorial/report/power.log 
rm: remove write-protected regular empty file ‘linux_tutorial/report/power.log’? y
rm: cannot remove ‘linux_tutorial/report/power.log’: Permission denied
```

* `+r -r +x -x` without `u g o` qualifier affects all the three categories
* `+w -w` without `u g o` qualifier affects only user and group categories

**Further Reading**

* [permissions primer](http://www.catchlinux.com/permissions-primer/) - comprehensive tutorial, includes discussion on `/etc/passwd` , group permissions and more
* [Linux File Permissions](https://danielmiessler.com/study/unixlinux_permissions/)
* [chmod Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/chmod?sort=votes&pageSize=15)
* [chmod Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/chmod?sort=votes&pageSize=15)
