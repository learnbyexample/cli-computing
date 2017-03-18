# <a name="text-processing"></a>Text Processing

* [sort](#sort)
* [uniq](#uniq)
* [comm](#comm)
* [cmp](#cmp)
* [diff](#diff)
* [tr](#tr)
* [sed](#sed)
* [awk](#awk)
* [perl](#perl)
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
* `-V` version sort, aware of numbers within text
* `-h` sort human readable numbers like 4K, 3M, etc
* `-k` sort via key
* `-u` sort uniquely
* `-b` ignore leading white-spaces of a line while sorting
* `-t` use SEP instead of non-blank to blank transition

**Examples**

* `sort dir_list.txt` display sorted file on standard output
* `sort -bn numbers.txt -o numbers.txt` sort numbers.txt numerically (ignoring leading white-spaces) and overwrite the file with sorted output
* `sort -R crypto_keys.txt -o crypto_keys_random.txt` sort randomly and write to new file
	* `shuf crypto_keys.txt -o crypto_keys_random.txt` can also be used
* `du -sh * | sort -h` sort file/directory sizes in current directory in human readable format

<br>

```bash
$ cat ip.txt 
6.2  : 897 : bar
3.1  : 32  : foo
2.3  : 012 : bar
1.2  : 123 : xyz

$ # -k3,3 means from 3rd column onwards to 3rd column
$ # for ex: to sort from 2nd column till end, use -k2
$ sort -t: -k3,3 ip.txt 
2.3  : 012 : bar
6.2  : 897 : bar
3.1  : 32  : foo
1.2  : 123 : xyz

$ # -n option for numeric sort, check out what happens when -n is not used
$ sort -t: -k2,2n ip.txt 
2.3  : 012 : bar
3.1  : 32  : foo
1.2  : 123 : xyz
6.2  : 897 : bar

$ # more than one rule can be specified to resolve same values
$ sort -t: -k3,3 -k1,1rn ip.txt 
6.2  : 897 : bar
2.3  : 012 : bar
3.1  : 32  : foo
1.2  : 123 : xyz
```

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

```bash
$ echo -e 'Blue\nRed\nGreen\nBlue\nRed\nBlack\nRed' > colors.txt 
$ uniq colors.txt 
Blue
Red
Green
Blue
Red
Black
Red

$ echo -e 'Blue\nRed\nGreen\nBlue\nRed\nBlack\nRed' | sort > sorted_colors.txt 
$ uniq sorted_colors.txt
Black
Blue
Green
Red

$ uniq -d sorted_colors.txt 
Blue
Red

$ uniq -cd sorted_colors.txt 
      2 Blue
      3 Red
      
$ uniq -u sorted_colors.txt 
Black
Green
```

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

```bash
$ echo -e 'Brown\nRed\nPurple\nBlue\nTeal\nYellow' | sort > colors_1.txt 
$ echo -e 'Red\nGreen\nBlue\nBlack\nWhite' | sort > colors_2.txt 

$ # the input files viewed side by side
$ paste colors_1.txt colors_2.txt
Blue    Black
Brown   Blue
Purple  Green
Red     Red
Teal    White
Yellow  
```

* examples

```bash
$ # 3 column output - unique to file1, file2 and common
$ comm colors_1.txt colors_2.txt
        Black
                Blue
Brown
        Green
Purple
                Red
Teal
        White
Yellow 

$ # suppress 1 and 2 column, gives only common lines
$ comm -12 colors_1.txt colors_2.txt
Blue
Red

$ # suppress 1 and 3 column, gives lines unique to file2
$ comm -13 colors_1.txt colors_2.txt
Black
Green
White

$ # suppress 2 and 3 column, gives lines unique to file1
$ comm -23 colors_1.txt colors_2.txt
Brown
Purple
Teal
Yellow
```

<br>

### <a name="cmp"></a>cmp

>compare two files byte by byte

Useful to compare binary files. If the two files are same, no output is displayed (exit status 0)  
If there is a difference, it prints the first difference - line number and byte location (exit status 1)  
Option `-s` allows to suppress the output, useful in scripts

```bash
$ cmp /bin/grep /bin/fgrep
/bin/grep /bin/fgrep differ: byte 25, line 1
```

* More examples [here](http://www.sanfoundry.com/5-cmp-command-usage-examples-linux/)

<br>

### <a name="diff"></a>diff

>compare files line by line

Useful to compare old and new versions of text files  
All the differences are printed, which might not be desirable if files are too long

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
* `diff report/ bkp/mar10/report/ | grep -w '^diff'` useful trick to get only names of mismatching files (provided no mismatches contain the whole word diff at start of line)

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
* `-i` edit files inplace (makes backup if SUFFIX supplied)
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
* `sed '1,/test/d' dir_list.txt` delete all lines from beginning of file to first occurrence of line containing test (the matched line is also deleted)
* `sed '/test/,$d' dir_list.txt` delete all lines from line containing test to end of file

**Examples for selective printing(p)**

* `sed -n '5p' story.txt` print 5th line, `-n` option overrides default print behavior of sed
	* use `sed '5q;d' story.txt` on large files. [Read more](https://stackoverflow.com/questions/191364/quick-unix-command-to-display-specific-lines-in-the-middle-of-a-file/17367226#17367226)
* `sed -n '/cat/p' story.txt` print every line containing the text cat
	* equivalent to `sed '/cat/!d' story.txt`
* `sed -n '4,8!p' story.txt` print all lines except lines 4 to 8
* `man grep | sed -n '/^\s*exit status/I,/^$/p'` extract exit status information of a command from manual
    * `/^\s*exit status/I` checks for line starting with 'exit status' in case insensitive way, white-space may be present at start of line
    * `/^$/` empty line
* `man ls | sed -n '/^\s*-F/,/^$/p'` extract information on command option from manual
    * `/^\s*-F/` line starting with option '-F', white-space may be present at start of line

**Examples for search and replace(s)**

* `sed -i 's/cat/dog/g' story.txt` search and replace every occurrence of cat with dog in story.txt
* `sed -i.bkp 's/cat/dog/g' story.txt` in addition to inplace file editing, create backup file story.txt.bkp, so that if a mistake happens, original file can be restored
    * `sed -i.bkp 's/cat/dog/g' *.txt` to perform operation on all files ending with .txt in current directory
* `sed -i '5,10s/cat/dog/gI' story.txt` search and replace every occurrence of cat (case insensitive due to modifier I) with dog in story.txt only in line numbers 5 to 10
* `sed '/cat/ s/animal/mammal/g' story.txt` replace animal with mammal in all lines containing cat
    * Since `-i` option is not used, output is displayed on standard output and story.txt is not changed
    * spacing between range and command is optional, `sed '/cat/s/animal/mammal/g' story.txt` can also be used
* `sed -i -e 's/cat/dog/g' -e 's/lion/tiger/g' story.txt` search and replace every occurrence of cat with dog and lion with tiger
    * any number of `-e` option can be used
	* `sed -i 's/cat/dog/g ; s/lion/tiger/g' story.txt` alternative syntax, spacing around ; is optional
* `sed -r 's/(.*)/abc: \1 :xyz/' list.txt` add prefix 'abc: ' and suffix ' :xyz' to every line of list.txt
* `sed -i -r "s/(.*)/$(basename $PWD)\/\1/" dir_list.txt` add current directory name and forward-slash character at the start of every line
    * Note the use of double quotes to perform command substitution
* `sed -i -r "s|.*|$HOME/\0|" dir_list.txt` add home directory and forward-slash at the start of every line
    * Since the value of '$HOME' itself contains forward-slash characters, we cannot use `/` as delimiter
    * Any character other than backslash or newline can be used as delimiter, for example `| # ^` [see this link for more info](https://stackoverflow.com/questions/33914360/what-delimiters-can-you-use-in-sed)
    * `\0` back-reference contains entire matched string

<br>

**Example input file**

```bash
$ cat mem_test.txt 
mreg2 = 1200 # starting address
mreg4 = 2180 # ending address

dreg5 = get(mreg2) + get(mreg4)
print dreg5
```

* replace all **reg** with **register**

```bash
$ sed 's/reg/register/g' mem_test.txt 
mregister2 = 1200 # starting address
mregister4 = 2180 # ending address

dregister5 = get(mregister2) + get(mregister4)
print dregister5
```

* change start and end address

```bash
$ sed 's/1200/1530/; s/2180/1870/' mem_test.txt 
mreg2 = 1530 # starting address
mreg4 = 1870 # ending address

dreg5 = get(mreg2) + get(mreg4)
print dreg5

$ # to make changes only on mreg initializations, use
$ # sed '/mreg[0-9] *=/ s/1200/1530/; s/2180/1870/' mem_test.txt
```

* Using `bash` variables

```bash
$ s_add='1760'; e_add='2500'
$ sed "s/1200/$s_add/; s/2180/$e_add/" mem_test.txt 
mreg2 = 1760 # starting address
mreg4 = 2500 # ending address

dreg5 = get(mreg2) + get(mreg4)
print dreg5
```

* split inline commented code to comment + code

```bash
$ sed -E 's/^([^#]+)(#.*)/\2\n\1/' mem_test.txt 
# starting address
mreg2 = 1200 
# ending address
mreg4 = 2180 

dreg5 = get(mreg2) + get(mreg4)
print dreg5
```

* range of lines matching pattern

```bash
$ seq 20 | sed -n '/3/,/5/p'
3
4
5
13
14
15

```

* inplace editing

```bash
$ sed -i -E 's/([md]r)eg/\1/g' mem_test.txt
$ cat mem_test.txt
mr2 = 1200 # starting address
mr4 = 2180 # ending address

dr5 = get(mr2) + get(mr4)
print dr5

$ # more than one input files can be given
$ # use glob pattern if files share commonality, ex: *.txt
```

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

* `awk 'BEGIN {initialize} condition1 {stmts} condition2 {stmts}... END {finish}'`
	* `BEGIN {initialize}` used to initialize variables (could be user defined or awk variables or both), executed once - optional block
	* `condition1 {stmts} condition2 {stmts}...` action performed for every line of input, condition is optional, more than one block {} can be used with/without condition
	* `END {finish}` perform action once at end of program - optional block
* commands can be written in a file and passed using the `-f` option instead of writing it all on command line
    * for examples and details, refer to links given below

<br>

**Example input file**

```bash
$ cat test.txt 
abc  : 123 : xyz
3    : 32  : foo
-2.3 : bar : bar
```

* Just printing something, no input

```bash
$ awk 'BEGIN{print "Hello!\nTesting awk one-liner"}'
Hello!
Testing awk one-liner
```

* search and replace
* when the `{stmts}` portion of `condition {stmts}` is not specified, by default `{print $0}` is executed if the `condition` evaluates to true
    * `1` is a generally used `awk` idiom to print contents of `$0` after performing some processing
    * `print` statement without argument will print the content of `$0`

```bash
$ # sub will replace only first occurrence
$ # third argument to sub specifies variable to change, defaults to $0
$ awk '{sub("3", "%")} 1' test.txt 
abc  : 12% : xyz
%    : 32  : foo
-2.% : bar : bar

$ # gsub will replace all occurrences
$ awk '{gsub("3", "%")} 1' test.txt 
abc  : 12% : xyz
%    : %2  : foo
-2.% : bar : bar

$ # add a condition to restrict processing only to those records
$ awk '/foo/{gsub("3", "%")} 1' test.txt 
abc  : 123 : xyz
%    : %2  : foo
-2.3 : bar : bar

$ # using shell variables
$ r="@"
$ awk -v r_str="$r" '{sub("3", r_str)} 1' test.txt 
abc  : 12@ : xyz
@    : 32  : foo
-2.@ : bar : bar

$ # bash environment variables like PWD, HOME is also accessible via ENVIRON
$ s="%" awk '{sub("3", ENVIRON["s"])} 1' test.txt 
abc  : 12% : xyz
%    : 32  : foo
-2.% : bar : bar
```

* filtering content

```bash
$ # regex pattern, by default tested against $0
$ awk '/a/' test.txt 
abc  : 123 : xyz
-2.3 : bar : bar

$ # use ! to invert condition
$ awk '!/abc/' test.txt 
3    : 32  : foo
-2.3 : bar : bar

$ seq 30 | awk 'END{print}'
30

$ # generic, length(var) - default is $0
$ seq 8 13 | awk 'length==1'
8
9
```

* selecting based on line numbers
* `NR` is record number

```bash
$ seq 123 135 | awk 'NR==7'
129

$ seq 123 135 | awk 'NR>=3 && NR<=5'
125
126
127

$ seq 5 | awk 'NR>=3'
3
4
5

$ # for large input, use exit to avoid unnecessary record processing
$ seq 14323 14563435 | awk 'NR==234{print; exit}'
14556
```

* selecting based on start and end condition
* for following examples
    * numbers 1 to 20 is input
    * regex pattern `/4/` is start condition
    * regex pattern `/6/` is end condition
* `f` is idiomatically used to represent a flag variable

```bash
$ # records between start and end
$ seq 20 | awk '/4/{f=1; next} /6/{f=0} f'
5
15

$ # records between start and end and also includes start
$ seq 20 | awk '/4/{f=1} /6/{f=0} f'
4
5
14
15

$ # records between start and end and also includes end
$ seq 20 | awk '/4/{f=1; next} f; /6/{f=0}'
5
6
15
16

$ # records from start to end
$ seq 20 | awk '/4/{f=1} f{print} /6/{f=0}'
4
5
6
14
15
16

$ # records excluding start to end
$ seq 10 | awk '/4/{f=1} !f; /6/{f=0}'
1
2
3
7
8
9
10
```

* column manipulations
* by default, one or more consecutive spaces/tabs are considered as field separators

```bash
$ echo -e "1 3 4\na b c"
1 3 4
a b c

$ # second column
$ echo -e "1 3 4\na b c" | awk '{print $2}'
3
b

$ # last column
$ echo -e "1 3 4\na b c" | awk '{print $NF}'
4
c

$ # default output field separator is single space character
$ echo -e "1 3 4\na b c" | awk '{print $1, $3}'
1 4
a c

$ # condition for specific field
$ echo -e "1 3 4\na b c" | awk '$2 ~ /[0-9]/'
1 3 4
```

* specifying a different input/output field separator
* can be string alone or regex, multiple separators can be specified using `|` in regex pattern

```bash
$ awk -F' *: *' '$1 == "3"' test.txt 
3    : 32  : foo

$ awk -F' *: *' '{print $1 "," $2}' test.txt 
abc,123
3,32
-2.3,bar

$ awk -F' *: *' -v OFS="::" '{print $1, $2}' test.txt 
abc::123
3::32
-2.3::bar

$ awk -F: -v OFS="\t" '{print $1 OFS $2}' test.txt 
abc  	 123 
3    	 32  
-2.3 	 bar 
```

* dealing with duplicates, line/field wise

```bash
$ cat duplicates.txt 
abc 123 ijk
foo 567 xyz
abc 123 ijk
bar 090 pqr
tst 567 zzz

$ # whole line
$ awk '!seen[$0]++' duplicates.txt 
abc 123 ijk
foo 567 xyz
bar 090 pqr
tst 567 zzz

$ # particular column
$ awk '!seen[$2]++' duplicates.txt 
abc 123 ijk
foo 567 xyz
bar 090 pqr
```

* inplace editing

```bash
$ awk -i inplace '{print NR ") " $0}' test.txt
$ cat test.txt
1) abc  : 123 : xyz
2) 3    : 32  : foo
3) -2.3 : bar : bar
```

**Further Reading**

* [awk basics](http://code.snipcademy.com/tutorials/shell-scripting/awk/introduction)
* [Gawk: Effective AWK Programming](https://www.gnu.org/software/gawk/manual/)
* [awk detailed tutorial](http://www.grymoire.com/Unix/Awk.html)
* [basic tutorials for grep, awk, sed](https://unix.stackexchange.com/questions/2434/is-there-a-basic-tutorial-for-grep-awk-and-sed)
* [awk one-liners explained](http://www.catonmat.net/series/awk-one-liners-explained)
* [awk book](http://www.catonmat.net/blog/awk-book/)
* [awk cheat-sheet](http://www.catonmat.net/download/awk.cheat.sheet.txt) for awk variables, statements, functions, etc
* [awk examples](http://www.thegeekstuff.com/tag/unix-awk-examples/)
* [awk Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/awk?sort=votes&pageSize=15)
* [awk Q&A on stackoverflow](https://stackoverflow.com/questions/tagged/awk?sort=votes&pageSize=15)

<br>

### <a name="perl"></a>perl

>The Perl 5 language interpreter

[Larry Wall](https://en.wikipedia.org/wiki/Larry_Wall) wrote Perl as a **general purpose scripting language**, borrowing features from **C, shell scripting, awk, sed, grep, cut, sort** etc

Reference tables given below for frequently used constructs with **perl one-liners**. Resource links given at end for further reading.

<br>

Descriptions adapted from [perldoc - command switches](http://perldoc.perl.org/perlrun.html#Command-Switches)

| Option | Description |
| ------------- | ----------- |
| -e | execute perl code |
| -n | iterate over input files in a loop, lines are NOT printed by default |
| -p | iterate over input files in a loop, lines are printed by default |
| -l | chomp input line, $\ gets value of $/ if no argument given |
| -a | autosplit input lines on space, implicitly sets -n for Perl version 5.20.0 and above |
| -F | specifies the pattern to split input lines, implicitly sets -a and -n for Perl version 5.20.0 and above |
| -i | edit files inplace, if extension provided make a backup copy |
| -0777 | slurp entire file as single string, not advisable for large input files |

<br>

Descriptions adapted from [perldoc - Special Variables](http://perldoc.perl.org/perlvar.html#SPECIAL-VARIABLES)

| Variable | Description |
| ------------- | ----------- |
| $_ | The default input and pattern-searching space |
| $. | Current line number |
| $/ | input record separator, newline by default |
| $\ | output record separator, empty string by default |
| @F | contains the fields of each line read, applicable with -a or -F option |
| %ENV | contains current environment variables |
| $ARGV | contains the name of the current file |

<br>

| Function | Description |
| ------------- | ----------- |
| length | Returns the length in characters of the value of EXPR. If EXPR is omitted, returns the length of $_ |
| eof | Returns 1 if the next read on FILEHANDLE will return end of file |

<br>

**Simple Perl program**

```bash
$ perl -e 'print "Hello!\nTesting Perl one-liner\n"'
Hello!
Testing Perl one-liner
```

<br>

**Example input file**

```bash
$ cat test.txt 
abc  : 123 : xyz
3    : 32  : foo
-2.3 : bar : bar
```

<br>

* Search and replace

```bash
$ perl -pe 's/3/%/' test.txt
abc  : 12% : xyz
%    : 32  : foo
-2.% : bar : bar

$ # use g flag to replace all occurrences, not just first match in line
$ perl -pe 's/3/%/g' test.txt
abc  : 12% : xyz
%    : %2  : foo
-2.% : bar : bar

$ # conditional replacement
$ perl -pe 's/3/@/g if /foo/' test.txt 
abc  : 123 : xyz
@    : @2  : foo
-2.3 : bar : bar

$ # using shell variables
$ r="@"
$ perl -pe "s/3/$r/" test.txt 
abc  : 12@ : xyz
@    : 32  : foo
-2.@ : bar : bar

$ # preferred approach is to use ENV hash variable
$ export s="%"
$ perl -pe 's/3/$ENV{s}/' test.txt 
abc  : 12% : xyz
%    : 32  : foo
-2.% : bar : bar
```

<br>

* Search and replace special characters

The `\Q` and `q()` constructs are helpful to nullify regex meta characters

```bash
$ # if not properly escaped or quoted, it can lead to errors
$ echo '*.^[}' | perl -pe 's/*.^[}/abc/'
Quantifier follows nothing in regex; marked by <-- HERE in m/* <-- HERE .^[}/ at -e line 1.

$ echo '*.^[}' | perl -pe 's/\*\.\^\[}/abc/'
abc

$ echo '*.^[}' | perl -pe 's/\Q*.^[}/abc/'
abc

$ echo '*.^[}' | perl -pe 's/\Q*.^[}/\$abc\$/'
$abc$

$ echo '*.^[}' | perl -pe 's/\Q*.^[}/q($abc$)/e'
$abc$
```

<br>

* Print lines based on line number or pattern

```bash
$ perl -ne 'print if /a/' test.txt 
abc  : 123 : xyz
-2.3 : bar : bar

$ perl -ne 'print if !/abc/' test.txt 
3    : 32  : foo
-2.3 : bar : bar

$ seq 123 135 | perl -ne 'print if $. == 7'
129

$ seq 1 30 | perl -ne 'print if eof'
30

$ # Use exit to save time on large input files
$ seq 14323 14563435 | perl -ne 'if($. == 234){print; exit}'
14556

$ # length() can also be used instead of length $_
$ seq 8 13 | perl -lne 'print if length $_ == 1'
8
9
```

<br>

* Print range of lines based on line number or pattern

```bash
$ seq 123 135 | perl -ne 'print if $. >= 3 && $. <= 5'
125
126
127

$ # $. is default variable compared against when using ..
$ seq 123 135 | perl -ne 'print if 3..5'
125
126
127

$ # can use many alternatives, eof looks more readable
$ seq 5 | perl -ne 'print if 3..eof'
3
4
5

$ # matching regex specified by /pattern/ is checked against $_
$ seq 5 | perl -ne 'print if 3../4/'
3
4

$ seq 1 30 | perl -ne 'print if /4/../6/'
4
5
6
14
15
16
24
25
26

$ seq 2 8 | perl -ne 'print if !(/4/../6/)'
2
3
7
8
```

<br>

* `..` vs `...`

```bash
$ echo -e '10\n11\n10' | perl -ne 'print if /10/../10/'
10
10

$ echo -e '10\n11\n10' | perl -ne 'print if /10/.../10/'
10
11
10
```

<br>

* Column manipulations

```bash
$ echo -e "1 3 4\na b c" | perl -nale 'print $F[1]'
3
b

$ echo -e "1,3,4,8\na,b,c,d" | perl -F, -lane 'print $F[$#F]'
8
d

$ perl -F: -lane 'print "$F[0] $F[2]"' test.txt 
abc    xyz
3      foo
-2.3   bar

$ perl -F: -lane '$sum+=$F[1]; END{print $sum}' test.txt 
155

$ perl -F: -lane '$F[2] =~ s/\w(?=\w)/$&,/g; print join ":", @F' test.txt 
abc  : 123 : x,y,z
3    : 32  : f,o,o
-2.3 : bar : b,a,r

$ perl -F'/:\s*[a-z]+/i' -lane 'print $F[0]' test.txt 
abc  : 123 
3    : 32  
-2.3 

$ perl -F'\s*:\s*' -lane 'print join ",", grep {/[a-z]/i} @F' test.txt 
abc,xyz
foo
bar,bar

$ perl -F: -ane 'print if (grep {/\d/} @F) < 2' test.txt 
abc  : 123 : xyz
-2.3 : bar : bar
```

<br>

* Dealing with duplicates

```bash
$ cat duplicates.txt 
abc 123 ijk
foo 567 xyz
abc 123 ijk
bar 090 pqr
tst 567 zzz

$ # whole line
$ perl -ne 'print if !$seen{$_}++' duplicates.txt 
abc 123 ijk
foo 567 xyz
bar 090 pqr
tst 567 zzz

$ # particular column
$ perl -ane 'print if !$seen{$F[1]}++' duplicates.txt 
abc 123 ijk
foo 567 xyz
bar 090 pqr
```

<br>

* Multiline processing

```bash
$ # save previous lines to make it easier for multiline matching
$ perl -ne 'print if /3/ && $p =~ /abc/; $p = $_' test.txt 
3    : 32  : foo

$ perl -ne 'print "$p$_" if /3/ && $p =~ /abc/; $p = $_' test.txt 
abc  : 123 : xyz
3    : 32  : foo

$ # with multiline matching, -0777 slurping not advisable for very large files
$ perl -0777 -ne 'print $1 if /.*abc.*\n(.*3.*\n)/' test.txt 
3    : 32  : foo
$ perl -0777 -ne 'print $1 if /(.*abc.*\n.*3.*\n)/' test.txt 
abc  : 123 : xyz
3    : 32  : foo

$ # use s flag to allow .* to match across lines
$ perl -0777 -pe 's/(.*abc.*32)/ABC/s' test.txt 
ABC  : foo
-2.3 : bar : bar

$ # use m flag if ^$ anchors are needed to match individual lines
$ perl -0777 -pe 's/(.*abc.*3)/ABC/s' test.txt 
ABC : bar : bar
$ perl -0777 -pe 's/(.*abc.*^3)/ABC/sm' test.txt 
ABC    : 32  : foo
-2.3 : bar : bar

$ # print multiple lines after matching line
$ perl -ne 'if(/abc/){ print; foreach (1..2){$n = <>; print $n} }' test.txt 
abc  : 123 : xyz
3    : 32  : foo
-2.3 : bar : bar
```

<br>

* Using modules

```bash
$ echo 'a,b,a,c,d,1,d,c,2,3,1,b' | perl -MList::MoreUtils=uniq -F, -lane 'print join ",",uniq(@F)'
a,b,c,d,1,2,3

$ base64 test.txt 
YWJjICA6IDEyMyA6IHh5egozICAgIDogMzIgIDogZm9vCi0yLjMgOiBiYXIgOiBiYXIK
$ base64 test.txt | base64 -d
abc  : 123 : xyz
3    : 32  : foo
-2.3 : bar : bar
$ base64 test.txt | perl -MMIME::Base64 -ne 'print decode_base64($_)' 
abc  : 123 : xyz
3    : 32  : foo
-2.3 : bar : bar

$ perl -MList::MoreUtils=indexes -nale '@i = indexes { /[a-z]/i } @F if $. == 1; print join ",", @F[@i]' test.txt 
abc,xyz
3,foo
-2.3,bar
```

<br>

* In place editing

```bash
$ perl -i -pe 's/\d/*/g' test.txt 
$ cat test.txt 
abc  : *** : xyz
*    : **  : foo
-*.* : bar : bar

$ perl -i.bak -pe 's/\*/^/g' test.txt 
$ cat test.txt 
abc  : ^^^ : xyz
^    : ^^  : foo
-^.^ : bar : bar
$ cat test.txt.bak 
abc  : *** : xyz
*    : **  : foo
-*.* : bar : bar
```

<br>

**Further Reading**

* [Perl Introduction](https://github.com/learnbyexample/Perl_intro) - Introductory course for Perl 5 through examples
* [Perl curated resources](https://github.com/learnbyexample/scripting_course/blob/master/Perl_curated_resources.md)
* [Handy Perl regular expressions](http://www.catonmat.net/blog/perl-one-liners-explained-part-seven/)
* [What does this regex mean?](http://stackoverflow.com/questions/22937618/reference-what-does-this-regex-mean)
* [Perl one-liners](http://www.catonmat.net/series/perl-one-liners-explained) 
* [Perl command line switches](http://perl101.org/command-line-switches.html)
* [Env](http://perldoc.perl.org/Env.html)

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
    * See [pr](#pr) command for multiple character delimiter
* [paste Q&A on unix stackexchange](https://unix.stackexchange.com/questions/tagged/paste?sort=votes&pageSize=15)

```bash
$ # joining multiple files
$ paste -d, <(seq 5) <(seq 6 10)
1,6
2,7
3,8
4,9
5,10

$ paste -d, <(seq 3) <(seq 4 6) <(seq 7 10)
1,4,7
2,5,8
3,6,9
,,10
```

* Single column to multiple columns

```bash
$ seq 5 | paste - -
1	2
3	4
5	

$ # specifying different output delimiter, default is tab
$ seq 5 | paste -d, - -
1,2
3,4
5,

$ # if number of columns to specify is large, use the printf trick
$ seq 5 | paste $(printf -- "- %.s" {1..3})
1	2	3
4	5	
```

* Combine all lines to single line

```bash
$ seq 10 | paste -sd,
1,2,3,4,5,6,7,8,9,10

$ # for multiple character delimiter, perl can be used
$ seq 10 | perl -pe 's/\n/ : / if(!eof)'
1 : 2 : 3 : 4 : 5 : 6 : 7 : 8 : 9 : 10
```

<br>

### <a name="column"></a>column

>columnate lists

```bash
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

```bash
$ pr sample.txt 


2016-05-29 11:00                    sample.txt                    Page 1


This is an example of adding text to a new file using cat command.
Press Ctrl+d on a newline to save and quit.
Adding a line of text at end of file
```

* Options include converting text files for printing with header, footer, page numbers, double space a file, combine multiple files column wise, etc
* More examples [here](http://docstore.mik.ua/orelly/unix3/upt/ch21_15.htm)

```bash
$ # single column to multiple column, split vertically
$ # for example, in command below, output of seq is split into two
$ seq 5 | pr -2t
1				    4
2				    5
3

$ # different output delimiter can be used by passing string to -s option
$ seq 5 | pr -2ts' '
1 4
2 5
3

$ seq 15 | pr -5ts,
1,4,7,10,13
2,5,8,11,14
3,6,9,12,15
```

* Use `-a` option to split across

```bash
$ seq 5 | pr -2ats' : '
1 : 2
3 : 4
5

$ seq 15 | pr -5ats,
1,2,3,4,5
6,7,8,9,10
11,12,13,14,15

$ # use $ to expand characters denoted by escape characters like \t for tab
$ seq 5 | pr -3ts$'\t'
1	3	5
2	4

$ # or leave the argument to -s empty as tab is default
$ seq 5 | pr -3ts
1	3	5
2	4
```

* The default PAGE_WIDTH is 72
* The formula `(col-1)*len(delimiter) + col` seems to work in determining minimum PAGE_WIDTH required for multiple column output
* The `-J` option will help in turning off line truncation

```bash
$ seq 74 | pr -36ats,
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36
37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72
73,74
$ seq 74 | pr -37ats,
pr: page width too narrow

$ # (37-1)*1 + 37 = 73
$ seq 74 | pr -Jw 73 -37ats,
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37
38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74

$ # (3-1)*4 + 3 = 11
$ seq 6 | pr -Jw 10 -3ats'::::'
pr: page width too narrow
$ seq 6 | pr -Jw 11 -3ats'::::'
1::::2::::3
4::::5::::6
```

* Use `-m` option to combine multiple files in parallel

```bash
$ pr -mts', ' <(seq 3) <(seq 4 6) <(seq 7 9)
1, 4, 7
2, 5, 8
3, 6, 9
```

<br>

We can use a combination of different commands for complicated operations. For example, transposing a table

```bash
$ tr ' ' '\n' < dishes.txt | pr -$(wc -l < dishes.txt)t
North               South               West                East
alootikki           appam               dhokla              handoguri
baati               bisibelebath        khakhra             litti
khichdi             dosa                modak               momo
makkiroti           koottu              shiro               rosgulla
poha                sevai               vadapav             shondesh
```

Notice how `pr` neatly arranges the columns. If spacing is too much, we can use `column`

```bash
$ tr ' ' '\n' < dishes.txt | pr -$(wc -l < dishes.txt)ts | column -t
North      South         West     East
alootikki  appam         dhokla   handoguri
baati      bisibelebath  khakhra  litti
khichdi    dosa          modak    momo
makkiroti  koottu        shiro    rosgulla
poha       sevai         vadapav  shondesh
```
