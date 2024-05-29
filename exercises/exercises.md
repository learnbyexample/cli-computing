# Exercises

>![info](../images/info.svg) For solutions, see [exercise-solutions.md](https://github.com/learnbyexample/cli-computing/blob/master/exercises/exercise-solutions.md).

<br>

## Command Line Overview

**1)** By default, is `echo` a shell builtin or external command on your system? What command could you use to get an answer for this question?

**2)** What output do you get for the command shown below? Does the documentation help understand the result?

```bash
$ echo apple     42 'banana     100'
```

**3)** Go through [bash manual: Tilde Expansion](https://www.gnu.org/software/bash/manual/html_node/Tilde-Expansion.html). Is `~/projects` a relative or an absolute path? See [this unix.stackexchange thread](https://unix.stackexchange.com/q/221970/109046) for answers.

**4)** Which key would you use to get help while the `less` command is active?

**5)** How would you bring the 50th line to the top of the screen while viewing a `man` page (assume `less` command is the `pager`)?

**6)** What does the `Ctrl+k` shortcut do?

**7)** Briefly explain the role of the following shell operators:

*a)* `|`  
*b)* `>`  
*c)* `>>`

**8)** The `whatis` command displays one-line descriptions about commands. But it doesn't seem to work for `whatis type`. What should you use instead?

```bash
$ whatis cat
cat (1)              - concatenate files and print on the standard output

$ whatis type
type: nothing appropriate.

# ???
type - Display information about command type.
```

**9)** What is the role of the `/tmp` directory?

**10)** Give an example each for absolute and relative paths.

**11)** When would you use the `man -k` command?

**12)** Are there differences between the `man` and `info` pages?

<br>

## Managing Files and Directories

>![info](../images/info.svg) The `ls.sh` script will be used for some of the exercises.

**1)** Which of these commands will always display the absolute path of the home directory?

*a)* `pwd`  
*b)* `echo "$PWD"`  
*c)* `echo "$HOME"`

**2)** The current working directory has a folder named `-dash`. How would you switch to that directory?

*a)* `cd -- -dash`  
*b)* `cd -dash`  
*c)* `cd ./-dash`  
*d)* `cd \-dash`  
*e)* `cd '-dash'`  
*f)* all of the above  
*g)* only *a)* and *c)*

**3)** Given the directory structure as shown below, how would you change to the `todos` directory?

```bash
# change to the 'scripts' directory and source the 'ls.sh' script
$ source ls.sh

$ ls -F
backups/    hello_world.py*  ip.txt     report.log  todos/
errors.log  hi*              projects/  scripts@
$ cd projects
$ pwd
/home/learnbyexample/cli-computing/example_files/scripts/ls_examples/projects

# ???
$ pwd
/home/learnbyexample/cli-computing/example_files/scripts/ls_examples/todos
```

**4)** As per the scenario shown below, how would you change to the `cli-computing` directory under the user's home directory? And then, how would you go back to the previous working directory?

```bash
$ pwd
/home/learnbyexample/all/projects/square_tictactoe

# ???
$ pwd
/home/learnbyexample/cli-computing

# ???
$ pwd
/home/learnbyexample/all/projects/square_tictactoe
```

**5)** How'd you list the contents of the current directory, one per line, along with the size of the entries in human readable format?

```bash
# change to the 'scripts' directory and source the 'ls.sh' script
$ source ls.sh

# ???
total 7.4M
4.0K backups
 16K errors.log
4.0K hello_world.py
4.0K hi
4.0K ip.txt
4.0K projects
7.4M report.log
   0 scripts
4.0K todos
```

**6)** Which `ls` command option would you use for version based sorting of entries?

**7)** Which `ls` command option would you use for sorting based on entry size?

**8)** Which `ls` command option would you use for sorting based on file extension?

**9)** What does the `-G` option of `ls` command do?

**10)** What does the `-i` option of `ls` command do?

**11)** List only the directories as one entry per line.

```bash
# change to the 'scripts' directory and source the 'ls.sh' script
$ source ls.sh

# ???
backups/
projects/
scripts/
todos/
```

**12)** Assume that a regular file named `notes` already exists. What would happen if you use the `mkdir -p notes` command?

```bash
$ ls -1F notes
notes

# what would happen here?
$ mkdir -p notes
```

**13)** Use one or more commands to match the scenario shown below:

```bash
$ ls -1F
cost.txt

# ???

$ ls -1F
cost.txt
ghost/
quest/
toast/
```

**14)** Use one or more commands to match the scenario shown below:

```bash
# start with an empty directory
$ ls -l
total 0

# ???

$ tree -F
.
├── hobbies/
│   ├── painting/
│   │   └── waterfall.bmp
│   ├── trekking/
│   │   └── himalayas.txt
│   └── writing/
└── shopping/
    └── festival.xlsx

5 directories, 3 files
```

>![info](../images/info.svg) Don't delete this directory, will be needed in a later exercise.

**15)** If directories to create already exist, which `mkdir` command option would you use to not show an error?

**16)** Use one or more commands to match the scenario given below:

```bash
$ ls -1F
cost.txt
ghost/
quest/
toast/

# ???

$ ls -1F
quest/
```

**17)** What does the `-f` option of `rm` command do?

**18)** Which option would you use to interactively delete files using the `rm` command?

**19)** Can the files removed by `rm` easily be restored? Do you need to take some extra steps or use special commands to make the files more difficult to recover?

**20)** Does your Linux distribution provide a tool to send deleted files to the trash (which would help to recover deleted files)?

**21)** Which option would you use to interactively accept/prevent the `cp` command from overwriting a file of the same name? And which option would prevent overwriting without needing manual confirmation?

**22)** Does the `cp` command allow you to rename the file or directory being copied? If so, can you rename multiple files/directories being copied?

**23)** What do the `-u`, `-b` and `-t` options of `cp` command do?

**24)** What's the difference between the two commands shown below?

```bash
$ cp ip.txt op.txt

$ mv ip.txt op.txt
```

**25)** Which option would you use to interactively accept/prevent the `mv` command from overwriting a file of the same name?

**26)** Use one or more commands to match the scenario shown below. You should have already created this directory structure in an earlier exercise.

```bash
$ tree -F
.
├── hobbies/
│   ├── painting/
│   │   └── waterfall.bmp
│   ├── trekking/
│   │   └── himalayas.txt
│   └── writing/
└── shopping/
    └── festival.xlsx

5 directories, 3 files

# ???

$ tree -F
.
├── hobbies/
│   ├── himalayas.txt
│   └── waterfall.bmp
└── shopping/
    └── festival.xlsx

2 directories, 3 files
```

**27)** What does the `-t` option of `mv` command do?

**28)** Determine and implement the `rename` logic based on the filenames and expected output shown below.

```bash
$ touch '(2020) report part 1.txt' 'analysis part 3 (2018).log'
$ ls -1
'(2020) report part 1.txt'
'analysis part 3 (2018).log'

# ???

$ ls -1
2020_report_part_1.txt
analysis_part_3_2018.log
```

**29)** Does the `ln` command follow the same order to specify source and destination as the `cp` and `mv` commands?

**30)** Which `tar` option helps to compress archives based on filename extension? This option can be used instead of `-z` for `gzip`, `-j` for `bzip2` and `-J` for `xz`.

<br>

## Shell Features

>![info](../images/info.svg) Use the `globs.sh` script for wildcards related exercises, unless otherwise mentioned.

>![info](../images/info.svg) Create a temporary directory for exercises that may require you to create some files. You can delete such practice directories afterwards.

**1)** Use the `echo` command to display the text as shown below. Use appropriate quoting as necessary.

```nohighlight
# ???
that's    great! $x = $y + $z
```

**2)** Use the `echo` command to display the values of the three variables in the format as shown below.

```bash
$ n1=10
$ n2=90
$ op=100

# ???
10 + 90 = 100
```

**3)** What will be the output of the command shown below?

```bash
$ echo $'\x22apple\x22: \x2710\x27'
```

**4)** List filenames starting with a digit character.

```bash
# change to the 'scripts' directory and source the 'globs.sh' script
$ source globs.sh

# ???
100.sh  42.txt
```

**5)** List filenames whose extension do not begin with `t` or `l`. Assume extensions will have at least one character.

```bash
# ???
100.sh  calc.py  hello.py  hi.sh  main.c  math.h
```

**6)** List filenames whose extension only have a single character.

```bash
# ???
main.c  math.h
```

**7)** List filenames whose extension is not `txt`.

```bash
# ???
100.sh   hello.py  main.c  report-00.log  report-04.log
calc.py  hi.sh     math.h  report-02.log  report-98.log
```

**8)** Describe the wildcard pattern used in the command shown below.

```bash
$ ls *[^[:word:]]*.*
report-00.log  report-02.log  report-04.log  report-98.log
```

**9)** List filenames having only lowercase alphabets before the extension.

```bash
# ???
calc.py  hello.py  hi.sh  ip.txt  main.c  math.h  notes.txt
```

**10)** List filenames starting with `ma` or `he` or `hi`.

```bash
# ???
hello.py  hi.sh  main.c  math.h
```

**11)** What commands would you use to get the outputs shown below? Assume that you do not know the depth of sub-directories.

```bash
# change to the 'scripts' directory and source the 'ls.sh' script
$ source ls.sh

# filenames ending with '.txt'
# ???
ip.txt  todos/books.txt  todos/outing.txt

# directories starting with 'c' or 'd' or 'g' or 'r' or 't'
# ???
backups/dot_files/
projects/calculator/
projects/tictactoe/
todos/
```

**12)** Create and change to an empty directory. Then, use brace expansion along with relevant commands to get the results shown below.

```bash
# ???
$ ls report*
report_2020.txt  report_2021.txt  report_2022.txt

# use the 'cp' command here
# ???
$ ls report*
report_2020.txt  report_2021.txt  report_2021.txt.bkp  report_2022.txt
```

**13)** What does the `set` builtin command do?

**14)** What does the `|` pipe operator do? And when would you add the `tee` command?

**15)** Can you infer what the following command does? *Hint*: see `help printf`.

```bash
$ printf '%s\n' apple car dragon
apple
car
dragon
```

**16)** Use brace expansion along with relevant commands and shell features to get the result shown below. *Hint*: see previous question.

```bash
$ ls ip.txt
ls: cannot access 'ip.txt': No such file or directory

# ???
$ cat ip.txt
item_10
item_12
item_14
item_16
item_18
item_20
```

**17)** With `ip.txt` containing text as shown in the previous question, use brace expansion and relevant commands to get the result shown below.

```bash
# ???
$ cat ip.txt
item_10
item_12
item_14
item_16
item_18
item_20
apple_1_banana_6
apple_1_banana_7
apple_1_banana_8
apple_2_banana_6
apple_2_banana_7
apple_2_banana_8
apple_3_banana_6
apple_3_banana_7
apple_3_banana_8
```

**18)** What are the differences between `<` and `|` shell operators, if any?

**19)** Which character is typically used to represent `stdin` data as a file argument?

**20)** What do the following operators do?

*a)* `1>`  
*b)* `2>`  
*c)* `&>`  
*d)* `&>>`  
*e)* `|&`

**21)** What will be the contents of `op.txt` if you use the following `grep` command?

```bash
# press Ctrl+d after the line containing 'histogram'
$ grep 'hi' > op.txt
hi there
this is a sample line
have a nice day
histogram

$ cat op.txt
```

**22)** What will be the contents of `op.txt` if you use the following commands?

```bash
$ qty=42
$ cat << end > op.txt
> dragon
> unicorn
> apple $qty
> ice cream
> end

$ cat op.txt
```

**23)** Correct the command to get the expected output shown below.

```bash
$ books='cradle piranesi soulhome bastion'

# something is wrong with this command
$ sed 's/\b\w/\u&/g' <<< '$books'
$Books

# ???
Cradle Piranesi Soulhome Bastion
```

**24)** Correct the command to get the expected output shown below.

```bash
# something is wrong with this command
$ echo 'hello' ; seq 3 > op.txt
hello
$ cat op.txt
1
2
3

# ???
$ cat op.txt
hello
1
2
3
```

**25)** What will be the output of the following commands?

```bash
$ printf 'hello' | tr 'a-z' 'A-Z' && echo ' there'

$ printf 'hello' | tr 'a-z' 'A-Z' || echo ' there'
```

**26)** Correct the command(s) to get the expected output shown below.

```bash
# something is wrong with these commands
$ nums=$(seq 3)
$ echo $nums
1 2 3

# ???
1
2
3
```

**27)** Will the following two commands produce equivalent output? If not, why not?

```bash
$ paste -d, <(seq 3) <(printf '%s\n' item_{1..3})

$ printf '%s\n' {1..3},item_{1..3}
```

<br>

## Viewing Part or Whole File Contents

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises.

**1)** Which option(s) would you use to get the output shown below?

```bash
$ printf '\n\n\ndragon\n\n\nunicorn\n\n\n' | cat # ???

     1  dragon

     2  unicorn

```

**2)** Pass appropriate arguments to the `cat` command to get the output shown below.

```bash
$ cat greeting.txt
Hi there
Have a nice day

$ echo '42 apples and 100 bananas' | cat # ???
42 apples and 100 bananas
Hi there
Have a nice day
```

**3)** Will the two commands shown below produce the same output? If not, why not?

```bash
$ cat fruits.txt ip.txt | tac

$ tac fruits.txt ip.txt 
```

**4)** Go through the manual for the `tac` command and use appropriate options and arguments to get the output shown below.

```bash
$ cat blocks.txt
%=%=
apple
banana
%=%=
brown
green

# ???
%=%=
brown
green
%=%=
apple
banana
```

**5)** What is the difference between `less -n` and `less -N` options? Does `cat -n` and `less -n` have similar functionality?

**6)** Which command would you use to open another file from within an existing `less` session? And which commands would you use to navigate between previous and next files?

**7)** Use appropriate commands and shell features to get the output shown below.

```bash
$ printf 'carpet\njeep\nbus\n'
carpet
jeep
bus

# use the above 'printf' command for input data
$ c=# ???
$ echo "$c"
car
```

**8)** How would you display all the input lines except the first one?

```bash
$ printf 'apple\nfig\ncarpet\njeep\nbus\n' | # ???
fig
carpet
jeep
bus
```

**9)** Which command(s) would you use to get the output shown below?

```bash
$ cat fruits.txt
banana
papaya
mango
$ cat blocks.txt
%=%=
apple
banana
%=%=
brown
green

# ???
banana
papaya
%=%=
apple
```

**10)** Use a combination of the `head` and `tail` commands to get the 11th to 14th characters from the given input.

```bash
$ printf 'apple\nfig\ncarpet\njeep\nbus\n' | # ???
carp
```

**11)** Extract the starting six bytes from the input files `table.txt` and `fruits.txt`.

```bash
# ???
brown banana
```

**12)** Extract the last six bytes from the input files `fruits.txt` and `table.txt`.

```bash
# ???
mango
 3.14
```

<br>

## Searching Files and Filenames

>![info](../images/info.svg) For `grep` exercises, use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files, unless otherwise specified.

>![info](../images/info.svg) For `find` exercises, use the `find.sh` script, unless otherwise specified.

**1)** Display lines containing `an` from the input files `blocks.txt`, `ip.txt` and `uniform.txt`. Show the results with and without filename prefix.

```bash
# ???
blocks.txt:banana
ip.txt:light orange
uniform.txt:mango

# ???
banana
light orange
mango
```

**2)** Display lines containing the whole word `he` from the `sample.txt` input file.

```bash
# ???
14) He he he
```

**3)** Match only whole lines containing `car` irrespective of case. The matching lines should be displayed with line number prefix as well.

```bash
$ printf 'car\nscared\ntar car par\nCar\n' | grep # ???
1:car
4:Car
```

**4)** Display all lines from `purchases.txt` except those that contain `tea`.

```bash
# ???
coffee
washing powder
coffee
toothpaste
soap
```

**5)** Display all lines from `sample.txt` that contain `do` but not `it`.

```bash
# ???
13) Much ado about nothing
```

**6)** For the input file `sample.txt`, filter lines containing `do` and also display the line that comes after such a matching line.

```bash
# ???
 6) Just do-it
 7) Believe it
--
13) Much ado about nothing
14) He he he
```

**7)** For the input file `sample.txt`, filter lines containing `are` or `he` as whole words as well as the line that comes before such a matching line. Go through `info grep` or the [online manual](https://www.gnu.org/software/grep/manual/grep.html) and use appropriate options such that there's no separator between the groups of matching lines in the output.

```bash
# ???
 3) Hi there
 4) How are you
13) Much ado about nothing
14) He he he
```

**8)** Extract all pairs of `()` with/without text inside them, provided they do not contain `()` characters inside.

```bash
$ echo 'I got (12) apples' | grep # ???
(12)

$ echo '((2 +3)*5)=25 and (4.3/2*()' | grep # ???
(2 +3)
()
```

**9)** For the given input, match all lines that start with `den` or end with `ly`.

```bash
$ lines='reply\n1 dentist\n2 lonely\neden\nfly away\ndent\n'

$ printf '%b' "$lines" | grep # ???
reply
2 lonely
dent
```

**10)** Extract words starting with `s` and containing both `e` and `t` in any order.

```bash
$ words='sequoia subtle exhibit sets tests sit store_2'

$ echo "$words" | grep # ???
subtle
sets
store_2
```

**11)** Extract all whole words having the same first and last word character.

```bash
$ echo 'oreo not a _oh_ pip RoaR took 22 Pop' | grep # ???
oreo
a
_oh_
pip
RoaR
22
```

**12)** Match all input lines containing `*[5]` literally.

```bash
$ printf '4*5]\n(9-2)*[5]\n[5]*3\nr*[5\n' | grep # ???
(9-2)*[5]
```

**13)** Match whole lines that start with `hand` and immediately followed by `s` or `y` or `le` or no further character.

```bash
$ lines='handed\nhand\nhandy\nunhand\nhands\nhandle\nhandss\n'

$ printf '%b' "$lines" | grep # ???
hand
handy
hands
handle
```

**14)** Input lines have three or more fields separated by a `,` delimiter. Extract from the second field to the second last field. In other words, extract fields other than the first and last.

```bash
$ printf 'apple,fig,cherry\ncat,dog,bat\n' | grep # ???
fig
dog

$ echo 'dragon,42,unicorn,3.14,shapeshifter\n' | grep # ???
42,unicorn,3.14
```

**15)** Recursively search for files containing `ello`.

```bash
# change to the 'scripts' directory and source the 'grep.sh' script
$ source grep.sh

# ???
projects/python/hello.py
projects/shell/hello.sh
colors_1
colors_2
```

**16)** Search for files containing `blue` recursively, but do not search within the `backups` directory.

```bash
# change to the 'scripts' directory and source the 'grep.sh' script
$ source grep.sh

# ???
.hidden
colors_1
colors_2
```

**17)** Search for files containing `blue` recursively, but not if the file also contains `teal`.

```bash
# change to the 'scripts' directory and source the 'grep.sh' script
$ source grep.sh

# ???
.hidden
colors_2
backups/color list.txt
```

**18)** Find all regular files within the `backups` directory.

```bash
# change to the 'scripts' directory and source the 'find.sh' script
$ source find.sh

# ???
backups/dot_files/.bashrc
backups/dot_files/.inputrc
backups/dot_files/.vimrc
backups/aug.log
backups/bookmarks.html
backups/jan.log
```

**19)** Find all regular files whose extension starts with `p` or `s` or `v`.

```bash
# ???
./projects/tictactoe/game.py
./projects/calculator/calc.sh
./hi.sh
./backups/dot_files/.vimrc
./hello_world.py
```

**20)** Find all regular files whose name do *not* have the lowercase letters `g` to `l`.

```bash
# ???
./todos/TRIP.txt
./todos/wow.txt
```

**21)** Find all regular files whose path has at least one directory name starting with `p` or `d`.

```bash
# ???
./projects/tictactoe/game.py
./projects/calculator/calc.sh
./backups/dot_files/.bashrc
./backups/dot_files/.inputrc
./backups/dot_files/.vimrc
```

**22)** Find all directories whose name contains `b` or `d`.

```bash
# ???
./todos
./backups
./backups/dot_files
```

**23)** Find all hidden directories.

```bash
# ???
./projects/.venv
```

**24)** Find all regular files at the exact depth of `2`.

```bash
# ???
./todos/books.txt
./todos/TRIP.txt
./todos/wow.txt
./backups/aug.log
./backups/bookmarks.html
./backups/jan.log
```

**25)** What's the difference between `find -mtime` and `find -atime`? And, what is the time period these options work with?

**26)** Find all empty regular files.

```bash
# ???
./projects/tictactoe/game.py
./projects/calculator/calc.sh
./todos/books.txt
./todos/TRIP.txt
./todos/wow.txt
./backups/dot_files/.bashrc
./backups/dot_files/.inputrc
./backups/dot_files/.vimrc
./backups/aug.log
./backups/bookmarks.html
./backups/jan.log
```

**27)** Create a directory named `filtered_files`. Then, copy all regular files that are greater than `1` byte in size but whose name don't end with `.log` to this directory.

```bash
# ???
$ ls -A filtered_files
hello_world.py  .hidden  hi.sh  ip.txt
```

**28)** Find all hidden files, but not if they are part of the `filtered_files` directory created earlier.

```bash
# ???
./.hidden
./backups/dot_files/.bashrc
./backups/dot_files/.inputrc
./backups/dot_files/.vimrc
```

**29)** Delete the `filtered_files` directory created earlier. Then, go through the `find` manual and figure out how to list only executable files.

```bash
# ???
./hi.sh
./hello_world.py
```

**30)** List at least one use case for piping the `find` output to the `xargs` command instead of using the `find -exec` option.

**31)** How does the `locate` command work faster than the equivalent `find` command?

<br>

## File Properties

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises, unless otherwise specified.

>![info](../images/info.svg) Create a temporary directory for exercises that may require you to create some files and directories. You can delete such practice directories afterwards.

**1)** Save the number of lines in the `greeting.txt` input file to the `lines` shell variable.

```bash
# ???
$ echo "$lines"
2
```

**2)** What do you think will be the output of the following command?

```bash
$ echo 'dragons:2 ; unicorns:10' | wc -w
```

**3)** Use appropriate options and arguments to get the output shown below.

```bash
$ printf 'apple\nbanana\ncherry' | wc # ???
     15     183 sample.txt
      2      19 -
     17     202 total
```

**4)** Go through the `wc` manual and use appropriate options and arguments to get the output shown below.

```bash
$ printf 'greeting.txt\0scores.csv' | wc # ???
2 6 25 greeting.txt
4 4 70 scores.csv
6 10 95 total
```

**5)** What is the difference between the `wc -c` and `wc -m` options? And which option would you use to get the longest line length?

**6)** Find filenames ending with `.log` and report their sizes in human readable format. Use the `find+du` combination for the first case and the `ls` command (with appropriate shell features) for the second case.

```bash
# change to the 'scripts' directory and source the 'du.sh' script
$ source du.sh

# ??? find+du
16K     ./projects/errors.log
7.4M    ./report.log

# ??? ls and shell features
 16K projects/errors.log
7.4M report.log
```

**7)** Report sizes of files/directories in the current path in powers of `1000` without descending into sub-directories. Also, show a total at the end.

```bash
# change to the 'scripts' directory and source the 'du.sh' script
$ source du.sh

# ???
50k     projects
7.7M    report.log
8.2k    todos
7.8M    total
```

**8)** What does the `du --apparent-size` option do?

**9)** When will you use the `df` command instead of `du`? Which `df` command option will help you to report only the specific fields of interest?

**10)** Display the size of `scores.csv` and `timings.txt` files in the format shown below.

```bash
$ stat # ???
scores.csv: 70
timings.txt: 49
```

**11)** Which `touch` option will help you prevent file creation if it doesn't exist yet?

**12)** Assume `new_file.txt` doesn't exist in the current working directory. What would be the output of the `stat` command shown below?

```bash
$ touch -t '202010052010.05' new_file.txt
$ stat -c '%y' new_file.txt
# ???
```

**13)** Is the following `touch` command valid? If so, what would be the output of the `stat` command that follows?

```bash
# change to the 'scripts' directory and source the 'touch.sh' script
$ source touch.sh

$ stat -c '%n: %y' fruits.txt
fruits.txt: 2017-07-13 13:54:03.576055933 +0530

$ touch -r fruits.txt f{1..3}.txt
$ stat -c '%n: %y' f*.txt
# ???
```

**14)** Use appropriate option(s) to get the output shown below.

```bash
$ printf 'αλεπού\n' | file -
/dev/stdin: UTF-8 Unicode text

$ printf 'αλεπού\n' | file # ???
UTF-8 Unicode text
```

**15)** Is the following command valid? If so, what would be the output?

```bash
$ basename -s.txt ~///test.txt///
# ???
```

**16)** Given the file path in the shell variable `p`, how'd you obtain the output shown below?

```bash
$ p='~/projects/square_tictactoe/python/game.py'
$ dirname # ???
~/projects/square_tictactoe
```

**17)** Explain what each of the characters mean in the following `stat` command's output.

```bash
$ stat -c '%A' ../scripts/
drwxrwxr-x
```

**18)** What would be the output of the second `stat` command shown below?

```bash
$ touch new_file.txt
$ stat -c '%a %A' new_file.txt
664 -rw-rw-r--

$ chmod 546 new_file.txt
$ stat -c '%a %A' new_file.txt
# ???
```

**19)** How would you specify directory permissions using the `mkdir` command?

```bash
# instead of this
$ mkdir back_up
$ chmod 750 back_up
$ stat -c '%a %A' back_up
750 drwxr-x---
$ rm -r back_up

# do this
$ mkdir # ???
$ stat -c '%a %A' back_up
750 drwxr-x---
```

**20)** Change the file permission of `book_list.txt` to match the output of the second `stat` command shown below. Don't use the number `220`, specify the changes in terms of `rwx` characters.

```bash
$ touch book_list.txt
$ stat -c '%a %A' book_list.txt
664 -rw-rw-r--

# ???
$ stat -c '%a %A' book_list.txt
220 --w--w----
```

**21)** Change the permissions of `test_dir` to match the output of the second `stat` command shown below. Don't use the number `757`, specify the changes in terms of `rwx` characters.

```bash
$ mkdir test_dir
$ stat -c '%a %A' test_dir
775 drwxrwxr-x

# ???
$ stat -c '%a %A' test_dir
757 drwxr-xrwx
```

<br>

## Managing Processes

**1)** How would you invoke a command to be executed in the background? And what would you do to push a job to the background after it has already been launched? What commands can you use to track active jobs?

**2)** What do the `+` and `-` symbols next to job numbers indicate?

**3)** When would you use `fg %n` and `bg %n` instead of just `fg` and `bg` respectively?

**4)** Which option will help you customize the output fields needed for the `ps` command?

**5)** What's the difference between `pgrep -a` and `pgrep -l` options?

**6)** If the job number is `2`, would you use `kill %2` or `kill 2` to send `SIGTERM` to that process?

**7)** Which signal does the `Ctrl+c` shortcut send to the currently running process?

**8)** Which command helps you to continuously monitor processes, along with details like PID, memory usage, etc?

**9)** Which key will help you manipulate kill tasks from within the `top` session?

**10)** What does the `free` command do?

<br>

## Multipurpose Text Processing Tools

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises.

**1)** Replace all occurrences of `0xA0` with `0x50` and `0xFF` with `0x7F` for the given input.

```bash
$ printf 'a1:0xA0, a2:0xA0A1\nb1:0xFF, b2:0xBE\n'
a1:0xA0, a2:0xA0A1
b1:0xFF, b2:0xBE

$ printf 'a1:0xA0, a2:0xA0A1\nb1:0xFF, b2:0xBE\n' | sed # ???
a1:0x50, a2:0x50A1
b1:0x7F, b2:0xBE
```

**2)** Remove only the third line from the given input.

```bash
$ seq 34 37 | # ???
34
35
37
```

**3)** For the input file `sample.txt`, display all lines that contain `it` but not `do`.

```bash
# ???
 7) Believe it
```

**4)** For the input file `purchases.txt`, delete all lines containing `tea`. Also, replace all occurrences of `coffee` with `milk`. Write back the changes to the input file itself. The original contents should get saved to `purchases.txt.orig`. Afterwards, restore the contents from this backup file.

```bash
# make the changes
# ???
$ ls purchases*
purchases.txt  purchases.txt.orig
$ cat purchases.txt
milk
washing powder
milk
toothpaste
soap

# restore the contents
# ???
$ ls purchases*
purchases.txt
$ cat purchases.txt
coffee
tea
washing powder
coffee
toothpaste
tea
soap
tea
```

**5)** For the input file `sample.txt`, display all lines from the start of the file till the first occurrence of `are`.

```bash
# ???
 1) Hello World
 2) 
 3) Hi there
 4) How are you
```

**6)** Delete all groups of lines from a line containing `start` to a line containing `end` for the `uniform.txt` input file.

```bash
# ???
mango
icecream
how are you
have a nice day
par,far,mar,tar
```

**7)** Replace all occurrences of `42` with `[42]` unless it is at the edge of a word.

```bash
$ echo 'hi42bye nice421423 bad42 cool_4242a 42c' | sed # ???
hi[42]bye nice[42]1[42]3 bad42 cool_[42][42]a 42c
```

**8)** Replace all whole words with `X` that start and end with the same word character.

```bash
$ echo 'oreo not a _oh_ pip RoaR took 22 Pop' | sed # ???
X not X X X X took X Pop
```

**9)** For the input file `anchors.txt`, convert markdown anchors to hyperlinks as shown below.

```bash
$ cat anchors.txt
# <a name="regular-expressions"></a>Regular Expressions
## <a name="subexpression-calls"></a>Subexpression calls
## <a name="the-dot-meta-character"></a>The dot meta character

$ sed # ???
[Regular Expressions](#regular-expressions)
[Subexpression calls](#subexpression-calls)
[The dot meta character](#the-dot-meta-character)
```

**10)** Replace all occurrences of `e` with `3` except the first two matches.

```bash
$ echo 'asset sets tests site' | sed # ???
asset sets t3sts sit3

$ echo 'sample item teem eel' | sed # ???
sample item t33m 33l
```

**11)** The below sample strings use `,` as the delimiter and the field values can be empty as well. Use `sed` to replace only the third field with `42`.

```bash
$ echo 'lion,,ant,road,neon' | sed # ???
lion,,42,road,neon

$ echo ',,,' | sed # ???
,,42,
```

**12)** For the input file `table.txt`, calculate and display the product of numbers in the last field of each line. Consider space as the field separator for this file.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

# ???
-923.16
```

**13)** Extract the contents between `()` or `)(` from each of the input lines. Assume that the `()` characters will be present only once every line.

```bash
$ printf 'apple(ice)pie\n(almond)pista\nyo)yoyo(yo\n'
apple(ice)pie
(almond)pista
yo)yoyo(yo

$ printf 'apple(ice)pie\n(almond)pista\nyo)yoyo(yo\n' | awk # ???
ice
almond
yoyo
```

**14)** For the input file `scores.csv`, display the `Name` and `Physics` fields in the format shown below.

```bash
$ cat scores.csv
Name,Maths,Physics,Chemistry
Ith,100,100,100
Cy,97,98,95
Lin,78,83,80

# ???
Name:Physics
Ith:100
Cy:98
Lin:83
```

**15)** Extract and display the third and first words in the format shown below.

```bash
$ echo '%whole(Hello)--{doubt}==ado==' | # ???
doubt:whole

$ echo 'just,\joint*,concession_42<=nice' | # ???
concession_42:just
```

**16)** For the input file `scores.csv`, add another column named **GP** which is calculated out of 100 by giving 50% weightage to Maths and 25% each for Physics and Chemistry.

```bash
$ awk # ???
Name,Maths,Physics,Chemistry,GP
Ith,100,100,100,100
Cy,97,98,95,96.75
Lin,78,83,80,79.75
```

**17)** From the `para.txt` input file, display all paragraphs containing any digit character.

```bash
$ cat para.txt
hi there
how are you

2 apples
12 bananas


blue sky
yellow sun
brown earth

$ awk # ???
2 apples
12 bananas
```

**18)** Input has the ASCII NUL character as the record separator. Change it to dot and newline characters as shown below.

```bash
$ printf 'apple\npie\0banana\ncherry\0' | awk # ???
apple
pie.
banana
cherry.
```

**19)** For the input file `sample.txt`, print a matching line containing `do` only if `you` is found two lines before. For example, if `do` is found on line number 10 and the 8th line contains `you`, then the 10th line should be printed.

```bash
# ???
 6) Just do-it
```

**20)** For the input file `blocks.txt`, extract contents from a line containing exactly `%=%=` until but not including the next such line. The block to be extracted is indicated by the variable `n` passed via the `-v` option.

```bash
$ cat blocks.txt
%=%=
apple
banana
%=%=
brown
green

$ awk -v n=1 # ???
%=%=
apple
banana
$ awk -v n=2 # ???
%=%=
brown
green
```

**21)** Display lines present in `c1.txt` but not in `c2.txt` using the `awk` command.

```bash
$ awk # ???
Brown
Purple
Teal
```

**22)** Display lines from `scores.csv` by matching the first field based on a list of names from the `names.txt` file.

```bash
$ printf 'Ith\nLin\n' > names.txt

$ awk # ???
Ith,100,100,100
Lin,78,83,80

$ rm names.txt
```

**23)** Retain only the first copy of duplicate lines from the `duplicates.txt` input file. Use only the contents of the last field for determining duplicates.

```bash
$ cat duplicates.txt
brown,toy,bread,42
dark red,ruby,rose,111
blue,ruby,water,333
dark red,sky,rose,555
yellow,toy,flower,333
white,sky,bread,111
light red,purse,rose,333

# ???
brown,toy,bread,42
dark red,ruby,rose,111
blue,ruby,water,333
dark red,sky,rose,555
```

**24)** For the input file `table.txt`, print input lines if the second field starts with `b`. Construct solutions using `awk` and `perl`.

```bash
$ awk # ???
brown bread mat hair 42
yellow banana window shoes 3.14

$ perl # ???
brown bread mat hair 42
yellow banana window shoes 3.14
```

**25)** For the input file `table.txt`, retain only the second last field. Write back the changes to the input file itself. The original contents should get saved to `table.txt.bkp`. Afterwards, restore the contents from this backup file.

```bash
# make the changes
$ perl # ???
$ ls table*
table.txt  table.txt.bkp
$ cat table.txt
hair
shirt
shoes

# restore the contents
# ???
$ ls table*
table.txt
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14
```

**26)** Reverse the first field contents of `table.txt` input file.

```bash
# ???
nworb bread mat hair 42
eulb cake mug shirt -7
wolley banana window shoes 3.14
```

**27)** Sort the given comma separated input lexicographically. Change the output field separator to a `:` character.

```bash
$ ip='floor,bat,to,dubious,four'
$ echo "$ip" | perl # ???
bat:dubious:floor:four:to
```

**28)** Filter fields containing digit characters.

```bash
$ ip='5pearl 42 east 1337 raku_6 lion 3.14'
$ echo "$ip" | perl # ???
5pearl 42 1337 raku_6 3.14
```

**29)** The input shown below has several words ending with digit characters. Change the words containing `test` to match the output shown below. That is, renumber the matching portions to `1`, `2`, etc. Words not containing `test` should not be changed.

```bash
$ ip='test_12:test123\nanother_test_4,no_42\n'
$ printf '%b' "$ip"
test_12:test123
another_test_4,no_42

$ printf '%b' "$ip" | perl # ???
test_1:test2
another_test_3,no_42
```

**30)** For the input file `table.txt`, change contents of the third field to all uppercase. Construct solutions using `sed`, `awk` and `perl`.

```bash
$ sed # ???
brown bread MAT hair 42
blue cake MUG shirt -7
yellow banana WINDOW shoes 3.14

$ awk # ???
brown bread MAT hair 42
blue cake MUG shirt -7
yellow banana WINDOW shoes 3.14

$ perl # ???
brown bread MAT hair 42
blue cake MUG shirt -7
yellow banana WINDOW shoes 3.14
```

<br>

## Sorting Stuff

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises.

**1)** Default `sort` doesn't work for numbers. Correct the command used below:

```bash
# wrong output
$ printf '100\n10\n20\n3000\n2.45\n' | sort
10
100
20
2.45
3000

# expected output
$ printf '100\n10\n20\n3000\n2.45\n' | sort # ???
2.45
10
20
100
3000
```

**2)** Which `sort` option will help you ignore case?

```bash
$ printf 'Super\nover\nRUNE\ntea\n' | LC_ALL=C sort # ???
over
RUNE
Super
tea
```

**3)** Go through the `sort` manual and use appropriate options to get the output shown below.

```bash
# wrong output
$ printf '+120\n-1.53\n3.14e+4\n42.1e-2' | sort -n
-1.53
+120
3.14e+4
42.1e-2

# expected output
$ printf '+120\n-1.53\n3.14e+4\n42.1e-2' | sort # ???
-1.53
42.1e-2
+120
3.14e+4
```

**4)** Sort the `scores.csv` file numerically in ascending order using the contents of the second field. Header line should be preserved as the first line as shown below. *Hint*: see the [Shell Features](./shell-features.md) chapter.

```bash
# ???
Name,Maths,Physics,Chemistry
Lin,78,83,80
Cy,97,98,95
Ith,100,100,100
```

**5)** Sort the contents of `duplicates.txt` by the fourth column numbers in descending order. Retain only the first copy of lines with the same number.

```bash
# ???
dark red,sky,rose,555
blue,ruby,water,333
dark red,ruby,rose,111
brown,toy,bread,42
```

**6)** Will `uniq` throw an error if the input is not sorted? What do you think will be the output for the following input?

```bash
$ printf 'red\nred\nred\ngreen\nred\nblue\nblue' | uniq
# ???
```

**7)** Retain only the unique entries based on the first two characters of the input lines. Sort the input if necessary.

```bash
$ printf '3) cherry\n1) apple\n2) banana\n1) almond\n'
3) cherry
1) apple
2) banana
1) almond

$ printf '3) cherry\n1) apple\n2) banana\n1) almond\n' | # ???
2) banana
3) cherry
```

**8)** Count the number of times input lines are repeated and display the results in the format shown below.

```bash
$ printf 'brown\nbrown\nbrown\ngreen\nbrown\nblue\nblue' | # ???
      1 green
      2 blue
      4 brown
```

**9)** Display lines present in `c1.txt` but not in `c2.txt` using the `comm` command. Assume that the input files are already sorted.

```bash
# ???
Brown
Purple
Teal
```

**10)** Use appropriate options to get the expected output shown below.

```bash
# wrong usage, no output
$ join <(printf 'apple 2\nfig 5') <(printf 'Fig 10\nmango 4')

# expected output
# ???
fig 5 10
```

**11)** What are the differences between `sort -u` and `uniq -u` options, if any?

<br>

## Comparing Files

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises.

**1)** Which `cmp` option would you use if you just need the exit status reflecting whether the given inputs are same or not?

**2)** Which `cmp` option would you use to skip the initial bytes for comparison purposes? The below example requires you to skip the first two bytes.

```bash
$ echo '1) apple' > x1.txt
$ echo '2. apple' > x2.txt
$ cmp x1.txt x2.txt
x1.txt x2.txt differ: byte 1, line 1

$ cmp # ???
$ echo $?
0

$ rm x[12].txt
```

**3)** What does the `diff -d` option do?

**4)** Which option will help you get colored output with `diff`?

**5)** Use appropriate options to get the desired output shown below.

```bash
# instead of this output
$ diff -W 40 --suppress-common-lines -y f1.txt f2.txt
2                  |    hello
world              |    4

# get this output
$ diff # ???
1                  (
2                  |    hello
3                  (
world              |    4
```

**6)** Use appropriate options to get the desired output shown below.

```bash
$ echo 'hello' > d1.txt
$ echo 'Hello' > d2.txt

# instead of this output
$ diff d1.txt d2.txt
1c1
< hello
---
> Hello

# get this output
$ diff # ???
Files d1.txt and d2.txt are identical

$ rm d[12].txt
```

<br>

## Assorted Text Processing Tools

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises.

**1)** Generate the following sequence.

```bash
# ???
100
95
90
85
80
```

**2)** Is the sequence shown below possible to generate with `seq`? If so, how?

```bash
# ???
01.5,02.5,03.5,04.5,05.5
```

**3)** Display three random words from `/usr/share/dict/words` (or an equivalent dictionary word file) containing `s` and `e` and `t` in any order. The output shown below is just an example.

```bash
# ???
supplemental
foresight
underestimates
```

**4)** Briefly describe the purpose of the `shuf` command options `-i`, `-e` and `-r`.

**5)** Why does the below command not work as expected? What other tools can you use in such cases?

```bash
# not working as expected
$ echo 'apple,banana,cherry,dates' | cut -d, -f3,1,3
apple,cherry

# expected output
# ???
cherry,apple,cherry
```

**6)** Display except the second field in the format shown below. Can you construct two different solutions?

```bash
$ echo 'apple,banana,cherry,dates' | cut # ???
apple cherry dates

$ echo '2,3,4,5,6,7,8' | cut # ???
2 4 5 6 7 8
```

**7)** Extract the first three characters from the input lines as shown below. Can you also use the `head` command for this purpose? If not, why not?

```bash
$ printf 'apple\nbanana\ncherry\ndates\n' | cut # ???
app
ban
che
dat
```

**8)** Display only the first and third columns of the `scores.csv` input file in the format as shown below. Note that only space characters are present between the two columns, not tab.

```bash
$ cat scores.csv
Name,Maths,Physics,Chemistry
Ith,100,100,100
Cy,97,98,95
Lin,78,83,80

# ???
Name  Physics
Ith   100
Cy    98
Lin   83
```

**9)** Display the contents of `table.txt` in the format shown below.

```bash
# ???
brown   bread   mat     hair   42
blue    cake    mug     shirt  -7
yellow  banana  window  shoes  3.14
```

**10)** Implement [ROT13](https://en.wikipedia.org/wiki/ROT13) cipher using the `tr` command.

```bash
$ echo 'Hello World' | tr # ???
Uryyb Jbeyq

$ echo 'Uryyb Jbeyq' | tr # ???
Hello World
```

**11)** Retain only alphabets, digits and whitespace characters.

```bash
$ echo 'Apple_42 cool,blue Dragon:army' | # ???
Apple42 coolblue Dragonarmy
```

**12)** Use `tr` to get the output shown below.

```bash
$ echo '!!hhoowwww !!aaaaaareeeeee!! yyouuuu!!' | tr # ???
how are you
```

**13)** `paste -s` works separately for multiple input files. How would you workaround this if you needed to treat all the input files as a single source?

```bash
# this works individually for each input file
$ paste -sd, fruits.txt ip.txt
banana,papaya,mango
deep blue,light orange,blue delight

# expected output
# ???
banana,papaya,mango,deep blue,light orange,blue delight
```

**14)** Use appropriate options to get the expected output shown below.

```bash
# default output
$ paste fruits.txt ip.txt
banana  deep blue
papaya  light orange
mango   blue delight

# expected output
$ paste # ???
banana
deep blue
papaya
light orange
mango
blue delight
```

**15)** Use the `pr` command to get the expected output shown below.

```bash
$ seq -w 16 | pr # ???
01,02,03,04
05,06,07,08
09,10,11,12
13,14,15,16

$ seq -w 16 | pr # ???
01,05,09,13
02,06,10,14
03,07,11,15
04,08,12,16
```

**16)** Use the `pr` command to join the input files `fruits.txt` and `ip.txt` as shown below.

```bash
# ???
banana : deep blue
papaya : light orange
mango : blue delight
```

**17)** The `cut` command doesn't support a way to choose the last `N` fields. Which tool presented in this chapter can be combined to work with `cut` to get the output shown below?

```bash
# last two characters from each line
$ printf 'apple\nbanana\ncherry\ndates\n' | # ???
le
na
ry
es
```

**18)** Go through the `split` documentation and use appropriate options to get the output shown below for the input file `purchases.txt`.

```bash
# split input by 3 lines (max) at a time
# ???

$ head xa?
==> xaa <==
coffee
tea
washing powder

==> xab <==
coffee
toothpaste
tea

==> xac <==
soap
tea

$ rm xa?
```

**19)** Go through the `split` documentation and use appropriate options to get the output shown below.

```bash
$ echo 'apple,banana,cherry,dates' | split # ???

$ head xa?
==> xaa <==
apple,
==> xab <==
banana,
==> xac <==
cherry,
==> xad <==
dates

$ rm xa?
```

**20)** Split the input file `purchases.txt` such that the text before a line containing `powder` is part of the first file and the rest are part of the second file as shown below.

```bash
# ???

$ head xx0?
==> xx00 <==
coffee
tea

==> xx01 <==
washing powder
coffee
toothpaste
tea
soap
tea

$ rm xx0?
```

**21)** Write a generic solution that transposes comma delimited data. Example input/output is shown below. You can use any tool(s) presented in this book.

```bash
$ cat scores.csv
Name,Maths,Physics,Chemistry
Ith,100,100,100
Cy,97,98,95
Lin,78,83,80

# ???
Name,Ith,Cy,Lin
Maths,100,97,78
Physics,100,98,83
Chemistry,100,95,80
```

**22)** Reshape the contents of `table.txt` to the expected output shown below.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

# ???
brown   bread  mat     hair
42      blue   cake    mug
shirt   -7     yellow  banana
window  shoes  3.14
```

<br>

## Shell Scripting

>![info](../images/info.svg) Use a temporary working directory before attempting the exercises. You can delete such practice directories afterwards.

**1)** What's wrong with the script shown below? Also, will the error go away if you use `bash try.sh` instead?

```bash
$ printf '    \n!#/bin/bash\n\necho hello\n' > try.sh
$ chmod +x try.sh
$ ./try.sh
./try.sh: line 2: !#/bin/bash: No such file or directory
hello

# expected output
$ ./try.sh
hello
```

**2)** Will the command shown below work? If so, what would be the output?

```bash
$ echo echo hello | bash
```

**3)** When would you `source` a script instead of using `bash` or creating an executable using shebang?

**4)** How would you display the contents of a variable with `shake` appended?

```bash
$ fruit='banana'

$ echo # ???
bananashake
```

**5)** What changes would you make to the code shown below to get the expected output?

```bash
# default behavior
$ n=100
$ n+=100
$ echo "$n"
100100

# expected output
$ echo "$n"
200
```

**6)** Is the following code valid? If so, what would be the output of the `echo` command?

```bash
$ declare -a colors
$ colors[3]='green'
$ colors[1]='blue'

$ echo "${colors[@]}"
# ???
```

**7)** How would you get the last three characters of a variable's contents?

```bash
$ fruit='banana'

# ???
ana
```

**8)** Will the second `echo` command give an error? If not, what will be the output?

```bash
$ fruits=('apple' 'fig' 'mango')
$ echo "${#fruits[@]}"
3

$ echo "${#fruits}"
# ???
```

**9)** For the given array, use parameter expansion to remove characters until the first/last space.

```bash
$ colors=('green' 'dark brown' 'deep sky blue white')

# remove till the first space
$ printf '%s\n' # ???
green
brown
sky blue white

# remove till the last space
$ printf '%s\n' # ???
green
brown
white
```

**10)** Use parameter expansion to get the expected outputs shown below.

```bash
$ ip='apple:banana:cherry:dragon'

$ echo # ???
apple:banana:cherry

$ echo # ???
apple
```

**11)** Is it possible to achieve the expected outputs shown below using parameter expansion? If so, how?

```bash
$ ip1='apple:banana:cherry:dragon'
$ ip2='Cradle:Mistborn:Piranesi'

$ echo # ???
apple 42 dragon
$ echo # ???
Cradle 42 Piranesi

$ echo # ???
fig:banana:cherry:dragon
$ echo # ???
fig:Mistborn:Piranesi

$ echo # ???
apple:banana:cherry:end
$ echo # ???
Cradle:Mistborn:end
```

**12)** For the given input, change case as per the expected outputs shown below.

```bash
$ ip='This is a Sample STRING'

$ echo # ???
THIS IS A SAMPLE STRING

$ echo # ???
this is a sample string

$ echo # ???
tHIS IS A sAMPLE string
```

**13)** Why does the conditional expression shown below fail?

```bash
$ touch ip.txt
$ [[-f ip.txt]] && echo 'file exists'
[[-f: command not found
```

**14)** What is the difference between the `==` and `=~` string comparison operators?

**15)** Why does the conditional expression used below show `failed` both times? Modify the expressions such that the first one correctly says `matched` instead of `failed`.

```bash
$ f1='1234.txt'
$ f2='report_2.txt'

$ [[ $f1 == '+([0-9]).txt' ]] && echo 'matched' || echo 'failed'
failed
$ [[ $f2 == '+([0-9]).txt' ]] && echo 'matched' || echo 'failed'
failed
```

**16)** Extract the digits that follow a `:` character for the given variable contents.

```bash
$ item='chocolate:50'
# ???
50

$ item='50 apples, fig:100, books-12'
# ???
100
```

**17)** Modify the expression shown below to correctly report `true` instead of `false`.

```bash
$ num=12345
$ [[ $num > 3 ]] && echo 'true' || echo 'false'
false
```

**18)** Write a shell script named `array.sh` that accepts array input from the user followed by another input as index. Display the corresponding value at that index. Couple of examples are shown below.

```bash
$ bash array.sh
enter array elements: apple banana cherry
enter array index: 1
element at index '1' is: banana

$ bash array.sh
enter array elements: dragon unicorn centaur
enter array index: -1
element at index '-1' is: centaur
```

**19)** Write a shell script named `case.sh` that accepts exactly two command line arguments. The first argument can be `lower`, `upper` or `swap` and this should be used to transform the contents of the second argument. Examples script invocations are shown below, including what should happen if the command line arguments do not meet the script expectations.

```bash
$ ./case.sh upper 'how are you?'
HOW ARE YOU?

$ ./case.sh lower PineAPPLE
pineapple

$ ./case.sh swap 'HeLlo WoRlD'
hElLO wOrLd

$ ./case.sh lower
Error! Two arguments expected.
$ echo $?
1

$ ./case.sh upper apple fig
Error! Two arguments expected.

$ ./case.sh lowercase DRAGON
Error! 'lowercase' command not recognized.
$ echo $?
1

$ ./case.sh apple lower 2> /dev/null
$ echo $?
1
```

**20)** Write a shell script named `loop.sh` that displays the number of lines for each of the files passed as command line arguments.

```bash
$ printf 'apple\nbanana\ncherry\n' > items_1.txt
$ printf 'dragon\nowl\nunicorn\ntroll\ncentaur\n' > items_2.txt

$ bash loop.sh items_1.txt
number of lines in 'items_1.txt' is: 3

$ bash loop.sh items_1.txt items_2.txt
number of lines in 'items_1.txt' is: 3
number of lines in 'items_2.txt' is: 5
```

**21)** Write a shell script named `read_file.sh` that reads a file line by line to be passed as an argument to the `paste -sd,` command. Can you also write a solution using the `xargs` command instead of a script?

```bash
$ printf 'apple\nbanana\ncherry\n' > items_1.txt
$ printf 'dragon\nowl\nunicorn\ntroll\ncentaur\n' > items_2.txt
$ printf 'items_1.txt\nitems_2.txt\n' > list.txt

$ bash read_file.sh list.txt
apple,banana,cherry
dragon,owl,unicorn,troll,centaur

$ xargs # ???
apple,banana,cherry
dragon,owl,unicorn,troll,centaur
```

**22)** Write a function named `add_path` which prefixes the path of the current working directory to the arguments it receives and displays the results. Examples are shown below.

```bash
$ add_path() # ???

$ cd
$ pwd
/home/learnbyexample
$ add_path ip.txt report.log
/home/learnbyexample/ip.txt /home/learnbyexample/report.log

$ cd cli-computing
$ pwd
/home/learnbyexample/cli-computing
$ add_path f1
/home/learnbyexample/cli-computing/f1
```

**23)** What do the options `bash -x` and `bash -v` do?

**24)** What is `shellcheck` and when would you use it?

<br>

## Shell Customization

**1)** Which command would you use to display the name and value of all or specific environment variables?

**2)** If you add an alias for an already existing command (`ls` for example), how would you invoke the original command instead of the alias?

**3)** Why doesn't the alias shown below work? What would you use instead?

```bash
# doesn't work as expected
$ alias ext='echo "${1##*.}"'
$ ext ip.txt
 ip.txt

# expected output
$ ext ip.txt
txt
$ ext scores.csv
csv
$ ext file.txt.txt
txt
```

**4)** How would you remove a particular alias/function definition for the current shell session?

```bash
$ alias hw='echo hello world'
$ hw
hello world
# ???
$ hw
hw: command not found

$ hw() { echo hello there ; }
$ hw
hello there
# ???
$ hw
hw: command not found
```

**5)** Write an alias and a function to display the contents of the `PATH` environment variable on separate lines by changing `:` to the newline character. Sample output is shown below.

```bash
$ echo "$PATH"
/usr/local/bin:/usr/bin:/bin:/usr/games

# alias
$ a_p
/usr/local/bin
/usr/bin
/bin
/usr/games

# function
$ f_p
/usr/local/bin
/usr/bin
/bin
/usr/games
```

**6)** Will a login shell read and execute `~/.bashrc` automatically?

**7)** What should be the value assigned to `HISTSIZE` if you wish to have unlimited history entries?

**8)** What does the binding `set completion-ignore-case on` do?

**9)** Which shortcut helps you interactively search the command history?

**10)** What do the shortcuts `Alt+b` and `Alt+f` do?

**11)** Are there differences between the `Ctrl+l` shortcut and the `clear` command?

**12)** Which shortcut will you use to delete characters before the cursor till the start of the line?

**13)** What do the shortcuts `Alt+t` and `Ctrl+t` do?

**14)** Is there a difference between the `Shift+Insert` and `Shift+Ctrl+v` shortcuts?

