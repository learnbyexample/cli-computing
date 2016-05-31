# Linux Commands: Text Processing

* [sort](#sort)
* [uniq](#uniq)
* [comm](#comm)
* [cmp](#cmp)
* [diff](#diff)
* [tr](#tr)
* [sed](#sed)
* [awk](#awk)
* [cut](#cut)
* [paste](#paste)
* [column](#column)
* [pr](#pr)

The rich set of text processing commands is comprehensive and time saving. Knowing even their existence is enough to avoid the need of writing yet another script (which takes time and effort plus debugging) – a trap which many beginners fall into. An extensive list of text processing commands and examples can be found [here](http://tldp.org/LDP/abs/html/textproc.html)

<br>
### <a name="sort"></a>sort

>sort lines of text files

As the name implies, this command is used to sort files. How about alphabetic sort and numeric sort? Possible. How about sorting a particular column? Possible. Prioritized multiple sorting order? Possible. Randomize? Unique? Just about any sorting need is catered by this powerful command

**Options**

* `-R` random sort
* `-r` reverse the sort order
* `-o` redirect sorted result to specified filename, very useful to sort a file inplace
* `-n` sort numerically
* `-h` sort human readable numbers like 4K, 3M, etc
* `-k` sort via key
* `-u` sort uniquely
* `-b` ignore leading white-spaces of a line while sorting

**Examples**

* `sort dir_list.txt` display sorted file on standard output
* `sort -bn numbers.txt -o numbers.txt` sort numbers.txt numerically (ignoring leading white-spaces) and overwrite the file with sorted output
* `sort -R crypto_keys.txt -o crypto_keys_random.txt` sort randomly and write to new file
	* `shuf crypto_keys.txt -o crypto_keys_random.txt` can also be used
* `du -sh * | sort -h` sort file/directory sizes in current directory in human readable format

**Further Reading**

* [sort like a master](http://www.skorks.com/2010/05/sort-files-like-a-master-with-the-linux-sort-command-bash/)
* [sort Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/sort?sort=votes&pageSize=15)
* [sort on multiple columns using -k option](https://unix.stackexchange.com/questions/249452/unix-multiple-column-sort-issue)

<br>
### <a name="uniq"></a>uniq

>report or omit repeated lines

This command is more specific to recognizing duplicates. Usually requires a sorted input as the comparison is made on adjacent lines only

**Options**

* `-d` print only duplicate lines
* `-c` prefix count to occurrences
* `-u` print only unique lines

**Examples**

* `sort test_list.txt | uniq` outputs lines of test_list.txt in sorted order with duplicate lines removed
	* `uniq <(sort test_list.txt)` same command using process substitution
	* `sort -u test_list.txt` equivalent command
* `uniq -d sorted_list.txt` print only duplicate lines
* `uniq -cd sorted_list.txt` print only duplicate lines and prefix the line with number of times it is repeated
* `uniq -u sorted_list.txt` print only unique lines, repeated lines are ignored
* [uniq Q&A on unix stackexchange](http://unix.stackexchange.com/questions/tagged/uniq?sort=votes&pageSize=15)

<br>
### <a name="comm"></a>comm

>compare two sorted files line by line

Without any options, it prints output in three columns - lines unique to file1, line unique to file2 and lines common to both files

**Options**

* `-1` suppress lines unique to file1
* `-2` suppress lines unique to file2
* `-3` suppress lines common to both files

**Examples**

* `comm -23 sorted_file1.txt sorted_file2.txt` print lines unique to sorted_file1.txt
    * `comm -23 <(sort file1.txt) <(sort file2.txt)'` same command using process substitution, if sorted input files are not available
* `comm -13 sorted_file1.txt sorted_file2.txt` print lines unique to sorted_file2.txt
* `comm -12 sorted_file1.txt sorted_file2.txt` print lines common to both files
* [comm Q&A on unix stackexchange](http://unix.stackexchange.com/questions/tagged/comm?sort=votes&pageSize=15)

<br>
### <a name="cmp"></a>cmp

>compare two files byte by byte

Useful to compare binary files. If the two files are same, no output is displayed (exit status 0)  
If there is a difference, it prints the first difference - line number and byte location (exit status 1)  
Option `-s` allows to suppress the output, useful in scripts

```
$ cmp /bin/grep /bin/fgrep
/bin/grep /bin/fgrep differ: byte 25, line 1

$ #note: some distros might have same binary for grep/egrep/fgrep
```

* More examples [here](http://www.sanfoundry.com/5-cmp-command-usage-examples-linux/)

<br>
### <a name="diff"></a>diff

>compare files line by line

Useful to compare text files. If the two files are same, no output is displayed (exit status 0)  
If there is a difference, it prints all the differences, which might not be desirable if files are too long

**Options**

* `-s` convey message when two files are same
* `-y` two column output
* `-i` ignore case while comparing
* `-w` ignore white-spaces
* `-r` recursively compare files between the two directories specified
* `-q` report if files differ, not the details of difference

**Examples**

* `diff -s test_list_mar2.txt test_list_mar3.txt` compare two files
* `diff -s report.log bkp/mar10/` no need to specify second filename if names are same
* `diff -qr report/ bkp/mar10/report/` recursively compare files between report and bkp/mar10/report directories, filenames not matching are also specified in output
    * see [this link](https://stackoverflow.com/questions/6217628/diff-to-output-only-the-file-names) for detailed analysis and corner cases
* `diff -r report/ bkp/mar10/report/ | grep -w 'diff'` useful trick to get only names of mismatching files (provided no mismatching lines contain the whole word diff)

**Further Reading**

* [diff Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/diff?sort=votes&pageSize=15)
* `gvimdiff` edit two, three or four versions of a file with Vim and show differences
* [GUI diff and merge tools](http://askubuntu.com/questions/2946/what-are-some-good-gui-diff-and-merge-applications-available-for-ubuntu)

<br>
### <a name="tr"></a>tr

>translate or delete characters

**Options**

* `-d` delete the specified characters
* `-c` complement set of characters to be replaced

**Examples**

* `tr a-z A-Z < test_list.txt` convert lowercase to uppercase
* `tr -d ._ < test_list.txt` delete the dot and underscore characters
* `tr a-z n-za-m < test_list.txt > encrypted_test_list.txt` Encrypt by replacing every lowercase alphabet with 13th alphabet after it
    * Same command on encrypted text will decrypt it
* [tr Q&A on unix stackexchange](http://unix.stackexchange.com/questions/tagged/tr?sort=votes&pageSize=15)

<br>
### <a name="sed"></a>sed

>stream editor for filtering and transforming text

**Options**

* `-n` suppress automatic printing of pattern space
* `-i` edit files in place (makes backup if SUFFIX supplied)
* `-r` use extended regular expressions
* `-e` add the script to the commands to be executed
* `-f` add the contents of script-file to the commands to be executed
    * for examples and details, refer to links given below

**commands**

We'll be seeing examples only for three commonly used commands

* `d` Delete the pattern space
* `p` Print out the pattern space
* `s` search and replace
* check out 'Often-Used Commands' and 'Less Frequently-Used Commands' sections in `info sed` for complete list of commands

**range**

By default, `sed` acts on all of input contents. This can be refined to specific line number or a range defined by line numbers, search pattern or mix of the two

* `n,m` range between nth line to mth line, including n and m
* `i~j` act on ith line and i+j, i+2j, i+3j, etc
    * `1~2` means 1st, 3rd, 5th, 7th, etc lines i.e odd numbered lines
    * `5~3` means 5th, 8th, 11th, etc 
* `n` only nth line
* `$` only last line
* `/pattern/` lines matching pattern
* `n,/pattern/` nth line to line matching pattern
* `n,+x` nth line and x lines after
* `/pattern/,m` line matching pattern to mth line
* `/pattern/,+x` line matching pattern and x lines after
* `/pattern1/,/pattern2/` line matching pattern1 to line matching pattern2
* `/pattern/I` lines matching pattern, pattern is case insensitive
* for more details, see section 'Selecting lines with sed' in `info sed`
* see 'Regular Expressions' in [grep command](https://github.com/learnbyexample/Linux_command_line/blob/master/Working_with_Files_and_Directories.md#grep) for extended regular expressions reference
* also check out 'Overview of Regular Expression Syntax' section in `info sed`

**Examples for selective deletion(d)**

* `sed '/cat/d' story.txt` delete every line containing cat
* `sed '/cat/!d' story.txt` delete every line NOT containing cat
* `sed '$d' story.txt` delete last line of the file
* `sed '2,5d' story.txt` delete lines 2,3,4,5 of the file
* `sed '1,/test/d' dir_list.txt` delete all lines from beginning of file to first occurence of line containing test (the matched line is also deleted)
* `sed '/test/,$d' dir_list.txt` delete all lines from line containing test to end of file

**Examples for selective printing(p)**

* `sed -n '5p' story.txt` print 5th line, `-n` option overrides default print behavior of sed
	* use `sed -n '5q;d' story.txt` on large files. [Read more](https://stackoverflow.com/questions/191364/quick-unix-command-to-display-specific-lines-in-the-middle-of-a-file/17367226#17367226)
* `sed -n '/cat/p' story.txt` print every line containing the text cat
	* equivalent to `sed '/cat/!d' story.txt`
* `sed -n '4,8!p' story.txt` print all lines except lines 4 to 8
* `man grep | sed -n '/^\s*exit status/I,/^$/p'` extract exit status information of a command from manual
    * `/^\s*exit status/I` checks for line starting with 'exit status' in case insensitive way, white-space may be present at start of line
    * `/^$/` empty line
* `man ls | sed -n '/^\s*-F/,/^$/p'` extract information on command option from manual
    * `/^\s*-F/` line starting with option '-F', white-space may be present at start of line

**Examples for search and replace(s)**

* `sed -i 's/cat/dog/g' story.txt` search and replace every occurence of cat with dog in story.txt
* `sed -i.bkp 's/cat/dog/g' story.txt` in addition to inplace file editing, create backup file story.txt.bkp, so that if a mistake happens, original file can be restored
    * `sed -i.bkp 's/cat/dog/g' *.txt` to perform operation on all files ending with .txt in current directory
* `sed -i '5,10s/cat/dog/gI' story.txt` search and replace every occurence of cat (case insensitive due to modifier I) with dog in story.txt only in line numbers 5 to 10
* `sed '/cat/ s/animal/mammal/g' story.txt` replace animal with mammal in all lines containing cat
    * Since `-i` option is not used, output is displayed on standard output and story.txt is not changed
    * spacing between range and command is optional, `sed '/cat/s/animal/mammal/g' story.txt` can also be used
* `sed -i -e 's/cat/dog/g' -e 's/lion/tiger/g' story.txt` search and replace every occurence of cat with dog and lion with tiger
    * any number of `-e` option can be used
	* `sed -i 's/cat/dog/g ; s/lion/tiger/g' story.txt` alternative syntax, spacing around ; is optional
* `sed -r 's/(.*)/abc: \1 :xyz/' list.txt` add prefix 'abc: ' and suffix ' :xyz' to every line of list.txt
* `sed -i -r "s/(.*)/$(basename $PWD)\/\1/" dir_list.txt` add current directory name and forward-slash character at the start of every line
    * Note the use of double quotes to perform command substitution
* `sed -i -r "s|.*|$HOME/\0|" dir_list.txt` add home directory and forward-slash at the start of every line
    * Since the value of '$HOME' itself contains forward-slash characters, we cannot use `/` as delimiter
    * Any character other than backslash or newline can be used as delimiter, for example `| # ^` [see this link for more info](https://stackoverflow.com/questions/33914360/what-delimiters-can-you-use-in-sed)
    * `\0` back-reference contains entire matched string

**Further Reading**

* [sed basics](http://code.snipcademy.com/tutorials/shell-scripting/sed/introduction)
* [sed detailed tutorial](http://www.grymoire.com/Unix/Sed.html)
* [sed-book](http://www.catonmat.net/blog/sed-book/)
* [cheat sheet](http://www.catonmat.net/download/sed.stream.editor.cheat.sheet.txt)
* [sed examples](http://how-to.linuxcareer.com/learning-linux-commands-sed)
* [sed one-liners explained](http://www.catonmat.net/series/sed-one-liners-explained)
* [common search and replace examples with sed](https://unix.stackexchange.com/questions/112023/how-can-i-replace-a-string-in-a-files)
* [sed Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/sed?sort=votes&pageSize=15)
* [sed Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/sed?sort=votes&pageSize=15)

<br>
### <a name="awk"></a>awk

>pattern scanning and text processing language

`awk` derives its name from authors Alfred Aho, Peter Weinberger and Brian Kernighan.

**syntax**

* `awk 'BEGIN {initialize} /pattern1/ {stmts} /pattern2/ {stmts}... END {finish}'`
	* `BEGIN {initialize}` used to initialize variables (could be user defined or awk variables or both), executed once - optional block
	* `/pattern1/ {stmts} /pattern2/ {stmts}...` action performed for every line of input, pattern is optional, more than one block {} can be used with/without pattern
	* `END {finish}` perform action once at end of program - optional block
* commands can be written in a file and passed using the `-f` option instead of writing it all on command line
    * for examples and details, refer to links given below

<br>
**Examples**

* `ls -l | awk '{print $1}'` print first column of results of `ls -l` command
    * `$1`, `$2` etc refer to 1st, 2nd field, etc
    * `$0` contains entire line
* `ls -l | awk '{print $1" "$NF}'` print first and last column of results of `ls -l` command separated by space character
    * `$NF` pre-defined variable holds last field
* `ls -l | awk 'NF > 2 {print $1" "$NF}'` print file permission and filename in two columns separated by space, provided a line has more than 2 fields (to exclude the first line of `ls -l` which has only two fields)
* `awk -F":" '{print $1}' /etc/passwd` prints first column of /etc/passwd file
    * `-F` option is used to specify the field separator, by default white-space is separator
* `awk 'BEGIN {FS = ":"} {print $1}' /etc/passwd` prints first column of /etc/passwd file
    * `FS` is field separator variable, by default white-space is separator
* `awk '{print "abc: " $0 " :xyz"}' list.txt` add prefix 'abc: ' and suffix ' :xyz' to every line of list.txt
* `awk '{print FNR ": " $0}' dir_list.txt` prefix line number and ': ' to all lines of file dir_list.txt
    * `FNR` pre-defined variable contains input record number in the current input file
* `ls -l | awk '/^d/ {print $0}'` filter output of `ls -l` for directories
* `awk '{total += $5} END {print total}' table.txt` print sum of all numbers in column 5 of file table.txt
    * by default, initial value of variable is 0, so at start total=0
    * for every line, number in column 5 gets added to total 
    * after processing all the lines, the statement in END block is executed, in this case prints value of total variable

**Further Reading**

* [awk basics](http://code.snipcademy.com/tutorials/shell-scripting/awk/introduction)
* [awk detailed tutorial](http://www.grymoire.com/Unix/Awk.html)
* [basic tutorials for grep, awk, sed](https://unix.stackexchange.com/questions/2434/is-there-a-basic-tutorial-for-grep-awk-and-sed)
* [awk one-liners explained](http://www.catonmat.net/series/awk-one-liners-explained)
* [awk book](http://www.catonmat.net/blog/awk-book/)
* [awk cheat-sheet](http://www.catonmat.net/download/awk.cheat.sheet.txt) for awk variables, statements, functions, etc
* [awk examples](http://www.thegeekstuff.com/tag/unix-awk-examples/)
* [awk Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/awk?sort=votes&pageSize=15)
* [awk Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/awk?sort=votes&pageSize=15)

<br>
### <a name="cut"></a>cut

>remove sections from each line of files

For columns operations with well defined delimiters, `cut` command is handy

**Examples**

* `ls -l | cut -d' ' -f1` first column of `ls -l`
    * `-d` option specifies delimiter character, in this case it is single space character (Default delimiter is TAB character)
    * `-f` option specifies which fields to print separated by commas, in this case field 1
* `cut -d':' -f1 /etc/passwd` prints first column of /etc/passwd file
* `cut -d':' -f1,7 /etc/passwd` prints 1st and 7th column of /etc/passwd file with : character in between
* `cut -d':' --output-delimiter=' ' -f1,7 /etc/passwd` use space as delimiter between 1st and 7th column while printing
* [cut Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/cut?sort=votes&pageSize=15)

<br>
### <a name="paste"></a>paste

>merge lines of files

**Examples**

* `paste list1.txt list2.txt list3.txt > combined_list.txt` combines the three files column-wise into single file, the entries separated by TAB character
* `paste -d':' list1.txt list2.txt list3.txt > combined_list.txt` the entries are separated by : character instead of TAB
* [paste Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/paste?sort=votes&pageSize=15)

<br>
### <a name="column"></a>column

>columnate lists

```
$ cat dishes.txt 
North alootikki baati khichdi makkiroti poha 
South appam bisibelebath dosa koottu sevai 
West dhokla khakhra modak shiro vadapav 
East handoguri litti momo rosgulla shondesh 

$ column -t dishes.txt 
North  alootikki  baati         khichdi  makkiroti  poha
South  appam      bisibelebath  dosa     koottu     sevai
West   dhokla     khakhra       modak    shiro      vadapav
East   handoguri  litti         momo     rosgulla   shondesh
```

* More examples [here](http://www.commandlinefu.com/commands/using/column/sort-by-votes)

<br>
### <a name="pr"></a>pr

>convert text files for printing

```
$ pr sample.txt 


2016-05-29 11:00                    sample.txt                    Page 1


This is an example of adding text to a new file using cat command.
Press Ctrl+c on a newline to save and quit.
Adding a line of text at end of file
```

* Options include converting text files for printing with header, footer, page numbers, double space a file, combine multiple files column wise, etc
* More examples [here](http://docstore.mik.ua/orelly/unix3/upt/ch21_15.htm)
