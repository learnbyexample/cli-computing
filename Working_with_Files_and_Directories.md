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
* [basename](#basename)
* [dirname](#dirname)
* [chmod](#chmod)

In this chapter, we will see how to display contents of a file, search within files, search for files, get file properties and information, what are the permissions for files/directories and how to change them to our requirements

<br>

### <a name="cat"></a>cat

>concatenate files and print on the standard output

**Options**

* `-n` number output lines
* `-s` squeeze repeated empty lines into single empty line
* `-e` show non-printing characters and end of line
* `-A` in addition to `-e`, also shows tab characters

**Examples**

* One or more files can be given as input and hence a lot of times, `cat` is used to quickly see contents of small single file on terminal
    * But not needed to simply pass file content as stdin to other commands. See [Useless Use of Cat Award](http://porkmail.org/era/unix/award.html)
* To save the output of concatenation, just redirect stdout

```bash
$ ls
marks_2015.txt  marks_2016.txt  marks_2017.txt

$ cat marks_201*
Name    Maths   Science
foo     67      78
bar     87      85
Name    Maths   Science
foo     70      75
bar     85      88
Name    Maths   Science
foo     68      76
bar     90      90

$ # save stdout to a file
$ cat marks_201* > all_marks.txt
```

* often used option is `-A` to see various non-printing characters and end of line

```bash
$ printf 'foo\0bar\tbaz  \r\n'
foobar  baz

$ printf 'foo\0bar\tbaz  \r\n' | cat -A
foo^@bar^Ibaz  ^M$
```

* use `tac` to reverse input line wise

```bash
$ tac marks_2015.txt
bar     87      85
foo     67      78
Name    Maths   Science

$ seq 3 | tac
3
2
1
```

**Further Reading**

* For more detailed examples and discussion, see section [cat from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/tail_less_cat_head.md#cat)
* [cat Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/cat?sort=votes&pageSize=15)
* [cat Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/cat?sort=votes&pageSize=15)

<br>

### <a name="less"></a>less

>opposite of more

`cat` command is not suitable for viewing contents of large files on the Terminal. `less` displays contents of a file, automatically fits to size of Terminal, allows scrolling in either direction and other options for effective viewing. Usually, `man` command uses `less` command to display the help page. The navigation options are similar to `vi` editor

Commonly used commands are given below, press `h` for summary of options

* `g` go to start of file
* `G` go to end of file
* `q` quit
* `/pattern` search for the given pattern in forward direction
* `?pattern` search for the given pattern in backward direction
* `n` go to next pattern
* `N` go to previous pattern

**Example and Further Reading**

* `less -s large_filename` display contents of file large_filename using less command, consecutive blank lines are squeezed as single blank line
    * Use `-N` option to prefix line number
* `less` command is an [improved version](https://unix.stackexchange.com/questions/604/isnt-less-just-more) of `more` command
* [differences between most, more and less](https://unix.stackexchange.com/questions/81129/what-are-the-differences-between-most-more-and-less)
* [less Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/less?sort=votes&pageSize=15)

<br>

### <a name="tail"></a>tail

>output the last part of files

**Examples**

* By default, `tail` displays last 10 lines
* Use `-n` option to change how many lines are needed

```bash
$ # last two lines
$ tail -n2 report.log
Error: something seriously went wrong
blah blah blah

$ # all lines starting from 3rd line i.e all lines except first two lines
$ seq 13 17 | tail -n +3
15
16
17
```

* multiple file input

```bash
$ # use -q option to avoid filename in output
$ tail -n2 report.log sample.txt 
==> report.log <==
Error: something seriously went wrong
blah blah blah

==> sample.txt <==
He he he
Adios amigo
```

* characterwise extraction
    * Note that this works byte wise and not suitable for multi-byte character encodings

```bash
$ # last three characters including the newline character
$ echo 'Hi there!' | tail -c3
e!

$ # excluding the first character
$ echo 'Hi there!' | tail -c +2
i there!
```

**Further Reading**

* For more detailed examples and discussion, see section [tail from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/tail_less_cat_head.md#tail)
* [tail Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/tail?sort=votes&pageSize=15)
* [tail Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/tail?sort=votes&pageSize=15)

<br>

### <a name="head"></a>head

>output the first part of files

**Examples**

* By default, `head` displays first 10 lines
* Use `-n` option to change how many lines are needed

```bash
$ head -n3 report.log
blah blah
Warning: something went wrong
more blah

$ # tail gives last 10 lines, head then gives first 2 from tail output
$ tail sample.txt | head -n2
Just do-it
Believe it

$ # except last 2 lines
$ seq 13 17 | head -n -2
13
14
15
```

* multiple file input

```bash
$ # use -q option to avoid filename in output
$ head -n3 report.log sample.txt 
==> report.log <==
blah blah
Warning: something went wrong
more blah

==> sample.txt <==
Hello World!

Good day
```

* characterwise extraction
    * Note that this works byte wise and not suitable for multi-byte character encodings

```bash
$ # first two characters
$ echo 'Hi there!' | head -c2
Hi

$ # excluding last four characters
$ echo 'Hi there!' | head -c -4
Hi the
```

**Further Reading**

* For more detailed examples and discussion, see section [head from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/tail_less_cat_head.md#head)
* [head Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/head?sort=votes&pageSize=15)

<br>

### <a name="text-editors"></a>Text Editors

For editing text files, the following applications can be used. Of these, `gedit`, `nano`, `vi` and/or `vim` are available in most distros by default

Easy to use

* [gedit](https://wiki.gnome.org/Apps/Gedit)
* [geany](https://www.geany.org/)
* [nano](https://nano-editor.org/)

Powerful text editors

* [vim](https://github.com/vim/vim)
    * [vim learning resources](https://github.com/learnbyexample/scripting_course/blob/master/Vim_curated_resources.md) and [vim reference](https://github.com/learnbyexample/vim_reference) for further info
* [emacs](https://www.gnu.org/software/emacs/)
* [atom](https://atom.io/)
* [sublime](https://www.sublimetext.com/)

<br>

### <a name="grep"></a>grep

>print lines matching a pattern

`grep` stands for **Global Regular Expression Print**. Used to search for a pattern in given files - whether a particular word or pattern is present (or not present), name of files containing the pattern, etc. By default, matching is performed in any part of a line, options and regular expressions can be used to match only the desired part

**Options**

* `--color=auto` display the matched pattern, file names, line numbers etc with color distinction
* `-i` ignore case while matching
* `-v` print non-matching lines, i.e it inverts the selection
* `-n` print also line numbers of matched pattern
* `-c` display only the count of number of lines matching the pattern
* `-l` print only the filenames with matching pattern
* `-L` print filenames NOT matching the pattern
* `-w` match pattern against whole word
* `-x` match pattern against whole line
* `-F` interpret pattern to search as fixed string (i.e not a regular expression). Faster as well
* `-o` print only matching parts
* `-A number` print matching line and 'number' of lines after the matched line
* `-B number` print matching line and 'number' of lines before the matched line
* `-C number` print matching line and 'number' of lines before and after the matched line
* `-m number` restrict printing to upper limit of matched lines specified by 'number'
* `-q` no standard output, quit immediately if match found. Useful in scripts to check if a file contains search pattern or not
* `-s` suppress error messages if file doesn't exist or not readable. Again, more useful in scripts
* `-r` recursively search all files in specified folders
* `-h` do not prefix filename for matching lines (default behavior for single file search)
* `-H` prefix filename for matching lines (default behavior for multiple file search)

**Examples**

* `grep 'area' report.log` will print all lines containing the word area in report.log
* `grep 'adder power' report.log` will print lines containing adder power
* `man grep | grep -i -A 5 'exit status'` will print matched line and 5 lines after containing the words 'exit status' independent of case
    * See **Context Line Control** topic in `info grep` for related options like `--no-group-separator`
* `grep -m 5 'error' report.log` will print maximum of 5 lines containing the word error
* `grep "$HOME" /etc/passwd` will print lines matching the value of environment variable HOME
    * Note the use of double quotes for variable substitution
* `grep -w 'or' story.txt` match whole word or, not part of word like for, thorn etc
* `grep -x 'power' test_list.txt` match whole line containing the pattern power

*Note:* All of the above examples would be suited for `-F` option as these do not use regular expressions and will be faster with `-F` option

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

* `grep -i '[a-z]' report.log` will print all lines having atleast one alphabet character
* `grep '[0-9]' report.log` will print all lines having atleast one number
* `grep 'area\|power' report.log` will match lines containing area or power
* `grep -E 'area|power' report.log` will match lines containing area or power
* `grep -E 'hand(y|ful)' short_story.txt` match handy or handful
* `grep -E '(Th)?is' short_story.txt` match This or is
* `grep -iE '([a-z])\1' short_story.txt` match same alphabet appearing consecutively like 'aa', 'FF', 'Ee'  etc

**Perl Compatible Regular Expression**

* `grep -P '\d' report.log` will print all lines having atleast one number
* `grep -P '(Th)?is' short_story.txt` match This or is
* `grep -oP 'file\K\d+' report.log` print only digits that are preceded by the string 'file'
* `man pcrepattern` syntax and semantics of the regular expressions that are supported by PCRE
* [look-around assertions example](https://unix.stackexchange.com/questions/13466/can-grep-output-only-specified-groupings-that-match)

**Example input files**
```bash
$ cat ip.txt 
Roses are red,
Violets are blue,
Sugar is sweet,
And so are you.

$ echo -e 'Red\nGreen\nBlue\nBlack\nWhite' > colors.txt 
$ cat colors.txt 
Red
Green
Blue
Black
White
```

* string search, use `-F` for faster results

```bash
$ grep -F 'are' ip.txt 
Roses are red,
Violets are blue,
And so are you.

$ grep -Fv 'are' ip.txt 
Sugar is sweet,

$ grep -Fc 'are' ip.txt 
3

$ grep -F -m2 'are' ip.txt 
Roses are red,
Violets are blue,

$ grep -F 'rose' ip.txt 
$ grep -Fi 'rose' ip.txt 
Roses are red,
```

* regular expression, cannot use `-F`

```bash
$ # lines with words starting with s or S
$ grep -iE '\bs' ip.txt 
Sugar is sweet,
And so are you.

$ # get only the words starting with s or S
$ grep -ioE '\bs[a-z]+' ip.txt 
Sugar
sweet
so
```

* using file input to specify search terms

```bash
$ grep -Fif colors.txt ip.txt 
Roses are red,
Violets are blue,

$ echo -e 'Brown\nRed\nGreen\nBlue\nYellow\nBlack\nWhite' > more_colors.txt 

$ # get common lines between two files
$ grep -Fxf colors.txt more_colors.txt 
Red
Green
Blue
Black
White

$ # get lines present in more_colors.txt but not colors.txt
$ grep -Fxvf colors.txt more_colors.txt 
Brown
Yellow
```

**Further Reading**

* For more detailed examples and discussion, see [GNU grep chapter from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/gnu_grep.md)
* [how grep command was born](https://medium.com/@rualthanzauva/grep-was-a-private-command-of-mine-for-quite-a-while-before-i-made-it-public-ken-thompson-a40e24a5ef48)
* [why GNU grep is fast](https://lists.freebsd.org/pipermail/freebsd-current/2010-August/019310.html)
* [Difference between grep, egrep and fgrep](https://unix.stackexchange.com/questions/17949/what-is-the-difference-between-grep-egrep-and-fgrep)
* [grep Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/grep?sort=votes&pageSize=15)
* [grep Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/grep?sort=votes&pageSize=15)

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

Filtering based on depth

The relative path `.` is considered as depth 0 directory, files and folders immediately contained in a directory are at depth 1 and so on

* `find -maxdepth 1 -type f` all regular files (including hidden ones) from current directory (without going to sub-directories)
* `find -maxdepth 1 -type f -name '[!.]*'` all regular files (but not hidden ones) from current directory (without going to sub-directories)
    * `-not -name '.*'` can be also used
* `find -mindepth 1 -maxdepth 1 -type d` all directories (including hidden ones) in current directory (without going to sub-directories)

Filtering based on file properties

* `find -mtime -2` print files that were modified within last two days in current directory
    * Note that day here means 24 hours
* `find -mtime +7` print files that were modified more than seven days back in current directory
* `find -daystart -type f -mtime -1` files that were modified from beginning of day (not past 24 hours)
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
    * also note that number of invocations of command specified is not necessarily once if number of files found is too large
* `find -name '*.log' -exec mv {} ../log/ \;` move files ending with .log to log directory present in one hierarchy above. `mv` is executed once per each filtered file
* `find -name '*.log' -exec mv -t ../log/ {} +` the `-t` option allows to specify target directory and then provide multiple files to be moved as argument
    * Similarly, one can use `-t` for `cp` command

**Further Reading**

* [using find](https://mywiki.wooledge.org/UsingFind)
* [Collection of find examples](https://alvinalexander.com/unix/edu/examples/find.shtml)
* [find Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/find?sort=votes&pageSize=15)
* [find and tar example](https://unix.stackexchange.com/questions/282762/find-mtime-1-print-xargs-tar-archives-all-files-from-directory-ignoring-t/282885#282885)
* [find Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/find?sort=votes&pageSize=15)
* [Why is looping over find's output bad practice?](https://unix.stackexchange.com/questions/321697/why-is-looping-over-finds-output-bad-practice)

<br>

### <a name="locate"></a>locate

>find files by name

Faster alternative to `find` command when searching for a file by its name. It is based on a database, which gets updated by a `cron` job. So, newer files may be not present in results. Use this command if it is available in your distro and you remember some part of filename. Very useful if one has to search entire filesystem in which case `find` command might take a very long time compared to `locate`

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

```bash
$ # by default, gives newline/word/byte count (in that order)
$ wc sample.txt 
 5 17 78 sample.txt

$ # options to get only newline/word/byte count
$ wc -l sample.txt 
5 sample.txt
$ wc -w sample.txt 
17 sample.txt
$ wc -c sample.txt 
78 sample.txt

$ # use shell input redirection if filename is not needed
$ wc -l < sample.txt 
5
```

* multiple file input

```bash
$ # automatically displays total at end
$ wc *.txt
  5  10  57 fruits.txt
  2   6  32 greeting.txt
  5  17  78 sample.txt
 12  33 167 total
```

* other options

```bash
$ # use -L to get length of longest line
$ # won't count non-printable characters, tabs are converted to equivalent spaces
$ wc -L < sample.txt 
24
$ printf 'foo\tbar\0baz' | wc -L
14
$ printf 'foo\tbar\0baz' | awk '{print length()}'
11

$ # -c gives byte count, -m gives character count
$ printf 'hi👍' | wc -m
3
$ printf 'hi👍' | wc -c
6
```

**Further Reading**

* For more detailed examples and discussion, see section [wc from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/file_attributes.md#wc)
* [wc Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/wc?sort=votes&pageSize=15)
* [wc Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/wc?sort=votes&pageSize=15)

<br>

### <a name="du"></a>du

>estimate file space usage

**Examples**

```bash
$ # By default, size is given in size of 1024 bytes
$ # Files are ignored, all directories and sub-directories are recursively reported
$ # add -a option if files are also needed and -L if links should be dereferenced
$ du
17920   ./projs/full_addr
14316   ./projs/half_addr
32952   ./projs
33880   .

$ # use -s to show total directory size without descending into sub-directories
$ # add -c to also show total size at end
$ du -s projs words.txt
32952   projs
924     words.txt
```

* different size formatting options

```bash
$ # number of bytes
$ du -b words.txt
938848  words.txt

$ # kilobytes = 1024 bytes
$ du -sk projs
32952   projs

$ # megabytes = 1024 kilobytes
$ du -sm projs
33      projs

$ # human readable, use --si for powers of 1000 instead of 1024
$ du -h words.txt
924K    words.txt

$ # sorting
$ du -sh projs/* words.txt | sort -h
712K    projs/report.log
924K    words.txt
14M     projs/half_addr
18M     projs/full_addr
```

**Further Reading**

* For more detailed examples and discussion, see section [du from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/file_attributes.md#du)
* [du Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/disk-usage?sort=votes&pageSize=15)
* [du Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/du?sort=votes&pageSize=15)

<br>

### <a name="df"></a>df

>report file system disk space usage

**Examples**

```bash
$ # use df without arguments to get information on all currently mounted file systems
$ df .
Filesystem     1K-blocks     Used Available Use% Mounted on
/dev/sda1       98298500 58563816  34734748  63% /

$ # use -B option for custom size
$ # use --si for size in powers of 1000 instead of 1024
$ df -h .
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        94G   56G   34G  63% /
```

* Use `--output` to report only specific fields of interest

```bash
$ df -h --output=size,used,file / /media/learnbyexample/projs
 Size  Used File
  94G   56G /
  92G   35G /media/learnbyexample/projs

$ df -h --output=pcent .
Use%
 63%

$ df -h --output=pcent,fstype | awk -F'%' 'NR>2 && $1>=40'
 63% ext3
 40% ext4
 51% ext4
```


**Further Reading**

* For more detailed examples and discussion, see section [df from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/file_attributes.md#df)
* [df Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/df?sort=votes&pageSize=15)

<br>

### <a name="touch"></a>touch

>change file timestamps

**Examples**

```bash
$ # last access and modification time
$ stat -c $'%x\n%y' fruits.txt
2017-07-19 17:06:01.523308599 +0530
2017-07-13 13:54:03.576055933 +0530

$ # Updating both access and modification timestamp to current time
$ # add -a to change only access timestamp and -m to change only modification
$ touch fruits.txt 
$ stat -c $'%x\n%y' fruits.txt
2017-07-21 10:11:44.241921229 +0530
2017-07-21 10:11:44.241921229 +0530

$ # copy both access and modification timestamp from power.log to report.log
$ # add -a or -m as needed
$ # See also -d and -t options
$ touch -r power.log report.log
```

* If file doesn't exist, an empty one gets created unless -c is used

```bash
$ ls foo.txt
ls: cannot access 'foo.txt': No such file or directory

$ touch foo.txt
$ ls foo.txt
foo.txt
```

**Further Reading**

* For more detailed examples and discussion, see section [touch from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/file_attributes.md#touch)
* [touch Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/touch?sort=votes&pageSize=15)

<br>

### <a name="file"></a>file

>determine file type

**Examples**

```bash
$ file sample.txt 
sample.txt: ASCII text
$ printf 'hi👍\n' | file -
/dev/stdin: UTF-8 Unicode text
$ file ch
ch:  Bourne-Again shell script, ASCII text executable

$ printf 'hi\r\n' | file -
/dev/stdin: ASCII text, with CRLF line terminators

$ file sunset.jpg moon.png
sunset.jpg: JPEG image data
moon.png: PNG image data, 32 x 32, 8-bit/color RGBA, non-interlaced
```

* find all files of particular type in current directory, for example `image` files

```bash
$ find -type f -exec bash -c '(file -b "$0" | grep -wq "image data") && echo "$0"' {} \;
./sunset.jpg
./moon.png

$ # if filenames do not contain : or newline characters
$ find -type f -exec file {} + | awk -F: '/\<image data\>/{print $1}'
./sunset.jpg
./moon.png
```

**Further Reading**

* For more detailed examples and discussion, see section [file from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/file_attributes.md#file)
* See also `identify` command which `describes the format and characteristics of one or more image files`

<br>

### <a name="basename"></a>basename

>strip directory and suffix from filenames

**Examples**

```bash
$ # same as using pwd command
$ echo "$PWD"
/home/learnbyexample

$ basename "$PWD"
learnbyexample

$ # use -a option if there are multiple arguments
$ basename -a foo/a/report.log bar/y/power.log
report.log
power.log

$ # use single quotes if arguments contain space and other special shell characters
$ # use suffix option -s to strip file extension from filename
$ basename -s '.log' '/home/learnbyexample/proj adder/power.log'
power
$ # -a is implied when using -s option
$ basename -s'.log' foo/a/report.log bar/y/power.log
report
power
```

* For more detailed examples and discussion, see section [basename from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/miscellaneous.md#basename)

<br>

### <a name="dirname"></a>dirname

>strip last component from file name

**Examples**

```bash
$ echo "$PWD"
/home/learnbyexample

$ dirname "$PWD"
/home

$ # use single quotes if arguments contain space and other special shell characters
$ dirname '/home/learnbyexample/proj adder/power.log'
/home/learnbyexample/proj adder

$ # unlike basename, by default dirname handles multiple arguments
$ dirname foo/a/report.log bar/y/power.log
foo/a
bar/y

$ # if no / in argument, output is . to indicate current directory
$ dirname power.log
.
```

* For more detailed examples and discussion, see section [dirname from command line text processing repo](https://github.com/learnbyexample/Command-line-text-processing/blob/master/miscellaneous.md#dirname)

<br>

### <a name="chmod"></a>chmod

>change file mode bits

```bash
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

```bash
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

```bash
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

```bash
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

```bash
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

```bash
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

* What permissions are affected by `+-/rwx` depends on `umask` value as well. It is usually `002` which means
    * `+r -r +x -x` without `u g o` qualifier affects all the three categories
    * `+w -w` without `u g o` qualifier affects only user and group categories

**Further Reading**

* [Linux File Permissions](https://www.linux.com/learn/getting-know-linux-file-permissions)
* [Linux Permissions Primer](https://danielmiessler.com/study/unixlinux_permissions/)
* [unix.stackexchange - Why chmod +w filename not giving write permission to other](https://unix.stackexchange.com/questions/429421/why-chmod-w-filename-not-giving-write-permission-to-othero)
* [chmod Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/chmod?sort=votes&pageSize=15)
* [chmod Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/chmod?sort=votes&pageSize=15)

