# Exercise Solutions

## Command Line Overview

**1)** By default, is `echo` a shell builtin or external command on your system? What command could you use to get an answer for this question?

On my system, `echo` is both a shell builtin and an external command.

```bash
$ type -a echo
echo is a shell builtin
echo is /bin/echo
```

As seen in the above result, the builtin command takes priority, so that is the default version.

**2)** What output do you get for the command shown below? Does the documentation help understand the result?

```bash
$ echo apple     42 'banana     100'
apple 42 banana     100
```

Yes, the documentation helps to understand the above result. From `help echo` (since the builtin version is the default):

>Display the ARGs, separated by a single space character and followed by a newline, on the standard output.

In the above command, there are three arguments passed to the `echo` command — `apple`, `42` and `'banana     100'`. The string represented by these arguments are displayed in the output separated by a single space character.

**3)** Go through [bash manual: Tilde Expansion](https://www.gnu.org/software/bash/manual/html_node/Tilde-Expansion.html). Is `~/projects` a relative or an absolute path? See [this unix.stackexchange thread](https://unix.stackexchange.com/q/221970/109046) for answers.

I do not much care if it is correct to call it a relative or absolute path. More importantly, I want to highlight this gotcha from the above unix.stackexchange thread:

>`~` is syntax implemented by the shell (and other programs which imitate it for convenience) which expands it into a real pathname. To illustrate, `~/Documents` is approximately the same thing as `$HOME/Documents` (again, shell syntax). Since `$HOME` should be an absolute path, the value of `$HOME/Documents` is also an absolute path. But the text `$HOME/Documents` or `~/Documents` has to be expanded by the shell in order to become the path we mean.

I spent a frustrating few hours trying to debug why one of my [autostart](https://wiki.archlinux.org/title/Autostarting) script wasn't working. Yup, you guessed it. The issue was using `~` and changing to the full path fixed it.

**4)** Which key would you use to get help while the `less` command is active?

`h`

**5)** How would you bring the 50th line to the top of the screen while viewing a `man` page (assume `less` command is the `pager`)?

`50g`

**6)** What does the `Ctrl+k` shortcut do?

Deletes from the current character to the end of the command line.

**7)** Briefly explain the role of the following shell operators:

*a)* `|` — redirects output from a command as input to another command  
*b)* `>` — redirects output from a command to a file (overwrites if the file already exists)  
*c)* `>>` — redirects output from a command to a file (appends if the file already exists)

**8)** The `whatis` command displays one-line descriptions about commands. But it doesn't seem to work for `whatis type`. What should you use instead?

```bash
$ whatis cat
cat (1)              - concatenate files and print on the standard output

$ whatis type
type: nothing appropriate.

# need to use 'help -d' since 'type' is a shell builtin
$ help -d type
type - Display information about command type.
```

**9)** What is the role of the `/tmp` directory?

From `man hier`:

>This directory contains temporary files which may be deleted with no notice, such as by a regular job or at system boot up.

See [wikipedia: Temporary folder](https://en.wikipedia.org/wiki/Temporary_folder) for more details.

**10)** Give an example each for absolute and relative paths.

* absolute path: `/usr/share/dict/words`
* relative path: `../../projects`

**11)** When would you use the `man -k` command?

From `man man`:

>`-k, --apropos`
>
>Equivalent to apropos.  Search the short manual  page  descriptions
>for keywords and display any matches.  See apropos(1) for details.

For example:

```bash
# same as: apropos column
$ man -k column
colrm (1)            - remove columns from a file
column (1)           - columnate lists
git-column (1)       - Display data in columns
```

**12)** Are there differences between the `man` and `info` pages?

The Linux manual pages are usually shortened version of the full documentation. You can use the `info` command to view the complete documentation for GNU tools. `info` is also a TUI application, but with different key configuration compared to the `man` command. See [GNU Manuals Online](https://www.gnu.org/manual/manual.html) if you'd prefer to read them from a web browser. You can also download them in formats like PDF for offline usage.

<br>

## Managing Files and Directories

>![info](../images/info.svg) The `ls.sh` script will be used for some of the exercises.

**1)** Which of these commands will always display the absolute path of the home directory?

*a)* `pwd`  
*b)* `echo "$PWD"`  
*c)* `echo "$HOME"`

Answer: *c)* `echo "$HOME"`

**2)** The current working directory has a folder named `-dash`. How would you switch to that directory?

*a)* `cd -- -dash`  
*b)* `cd -dash`  
*c)* `cd ./-dash`  
*d)* `cd \-dash`  
*e)* `cd '-dash'`  
*f)* all of the above  
*g)* only *a)* and *c)*

Answer: *g)* only *a)* and *c)*

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

$ cd ../todos
$ pwd
/home/learnbyexample/cli-computing/example_files/scripts/ls_examples/todos
```

**4)** As per the scenario shown below, how would you change to the `cli-computing` directory under the user's home directory? And then, how would you go back to the previous working directory?

```bash
$ pwd
/home/learnbyexample/all/projects/square_tictactoe

$ cd ~/cli-computing
$ pwd
/home/learnbyexample/cli-computing

$ cd -
$ pwd
/home/learnbyexample/all/projects/square_tictactoe
```

**5)** How'd you list the contents of the current directory, one per line, along with the size of the entries in human readable format?

```bash
# change to the 'scripts' directory and source the 'ls.sh' script
$ source ls.sh

$ ls -1sh
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

From `man ls`:

>`-v`
>
>natural sort of (version) numbers within text

**7)** Which `ls` command option would you use for sorting based on entry size?

>`-S`
>
>sort by file size, largest first

**8)** Which `ls` command option would you use for sorting based on file extension?

>`-X`
>
>sort alphabetically by entry extension

**9)** What does the `-G` option of `ls` command do?

>`-G, --no-group`
>
>in a long listing, don't print group names

**10)** What does the `-i` option of `ls` command do?

>`-i, --inode`
>
>print the index number of each file

**11)** List only the directories as one entry per line.

```bash
# change to the 'scripts' directory and source the 'ls.sh' script
$ source ls.sh

$ ls -1d */
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
mkdir: cannot create directory ‘notes’: File exists
```

**13)** Use one or more commands to match the scenario shown below:

```bash
$ ls -1F
cost.txt

# can also use: mkdir {gho,que,toa}st
# brace expansion is covered in the "Shell Features" chapter
$ mkdir ghost quest toast

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

# can also use: mkdir -p hobbies/{painting,trekking,writing} shopping
# or: mkdir -p hobbies/{paint,trekk,writ}ing shopping
$ mkdir -p hobbies/painting hobbies/trekking hobbies/writing shopping
$ touch hobbies/painting/waterfall.bmp hobbies/trekking/himalayas.txt
$ touch shopping/festival.xlsx

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

>`-p, --parents`
>
>no error if existing, make parent directories as needed

**16)** Use one or more commands to match the scenario given below:

```bash
$ ls -1F
cost.txt
ghost/
quest/
toast/

$ rm -r cost.txt ghost toast

$ ls -1F
quest/
```

**17)** What does the `-f` option of `rm` command do?

>`-f, --force`
>
>ignore nonexistent files and arguments, never prompt

For example, it helps to remove write protected files (provided you have appropriate permissions to delete those files).

**18)** Which option would you use to interactively delete files using the `rm` command?

>`-i`
>
>prompt before every removal
>
>`-I`
>
>prompt once before removing more than three files, or when removing
>recursively;  less intrusive than `-i`, while still giving protection
>against most mistakes

**19)** Can the files removed by `rm` easily be restored? Do you need to take some extra steps or use special commands to make the files more difficult to recover?

* Files removed using `rm` can still be recovered with time and skill
    * [unix.stackexchange: recover deleted files](https://unix.stackexchange.com/q/80270/109046)
    * [unix.stackexchange: recovering accidentally deleted files](https://unix.stackexchange.com/q/2677/109046)
* Use commands like `shred` if you want to make it harder to recover deleted files
    * [wiki.archlinux: Securely wipe disk](https://wiki.archlinux.org/title/Securely_wipe_disk)

**20)** Does your Linux distribution provide a tool to send deleted files to the trash (which would help to recover deleted files)?

On Ubuntu, you can use `sudo apt install trash-cli` to install the `trash` command. See also [wiki.archlinux: Trash management](https://wiki.archlinux.org/title/Trash_management).

**21)** Which option would you use to interactively accept/prevent the `cp` command from overwriting a file of the same name? And which option would prevent overwriting without needing manual confirmation?

>`-i, --interactive`
>
>prompt before overwrite (overrides a previous -n option)
>
>`-n, --no-clobber`
>
>do not overwrite an existing file (overrides a previous -i option)

**22)** Does the `cp` command allow you to rename the file or directory being copied? If so, can you rename multiple files/directories being copied?

`cp` allows renaming single file or directory by specifying a different name in the destination path. You can't rename multiple files or directories with a single `cp` usage.

**23)** What do the `-u`, `-b` and `-t` options of `cp` command do?

>`-u, --update`
>
>copy  only  when the SOURCE file is newer than the destination file
>or when the destination file is missing
>
>`--backup[=CONTROL]`
>
>make a backup of each existing destination file
>
>`-b`
>
>like `--backup` but does not accept an argument
>
>`-t, --target-directory=DIRECTORY`
>
>copy all SOURCE arguments into DIRECTORY

**24)** What's the difference between the two commands shown below?

```bash
$ cp ip.txt op.txt

$ mv ip.txt op.txt
```

* `cp` makes a new copy of `ip.txt` named as `op.txt` — two files having the same content
* `mv` renames `ip.txt` as `op.txt` — there's only one file

**25)** Which option would you use to interactively accept/prevent the `mv` command from overwriting a file of the same name?

>`-i, --interactive`
>
>prompt before overwrite

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

$ mv hobbies/*/* hobbies/
$ rm -r hobbies/*/

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

>`-t, --target-directory=DIRECTORY`
>
>move all SOURCE arguments into DIRECTORY

**28)** Determine and implement the `rename` logic based on the filenames and expected output shown below.

```bash
$ touch '(2020) report part 1.txt' 'analysis part 3 (2018).log'
$ ls -1
'(2020) report part 1.txt'
'analysis part 3 (2018).log'

# can also use: rename 's/[()]//g; y/ /_/' *
$ rename 's/ /_/g; s/[()]//g' *

$ ls -1
2020_report_part_1.txt
analysis_part_3_2018.log
```

**29)** Does the `ln` command follow the same order to specify source and destination as the `cp` and `mv` commands?

Yes.

**30)** Which `tar` option helps to compress archives based on filename extension? This option can be used instead of `-z` for `gzip`, `-j` for `bzip2` and `-J` for `xz`.

>`-a, --auto-compress`
>
>Use archive suffix to determine the compression program.

<br>

## Shell Features

>![info](../images/info.svg) Use the `globs.sh` script for wildcards related exercises, unless otherwise mentioned.

>![info](../images/info.svg) Create a temporary directory for exercises that may require you to create some files. You can delete such practice directories afterwards.

**1)** Use the `echo` command to display the text as shown below. Use appropriate quoting as necessary.

```nohighlight
# can also use: echo "that's"'    great! $x = $y + $z'
$ echo 'that'\''s    great! $x = $y + $z'
that's    great! $x = $y + $z
```

**2)** Use the `echo` command to display the values of the three variables in the format as shown below.

```bash
$ n1=10
$ n2=90
$ op=100

$ echo "$n1 + $n2 = $op"
10 + 90 = 100
```

**3)** What will be the output of the command shown below?

```bash
$ echo $'\x22apple\x22: \x2710\x27'
"apple": '10'
```

**4)** List filenames starting with a digit character.

```bash
# change to the 'scripts' directory and source the 'globs.sh' script
$ source globs.sh

$ ls [0-9]*
100.sh  42.txt
```

**5)** List filenames whose extension do not begin with `t` or `l`. Assume extensions will have at least one character.

```bash
# can also use: ls *.[!tl]*
$ ls *.[^tl]*
100.sh  calc.py  hello.py  hi.sh  main.c  math.h
```

**6)** List filenames whose extension only have a single character.

```bash
$ ls *.?
main.c  math.h
```

**7)** List filenames whose extension is not `txt`.

```bash
$ shopt -s extglob
$ ls *.!(txt)
100.sh   hello.py  main.c  report-00.log  report-04.log
calc.py  hi.sh     math.h  report-02.log  report-98.log
```

**8)** Describe the wildcard pattern used in the command shown below.

```bash
$ ls *[^[:word:]]*.*
report-00.log  report-02.log  report-04.log  report-98.log
```

List files that have at least one non-word character (`-` for example) before a `.` character.

**9)** List filenames having only lowercase alphabets before the extension.

```bash
$ ls +([a-z]).*
calc.py  hello.py  hi.sh  ip.txt  main.c  math.h  notes.txt
```

**10)** List filenames starting with `ma` or `he` or `hi`.

```bash
$ ls ma* he* hi*
hello.py  hi.sh  main.c  math.h

# alternate solutions
$ ls @(ma|h[ei])*
$ ls @(ma|he|hi)*
```

**11)** What commands would you use to get the outputs shown below? Assume that you do not know the depth of sub-directories.

```bash
# change to the 'scripts' directory and source the 'ls.sh' script
$ source ls.sh

# filenames ending with '.txt'
$ shopt -s globstar
$ ls **/*.txt
ip.txt  todos/books.txt  todos/outing.txt

# directories starting with 'c' or 'd' or 'g' or 'r' or 't'
$ ls -1d **/[cdgrt]*/
backups/dot_files/
projects/calculator/
projects/tictactoe/
todos/
```

**12)** Create and change to an empty directory. Then, use brace expansion along with relevant commands to get the results shown below.

```bash
$ mkdir practice_brace && cd $_
$ touch report_202{0..2}.txt
$ ls report*
report_2020.txt  report_2021.txt  report_2022.txt

# use the 'cp' command here
$ cp report_2021.txt{,.bkp}
$ ls report*
report_2020.txt  report_2021.txt  report_2021.txt.bkp  report_2022.txt
```

**13)** What does the `set` builtin command do?

From `help set`:

>Change the value of shell attributes and positional parameters, or
>display the names and values of shell variables.

**14)** What does the `|` pipe operator do? And when would you add the `tee` command?

`|` redirects the output of a command as input to another command. The `tee` command will help to save the output of a command to a file as well as display it on the terminal.

**15)** Can you infer what the following command does? *Hint*: see `help printf`.

```bash
$ printf '%s\n' apple car dragon
apple
car
dragon
```

From `help printf`:

>The format is re-used as necessary to consume all of the arguments.  If
>there are fewer arguments than the format requires,  extra format
>specifications behave as if a zero value or null string, as appropriate,
>had been supplied.

In the above example, the format `%s\n` is applied to all the three arguments.

**16)** Use brace expansion along with relevant commands and shell features to get the result shown below. *Hint*: see previous question.

```bash
$ ls ip.txt
ls: cannot access 'ip.txt': No such file or directory

# can also use: printf '%s\n' item_{10..20..2} > ip.txt
$ printf 'item_%s\n' {10..20..2} > ip.txt
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
$ printf '%s\n' apple_{1..3}_banana_{6..8} >> ip.txt
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

* the `<` redirection operator helps you to pass data from a file as input to a command
* the `|` operator redirects output of a command as input to another command

**19)** Which character is typically used to represent `stdin` data as a file argument?

`-`

**20)** What do the following operators do?

*a)* `1>` — redirect the standard output of a command to a file  
*b)* `2>` — redirect the standard error of a command to a file  
*c)* `&>` — redirect both `stdout` and `stderr` (overwrites an existing file)  
*d)* `&>>` — redirect both `stdout` and `stderr` (appends to an existing file)  
*e)* `|&` — pipe both `stdout` and `stderr` as input to another command

**21)** What will be the contents of `op.txt` if you use the following `grep` command?

```bash
# press Ctrl+d after the line containing 'histogram'
$ grep 'hi' > op.txt
hi there
this is a sample line
have a nice day
histogram

# you'll get lines containing 'hi'
$ cat op.txt
hi there
this is a sample line
histogram
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
dragon
unicorn
apple 42
ice cream
```

Note that the value of `qty` variable was substituted for `$qty`. You'll have to use `'end'` or `\end` to avoid shell interpolation.

**23)** Correct the command to get the expected output shown below.

```bash
$ books='cradle piranesi soulhome bastion'

# something is wrong with this command
$ sed 's/\b\w/\u&/g' <<< '$books'
$Books

# double quotes is needed for variable interpolation
$ sed 's/\b\w/\u&/g' <<< "$books"
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

# can also use: { echo 'hello' ; seq 3 ; } > op.txt
$ (echo 'hello' ; seq 3) > op.txt
$ cat op.txt
hello
1
2
3
```

**25)** What will be the output of the following commands?

```bash
$ printf 'hello' | tr 'a-z' 'A-Z' && echo ' there'
HELLO there

$ printf 'hello' | tr 'a-z' 'A-Z' || echo ' there'
HELLO
```

In both cases, the first command succeeds (exit status `0`). The `&&` and `||` are short-circuit operators. Their second operands will be executed only if the first one was success and failure respectively.

**26)** Correct the command(s) to get the expected output shown below.

```bash
# something is wrong with these commands
$ nums=$(seq 3)
$ echo $nums
1 2 3

$ echo "$nums"
1
2
3
```

**27)** Will the following two commands produce equivalent output? If not, why not?

```bash
$ paste -d, <(seq 3) <(printf '%s\n' item_{1..3})
1,item_1
2,item_2
3,item_3

$ printf '%s\n' {1..3},item_{1..3}
1,item_1
1,item_2
1,item_3
2,item_1
2,item_2
2,item_3
3,item_1
3,item_2
3,item_3
```

The outputs are not equivalent because brace expansion creates all combinations when multiple braces are used.

<br>

## Viewing Part or Whole File Contents

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises.

**1)** Which option(s) would you use to get the output shown below?

```bash
$ printf '\n\n\ndragon\n\n\nunicorn\n\n\n' | cat -bs

     1  dragon

     2  unicorn

```

**2)** Pass appropriate arguments to the `cat` command to get the output shown below.

```bash
$ cat greeting.txt
Hi there
Have a nice day

$ echo '42 apples and 100 bananas' | cat - greeting.txt
42 apples and 100 bananas
Hi there
Have a nice day
```

**3)** Will the two commands shown below produce the same output? If not, why not?

```bash
$ cat fruits.txt ip.txt | tac
blue delight
light orange
deep blue
mango
papaya
banana

$ tac fruits.txt ip.txt
mango
papaya
banana
blue delight
light orange
deep blue
```

No. The outputs are different because `tac` reverses content separately for each input file.

**4)** Go through the manual for the `tac` command and use appropriate options and arguments to get the output shown below.

```bash
$ cat blocks.txt
%=%=
apple
banana
%=%=
brown
green

$ tac -bs '%=%=' blocks.txt
%=%=
brown
green
%=%=
apple
banana
```

>`-b, --before`
>
>attach the separator before instead of after
>
>`-s, --separator=STRING`
>
>use STRING as the separator instead of newline

**5)** What is the difference between `less -n` and `less -N` options? Does `cat -n` and `less -n` have similar functionality?

`less -N` enables line numbering and `less -n` disables numbering. `cat -n` enables line numbering, so it doesn't function similar to `less -n`.

**6)** Which command would you use to open another file from within an existing `less` session? And which commands would you use to navigate between previous and next files?

You can use `:e filename` to open another file (similar to the Vim text editor). You can use `:p` and `:n` to switch between the previous and next files.

**7)** Use appropriate commands and shell features to get the output shown below.

```bash
$ printf 'carpet\njeep\nbus\n'
carpet
jeep
bus

# use the above 'printf' command for input data
$ c=$(printf 'carpet\njeep\nbus\n' | head -c3)
$ echo "$c"
car
```

**8)** How would you display all the input lines except the first one?

```bash
$ printf 'apple\nfig\ncarpet\njeep\nbus\n' | tail -n +2
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

$ head -q -n2 fruits.txt blocks.txt
banana
papaya
%=%=
apple
```

**10)** Use a combination of the `head` and `tail` commands to get the 11th to 14th characters from the given input.

```bash
# can also use: tail -c +11 | head -c4
$ printf 'apple\nfig\ncarpet\njeep\nbus\n' | head -c14 | tail -c +11
carp
```

**11)** Extract the starting six bytes from the input files `table.txt` and `fruits.txt`.

```bash
$ head -q -c6 table.txt fruits.txt
brown banana
```

**12)** Extract the last six bytes from the input files `fruits.txt` and `table.txt`.

```bash
$ tail -q -c6 fruits.txt table.txt
mango
 3.14
```

<br>

## Searching Files and Filenames

>![info](../images/info.svg) For `grep` exercises, use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files, unless otherwise specified.

>![info](../images/info.svg) For `find` exercises, use the `find.sh` script, unless otherwise specified.

**1)** Display lines containing `an` from the input files `blocks.txt`, `ip.txt` and `uniform.txt`. Show the results with and without filename prefix.

```bash
$ grep 'an' blocks.txt ip.txt uniform.txt
blocks.txt:banana
ip.txt:light orange
uniform.txt:mango

$ grep -h 'an' blocks.txt ip.txt uniform.txt
banana
light orange
mango
```

**2)** Display lines containing the whole word `he` from the `sample.txt` input file.

```bash
$ grep -w 'he' sample.txt
14) He he he
```

**3)** Match only whole lines containing `car` irrespective of case. The matching lines should be displayed with line number prefix as well.

```bash
$ printf 'car\nscared\ntar car par\nCar\n' | grep -nix 'car'
1:car
4:Car
```

**4)** Display all lines from `purchases.txt` except those that contain `tea`.

```bash
$ grep -v 'tea' purchases.txt
coffee
washing powder
coffee
toothpaste
soap
```

**5)** Display all lines from `sample.txt` that contain `do` but not `it`.

```bash
# can also use: grep -P '^(?!.*it).*do' sample.txt
$ grep 'do' sample.txt | grep -v 'it'
13) Much ado about nothing
```

**6)** For the input file `sample.txt`, filter lines containing `do` and also display the line that comes after such a matching line.

```bash
$ grep -A1 'do' sample.txt
 6) Just do-it
 7) Believe it
--
13) Much ado about nothing
14) He he he
```

**7)** For the input file `sample.txt`, filter lines containing `are` or `he` as whole words as well as the line that comes before such a matching line. Go through `info grep` or the [online manual](https://www.gnu.org/software/grep/manual/grep.html) and use appropriate options such that there's no separator between the groups of matching lines in the output.

```bash
$ grep --no-group-separator -B1 -wE 'are|he' sample.txt
 3) Hi there
 4) How are you
13) Much ado about nothing
14) He he he
```

>`--no-group-separator`
>
>When `-A`, `-B` or `-C` are in use, do not print a separator
>between groups of lines.

**8)** Extract all pairs of `()` with/without text inside them, provided they do not contain `()` characters inside.

```bash
$ echo 'I got (12) apples' | grep -o '([^()]*)'
(12)

$ echo '((2 +3)*5)=25 and (4.3/2*()' | grep -o '([^()]*)'
(2 +3)
()
```

**9)** For the given input, match all lines that start with `den` or end with `ly`.

```bash
$ lines='reply\n1 dentist\n2 lonely\neden\nfly away\ndent\n'

$ printf '%b' "$lines" | grep -E '^den|ly$'
reply
2 lonely
dent
```

**10)** Extract words starting with `s` and containing both `e` and `t` in any order.

```bash
$ words='sequoia subtle exhibit sets tests sit store_2'

$ echo "$words" | grep -owP 's(?=\w*t)(?=\w*e)\w+'
subtle
sets
store_2

# alternate solutions, but these won't scale well with more conditions
$ echo "$words" | grep -ow 's\w*t\w*' | grep 'e'
$ echo "$words" | grep -owE 's\w*(t\w*e|e\w*t)\w*'
```

**11)** Extract all whole words having the same first and last word character.

```bash
# can also use: grep -owE '(\w)(\w*\1)?'
$ echo 'oreo not a _oh_ pip RoaR took 22 Pop' | grep -owE '\w|(\w)\w*\1'
oreo
a
_oh_
pip
RoaR
22
```

**12)** Match all input lines containing `*[5]` literally.

```bash
$ printf '4*5]\n(9-2)*[5]\n[5]*3\nr*[5\n' | grep -F '*[5]'
(9-2)*[5]
```

**13)** Match whole lines that start with `hand` and immediately followed by `s` or `y` or `le` or no further character.

```bash
$ lines='handed\nhand\nhandy\nunhand\nhands\nhandle\nhandss\n'

$ printf '%b' "$lines" | grep -xE 'hand([sy]|le)?'
hand
handy
hands
handle
```

**14)** Input lines have three or more fields separated by a `,` delimiter. Extract from the second field to the second last field. In other words, extract fields other than the first and last.

```bash
$ printf 'apple,fig,cherry\ncat,dog,bat\n' | grep -oP ',\K.+(?=,)'
fig
dog

$ echo 'dragon,42,unicorn,3.14,shapeshifter\n' | grep -oP ',\K.+(?=,)'
42,unicorn,3.14
```

**15)** Recursively search for files containing `ello`.

```bash
# change to the 'scripts' directory and source the 'grep.sh' script
$ source grep.sh

$ grep -rl 'ello'
projects/python/hello.py
projects/shell/hello.sh
colors_1
colors_2
```

**16)** Search for files containing `blue` recursively, but do not search within the `backups` directory.

```bash
# change to the 'scripts' directory and source the 'grep.sh' script
$ source grep.sh

$ grep -rl --exclude-dir='backups' 'blue'
.hidden
colors_1
colors_2
```

**17)** Search for files containing `blue` recursively, but not if the file also contains `teal`.

```bash
# change to the 'scripts' directory and source the 'grep.sh' script
$ source grep.sh

$ grep -rlZ 'blue' | xargs -r0 grep -L 'teal'
.hidden
colors_2
backups/color list.txt
```

**18)** Find all regular files within the `backups` directory.

```bash
# change to the 'scripts' directory and source the 'find.sh' script
$ source find.sh

$ find backups -type f
backups/dot_files/.bashrc
backups/dot_files/.inputrc
backups/dot_files/.vimrc
backups/aug.log
backups/bookmarks.html
backups/jan.log
```

**19)** Find all regular files whose extension starts with `p` or `s` or `v`.

```bash
$ find -type f -name '*.[psv]*'
./projects/tictactoe/game.py
./projects/calculator/calc.sh
./hi.sh
./backups/dot_files/.vimrc
./hello_world.py
```

**20)** Find all regular files whose name do *not* have the lowercase letters `g` to `l`.

```bash
# can also use: find -type f ! -name '*[g-l]*'
$ find -type f -not -name '*[g-l]*'
./todos/TRIP.txt
./todos/wow.txt
```

**21)** Find all regular files whose path has at least one directory name starting with `p` or `d`.

```bash
# can also use: find -type f -regex '.*/[pd].*/.*'
$ find -type f -path '*/[pd]*/*'
./projects/tictactoe/game.py
./projects/calculator/calc.sh
./backups/dot_files/.bashrc
./backups/dot_files/.inputrc
./backups/dot_files/.vimrc
```

**22)** Find all directories whose name contains `b` or `d`.

```bash
$ find -type d -name '*[bd]*'
./todos
./backups
./backups/dot_files
```

**23)** Find all hidden directories.

```bash
# can also use: find -mindepth 1 -type d -name '.*'
$ find -type d -name '.?*'
./projects/.venv
```

**24)** Find all regular files at the exact depth of `2`.

```bash
$ find -mindepth 2 -maxdepth 2 -type f
./todos/books.txt
./todos/TRIP.txt
./todos/wow.txt
./backups/aug.log
./backups/bookmarks.html
./backups/jan.log
```

**25)** What's the difference between `find -mtime` and `find -atime`? And, what is the time period these options work with?

`m` is for modified timestamp and `a` is for accessed timestamp. These options work with `24` hour periods.

>`-atime n`
>
>File was last accessed `n*24` hours ago.  When find figures out how
>many 24-hour periods ago the file was last accessed, any fractional
>part is ignored, so to match `-atime +1`, a file has to have been
>accessed at least two days ago.
>
>`-mtime n`
>
>File's data was last modified `n*24` hours ago.  See the comments for
>`-atime` to understand how rounding  affects  the  interpretation  of
>file modification times.

**26)** Find all empty regular files.

```bash
# can also use: find -type f -size 0
$ find -type f -empty
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
$ mkdir filtered_files
$ find -type f -size +1c -not -name '*.log' -exec cp -t filtered_files {} +
$ ls -A filtered_files
hello_world.py  .hidden  hi.sh  ip.txt
```

**28)** Find all hidden files, but not if they are part of the `filtered_files` directory created earlier.

```bash
$ find -type f -not -path './filtered_files/*' -prune -name '.*'
./.hidden
./backups/dot_files/.bashrc
./backups/dot_files/.inputrc
./backups/dot_files/.vimrc
```

**29)** Delete the `filtered_files` directory created earlier. Then, go through the `find` manual and figure out how to list only executable files.

```bash
$ rm -r filtered_files
$ find -type f -executable
./hi.sh
./hello_world.py
```

>`-executable`
>
>Matches files  which  are  executable  and  directories  which  are
>searchable  (in  a file name resolution sense) by the current user.

**30)** List at least one use case for piping the `find` output to the `xargs` command instead of using the `find -exec` option.

`xargs -P` (or the [parallel](https://www.gnu.org/software/parallel/) command) can be handy if you need parallel execution for performance reasons.

**31)** How does the `locate` command work faster than the equivalent `find` command?

From [unix.stackexchange: pros and cons of find and locate](https://unix.stackexchange.com/q/60205/109046):

>`locate` uses a prebuilt database, which should be regularly updated, while `find` iterates over a filesystem to locate files.
>
>Thus, `locate` is much faster than `find`, but can be inaccurate if the database -can be seen as a cache- is not updated (see `updatedb` command).

<br>

## File Properties

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises, unless otherwise specified.

>![info](../images/info.svg) Create a temporary directory for exercises that may require you to create some files and directories. You can delete such practice directories afterwards.

**1)** Save the number of lines in the `greeting.txt` input file to the `lines` shell variable.

```bash
$ lines=$(wc -l <greeting.txt)
$ echo "$lines"
2
```

**2)** What do you think will be the output of the following command?

```bash
$ echo 'dragons:2 ; unicorns:10' | wc -w
3
```

**3)** Use appropriate options and arguments to get the output shown below.

```bash
$ printf 'apple\nbanana\ncherry' | wc -lc sample.txt -
     15     183 sample.txt
      2      19 -
     17     202 total
```

**4)** Go through the `wc` manual and use appropriate options and arguments to get the output shown below.

```bash
$ printf 'greeting.txt\0scores.csv' | wc --files0-from=-
2 6 25 greeting.txt
4 4 70 scores.csv
6 10 95 total
```

>`--files0-from=F`
>
>read input from the files specified by NUL-terminated names in file
>F; If F is - then read names from standard input

**5)** What is the difference between the `wc -c` and `wc -m` options? And which option would you use to get the longest line length?

>`-c, --bytes`
>
>print the byte counts
>
>`-m, --chars`
>
>print the character counts
>
>`-L, --max-line-length`
>
>print the maximum display width

**6)** Find filenames ending with `.log` and report their sizes in human readable format. Use the `find+du` combination for the first case and the `ls` command (with appropriate shell features) for the second case.

```bash
# change to the 'scripts' directory and source the 'du.sh' script
$ source du.sh

$ find -type f -name '*.log' -exec du -h {} +
16K     ./projects/errors.log
7.4M    ./report.log

$ shopt -s globstar
$ ls -1sh **/*.log
 16K projects/errors.log
7.4M report.log
```

**7)** Report sizes of files/directories in the current path in powers of `1000` without descending into sub-directories. Also, show a total at the end.

```bash
# change to the 'scripts' directory and source the 'du.sh' script
$ source du.sh

$ du -sc --si *
50k     projects
7.7M    report.log
8.2k    todos
7.8M    total
```

**8)** What does the `du --apparent-size` option do?

>`--apparent-size`
>
>print apparent sizes, rather than disk usage; although the apparent
>size is  usually  smaller,  it  may  be  larger  due  to  holes  in
>('sparse')  files, internal fragmentation, indirect blocks, and the
>like

**9)** When will you use the `df` command instead of `du`? Which `df` command option will help you to report only the specific fields of interest?

`df` gives space usage for the entire file system whereas `du` is useful to get space estimate for specific files and directories.

```bash
$ whatis du df
du (1)               - estimate file space usage
df (1)               - report file system disk space usage
```

To get only specific fields of interest:

>`--output[=FIELD_LIST]`
>
>use the output format defined by FIELD_LIST, or print all fields if
>FIELD_LIST is omitted.

**10)** Display the size of `scores.csv` and `timings.txt` files in the format shown below.

```bash
$ stat -c '%n: %s' scores.csv timings.txt
scores.csv: 70
timings.txt: 49
```

**11)** Which `touch` option will help you prevent file creation if it doesn't exist yet?

>`-c, --no-create`
>
>do not create any files

**12)** Assume `new_file.txt` doesn't exist in the current working directory. What would be the output of the `stat` command shown below?

```bash
$ touch -t '202010052010.05' new_file.txt
$ stat -c '%y' new_file.txt
2020-10-05 20:10:05.000000000 +0530
```

>`-t STAMP`
>
>use [[CC]YY]MMDDhhmm[.ss] instead of current time

**13)** Is the following `touch` command valid? If so, what would be the output of the `stat` command that follows?

Yes, it is valid as multiple file arguments are allowed. The `-r` option helps to copy the timestamp details from the given file to the target files.

```bash
# change to the 'scripts' directory and source the 'touch.sh' script
$ source touch.sh

$ stat -c '%n: %y' fruits.txt
fruits.txt: 2017-07-13 13:54:03.576055933 +0530

$ touch -r fruits.txt f{1..3}.txt
$ stat -c '%n: %y' f*.txt
f1.txt: 2017-07-13 13:54:03.576055933 +0530
f2.txt: 2017-07-13 13:54:03.576055933 +0530
f3.txt: 2017-07-13 13:54:03.576055933 +0530
fruits.txt: 2017-07-13 13:54:03.576055933 +0530
```

**14)** Use appropriate option(s) to get the output shown below.

```bash
$ printf 'αλεπού\n' | file -
/dev/stdin: UTF-8 Unicode text

$ printf 'αλεπού\n' | file -b -
UTF-8 Unicode text
```

**15)** Is the following command valid? If so, what would be the output?

Yes, it is valid. Multiple slashes will be considered as a single slash. Any trailing slashes will be removed before determining the portion to be extracted.

```bash
$ basename -s.txt ~///test.txt///
test
```

**16)** Given the file path in the shell variable `p`, how'd you obtain the output shown below?

```bash
$ p='~/projects/square_tictactoe/python/game.py'
$ dirname $(dirname "$p")
~/projects/square_tictactoe
```

**17)** Explain what each of the characters mean in the following `stat` command's output.

```bash
$ stat -c '%A' ../scripts/
drwxrwxr-x
```

The 10 characters displayed are related to file type and permissions. First character indicates the **file type**. The most common ones are:

* `-` regular file
* `d` directory
* `l` symbolic link

The other nine characters represent three sets of **file permissions** for *user* (`u`), *group* (`g`) and *others* (`o`), in that order.

* *user* — file owner
* *group* — users having file access as part of a group
* *others* — everyone else

**Permission reference table:**

| Character | Meaning       | Value |
| --------- | ------------- | ----- |
| `r`       | read          | `4`   |
| `w`       | write         | `2`   |
| `x`       | execute       | `1`   |
| `-`       | no permission | `0`   |

**18)** What would be the output of the second `stat` command shown below?

```bash
$ touch new_file.txt
$ stat -c '%a %A' new_file.txt
664 -rw-rw-r--

$ chmod 546 new_file.txt
$ stat -c '%a %A' new_file.txt
546 -r-xr--rw-
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
$ mkdir -m 750 back_up
$ stat -c '%a %A' back_up
750 drwxr-x---
```

**20)** Change the file permission of `book_list.txt` to match the output of the second `stat` command shown below. Don't use the number `220`, specify the changes in terms of `rwx` characters.

```bash
$ touch book_list.txt
$ stat -c '%a %A' book_list.txt
664 -rw-rw-r--

# can also use: chmod -r book_list.txt
$ chmod =w book_list.txt
$ stat -c '%a %A' book_list.txt
220 --w--w----
```

**21)** Change the permissions of `test_dir` to match the output of the second `stat` command shown below. Don't use the number `757`, specify the changes in terms of `rwx` characters.

```bash
$ mkdir test_dir
$ stat -c '%a %A' test_dir
775 drwxrwxr-x

$ chmod g-w,o+w test_dir
$ stat -c '%a %A' test_dir
757 drwxr-xrwx
```

<br>

## Managing Processes

**1)** How would you invoke a command to be executed in the background? And what would you do to push a job to the background after it has already been launched? What commands can you use to track active jobs?

* appending an `&` character to the command will execute it in the background
* `Ctrl+z` (suspend the current running job) followed by `bg` (push the recently suspended job to the background)
* `jobs` or `ps` will help to track active jobs

**2)** What do the `+` and `-` symbols next to job numbers indicate?

From `info bash` (section *Job Control Basics*):

>In output pertaining to jobs (e.g., the output of the `jobs`
>command), the current job is always flagged with a `+`, and the previous
>job with a `-`.

**3)** When would you use `fg %n` and `bg %n` instead of just `fg` and `bg` respectively?

From `info bash` (section *Job Control Basics*):

>There are a number of ways to refer to a job in the shell.  The
>character `%` introduces a job specification (JOBSPEC).
>
>Job number `n` may be referred to as `%n`.

**4)** Which option will help you customize the output fields needed for the `ps` command?

>`-o format`
>
>User-defined format.  format is a single argument in the form of a
>blank-separated or comma-separated list, which offers a way to
>specify individual output columns.

**5)** What's the difference between `pgrep -a` and `pgrep -l` options?

>`-a, --list-full`
>
>List  the  full  command  line  as  well as the process ID.
>
>`-l, --list-name`
>
>List the process name as well as the process ID.

**6)** If the job number is `2`, would you use `kill %2` or `kill 2` to send `SIGTERM` to that process?

`kill %2`

**7)** Which signal does the `Ctrl+c` shortcut send to the currently running process?

Pressing `Ctrl+c` sends the `SIGINT` (`2`) signal, usually used to abort a process.

**8)** Which command helps you to continuously monitor processes, along with details like PID, memory usage, etc?

`top` (or alternatives like `btop` and `htop`)

**9)** Which key will help you manipulate kill tasks from within the `top` session?

`k`

**10)** What does the `free` command do?

```bash
$ whatis free
free (1)             - Display amount of free and used memory in the system
```

<br>

## Multipurpose Text Processing Tools

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises.

**1)** Replace all occurrences of `0xA0` with `0x50` and `0xFF` with `0x7F` for the given input.

```bash
$ printf 'a1:0xA0, a2:0xA0A1\nb1:0xFF, b2:0xBE\n'
a1:0xA0, a2:0xA0A1
b1:0xFF, b2:0xBE

$ printf 'a1:0xA0, a2:0xA0A1\nb1:0xFF, b2:0xBE\n' | sed 's/0xA0/0x50/g; s/0xFF/0x7F/g'
a1:0x50, a2:0x50A1
b1:0x7F, b2:0xBE
```

**2)** Remove only the third line from the given input.

```bash
$ seq 34 37 | sed '3d'
34
35
37

# alternate solutions
$ seq 34 37 | awk 'NR!=3'
$ seq 34 37 | perl -ne 'print if $.!=3'
```

**3)** For the input file `sample.txt`, display all lines that contain `it` but not `do`.

```bash
$ sed -n '/it/{/do/!p}' sample.txt
 7) Believe it

# alternate solutions
$ awk '/it/ && !/do/' sample.txt
$ perl -ne 'print if /it/ && !/do/' sample.txt
```

**4)** For the input file `purchases.txt`, delete all lines containing `tea`. Also, replace all occurrences of `coffee` with `milk`. Write back the changes to the input file itself. The original contents should get saved to `purchases.txt.orig`. Afterwards, restore the contents from this backup file.

```bash
# make the changes
$ sed -i.orig '/tea/d; s/coffee/milk/g' purchases.txt

$ ls purchases*
purchases.txt  purchases.txt.orig
$ cat purchases.txt
milk
washing powder
milk
toothpaste
soap

# restore the contents
$ mv purchases.txt.orig purchases.txt
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

# alternate solutions
$ sed -i.orig -n '/tea/b; s/coffee/milk/g; p' purchases.txt
$ perl -i.orig -pe '$_="" if /tea/; s/coffee/milk/g' purchases.txt
$ perl -i.orig -ne 'next if /tea/; s/coffee/milk/g; print' purchases.txt
```

**5)** For the input file `sample.txt`, display all lines from the start of the file till the first occurrence of `are`.

```bash
$ sed '/are/q' sample.txt
 1) Hello World
 2) 
 3) Hi there
 4) How are you

# alternate solutions
$ awk '1; /are/{exit}' sample.txt
$ perl -ne 'print; exit if /are/' sample.txt
```

**6)** Delete all groups of lines from a line containing `start` to a line containing `end` for the `uniform.txt` input file.

```bash
$ sed '/start/,/end/d' uniform.txt
mango
icecream
how are you
have a nice day
par,far,mar,tar

# alternate solutions
$ awk '/start/{f=1} !f; /end/{f=0}' uniform.txt
$ perl -ne '$f=1 if /start/; print if !$f; $f=0 if /end/' uniform.txt
```

**7)** Replace all occurrences of `42` with `[42]` unless it is at the edge of a word.

```bash
$ echo 'hi42bye nice421423 bad42 cool_4242a 42c' | sed 's/\B42\B/[&]/g'
hi[42]bye nice[42]1[42]3 bad42 cool_[42][42]a 42c
```

**8)** Replace all whole words with `X` that start and end with the same word character.

```bash
# can also use: sed -E 's/\b(\w|(\w)\w*\2)\b/X/g'
$ echo 'oreo not a _oh_ pip RoaR took 22 Pop' | sed -E 's/\b(\w)(\w*\1)?\b/X/g'
X not X X X X took X Pop
```

**9)** For the input file `anchors.txt`, convert markdown anchors to hyperlinks as shown below.

```bash
$ cat anchors.txt
# <a name="regular-expressions"></a>Regular Expressions
## <a name="subexpression-calls"></a>Subexpression calls
## <a name="the-dot-meta-character"></a>The dot meta character

$ sed -E 's|[^"]+"([^"]+)"></a>(.+)|[\2](#\1)|' anchors.txt
[Regular Expressions](#regular-expressions)
[Subexpression calls](#subexpression-calls)
[The dot meta character](#the-dot-meta-character)
```

**10)** Replace all occurrences of `e` with `3` except the first two matches.

```bash
$ echo 'asset sets tests site' | sed 's/e/3/3g'
asset sets t3sts sit3

$ echo 'sample item teem eel' | sed 's/e/3/3g'
sample item t33m 33l
```

**11)** The below sample strings use `,` as the delimiter and the field values can be empty as well. Use `sed` to replace only the third field with `42`.

```bash
$ echo 'lion,,ant,road,neon' | sed 's/[^,]*/42/3'
lion,,42,road,neon

$ echo ',,,' | sed 's/[^,]*/42/3'
,,42,
```

**12)** For the input file `table.txt`, calculate and display the product of numbers in the last field of each line. Consider space as the field separator for this file.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

$ awk 'BEGIN{p = 1} {p *= $NF} END{print p}' table.txt
-923.16

# alternate solutions
$ perl -lane 'BEGIN{$p = 1} {$p *= $F[-1]} END{print $p}' table.txt
```

**13)** Extract the contents between `()` or `)(` from each of the input lines. Assume that the `()` characters will be present only once every line.

```bash
$ printf 'apple(ice)pie\n(almond)pista\nyo)yoyo(yo\n'
apple(ice)pie
(almond)pista
yo)yoyo(yo

$ printf 'apple(ice)pie\n(almond)pista\nyo)yoyo(yo\n' | awk -F'[()]' '{print $2}'
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

$ awk -F, '{print $1 ":" $3}' scores.csv
Name:Physics
Ith:100
Cy:98
Lin:83

# alternate solutions
$ awk -F, -v OFS=: '{print $1, $3}' scores.csv
$ perl -F, -lane 'print "$F[0]:$F[2]"' scores.csv
$ perl -F, -lane 'print join ":", @F[0,2]' scores.csv
```

**15)** Extract and display the third and first words in the format shown below.

```bash
$ echo '%whole(Hello)--{doubt}==ado==' | awk -v FPAT='\\w+' '{print $3 ":" $1}'
doubt:whole

$ echo 'just,\joint*,concession_42<=nice' | awk -v FPAT='\\w+' '{print $3 ":" $1}'
concession_42:just

# alternate solutions
$ echo '%whole(Hello)--{doubt}==ado==' | perl -lne '@F = /\w+/g; print "$F[2]:$F[0]"'
$ echo 'just,\joint*,concession_42<=nice' | perl -lne '@F = /\w+/g; print "$F[2]:$F[0]"'
```

**16)** For the input file `scores.csv`, add another column named **GP** which is calculated out of 100 by giving 50% weightage to Maths and 25% each for Physics and Chemistry.

```bash
$ awk -F, -v OFS=, '{$(NF+1) = NR==1 ? "GP" : ($2/2 + ($3+$4)/4)} 1' scores.csv
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

$ awk -v RS= '/[0-9]/' para.txt
2 apples
12 bananas
```

**18)** Input has the ASCII NUL character as the record separator. Change it to dot and newline characters as shown below.

```bash
$ printf 'apple\npie\0banana\ncherry\0' | awk -v RS='\0' -v ORS='.\n' '1'
apple
pie.
banana
cherry.
```

**19)** For the input file `sample.txt`, print a matching line containing `do` only if `you` is found two lines before. For example, if `do` is found on line number 10 and the 8th line contains `you`, then the 10th line should be printed.

```bash
$ awk 'p2 ~ /you/ && /do/; {p2=p1; p1=$0}' sample.txt
 6) Just do-it

# alternate solutions
$ perl -ne 'print if $p2 =~ /you/ && /do/; $p2=$p1; $p1=$_' sample.txt
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

$ awk -v n=1 '$0 == "%=%="{c++} c==n' blocks.txt
%=%=
apple
banana
$ awk -v n=2 '$0 == "%=%="{c++} c==n' blocks.txt
%=%=
brown
green
```

**21)** Display lines present in `c1.txt` but not in `c2.txt` using the `awk` command.

```bash
$ awk 'NR==FNR{a[$0]; next} !($0 in a)' c2.txt c1.txt
Brown
Purple
Teal
```

**22)** Display lines from `scores.csv` by matching the first field based on a list of names from the `names.txt` file.

```bash
$ printf 'Ith\nLin\n' > names.txt

$ awk -F, 'NR==FNR{a[$1]; next} $1 in a' names.txt scores.csv
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

$ awk -F, '!seen[$NF]++' duplicates.txt
brown,toy,bread,42
dark red,ruby,rose,111
blue,ruby,water,333
dark red,sky,rose,555

# alternate solutions
$ perl -F, -lane 'print if !$seen{$F[-1]}++' duplicates.txt
```

**24)** For the input file `table.txt`, print input lines if the second field starts with `b`. Construct solutions using `awk` and `perl`.

```bash
$ awk '$2 ~ /^b/' table.txt
brown bread mat hair 42
yellow banana window shoes 3.14

$ perl -lane 'print if $F[1] =~ /^b/' table.txt
brown bread mat hair 42
yellow banana window shoes 3.14
```

**25)** For the input file `table.txt`, retain only the second last field. Write back the changes to the input file itself. The original contents should get saved to `table.txt.bkp`. Afterwards, restore the contents from this backup file.

```bash
# make the changes
$ perl -i.bkp -lane 'print $F[-2]' table.txt
$ ls table*
table.txt  table.txt.bkp
$ cat table.txt
hair
shirt
shoes

# restore the contents
$ mv table.txt.bkp table.txt
$ ls table*
table.txt
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14
```

**26)** Reverse the first field contents of `table.txt` input file.

```bash
$ perl -lane '$F[0] = reverse $F[0]; print "@F"' table.txt
nworb bread mat hair 42
eulb cake mug shirt -7
wolley banana window shoes 3.14
```

**27)** Sort the given comma separated input lexicographically. Change the output field separator to a `:` character.

```bash
$ ip='floor,bat,to,dubious,four'
$ echo "$ip" | perl -F, -lane 'print join ":", sort @F'
bat:dubious:floor:four:to
```

**28)** Filter fields containing digit characters.

```bash
$ ip='5pearl 42 east 1337 raku_6 lion 3.14'
$ echo "$ip" | perl -lane 'print join " ", grep {/\d/} @F'
5pearl 42 1337 raku_6 3.14
```

**29)** The input shown below has several words ending with digit characters. Change the words containing `test` to match the output shown below. That is, renumber the matching portions to `1`, `2`, etc. Words not containing `test` should not be changed.

```bash
$ ip='test_12:test123\nanother_test_4,no_42\n'
$ printf '%b' "$ip"
test_12:test123
another_test_4,no_42

$ printf '%b' "$ip" | perl -pe 's/test\w*?\K\d+/++$i/ge'
test_1:test2
another_test_3,no_42
```

**30)** For the input file `table.txt`, change contents of the third field to all uppercase. Construct solutions using `sed`, `awk` and `perl`.

```bash
$ sed 's/[^ ]*/\U&/3' table.txt
brown bread MAT hair 42
blue cake MUG shirt -7
yellow banana WINDOW shoes 3.14

$ awk '{$3 = toupper($3)} 1' table.txt
brown bread MAT hair 42
blue cake MUG shirt -7
yellow banana WINDOW shoes 3.14

$ perl -lane '$F[2] = uc $F[2]; print "@F"' table.txt
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
$ printf '100\n10\n20\n3000\n2.45\n' | sort -n
2.45
10
20
100
3000
```

**2)** Which `sort` option will help you ignore case?

```bash
$ printf 'Super\nover\nRUNE\ntea\n' | LC_ALL=C sort -f
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
$ printf '+120\n-1.53\n3.14e+4\n42.1e-2' | sort -g
-1.53
42.1e-2
+120
3.14e+4
```

>`-g, --general-numeric-sort`
>
>compare according to general numerical value

**4)** Sort the `scores.csv` file numerically in ascending order using the contents of the second field. Header line should be preserved as the first line as shown below. *Hint*: see the [Shell Features](./shell-features.md) chapter.

```bash
$ (sed -u '1q' ; sort -t, -k2,2n) < scores.csv
Name,Maths,Physics,Chemistry
Lin,78,83,80
Cy,97,98,95
Ith,100,100,100
```

**5)** Sort the contents of `duplicates.txt` by the fourth column numbers in descending order. Retain only the first copy of lines with the same number.

```bash
$ sort -t, -k4,4nr -u duplicates.txt
dark red,sky,rose,555
blue,ruby,water,333
dark red,ruby,rose,111
brown,toy,bread,42
```

**6)** Will `uniq` throw an error if the input is not sorted? What do you think will be the output for the following input?

`uniq` doesn't necessarily require the input to be sorted. Adjacent lines are used for comparison purposes.

```bash
$ printf 'red\nred\nred\ngreen\nred\nblue\nblue' | uniq
red
green
red
blue
```

**7)** Retain only the unique entries based on the first two characters of the input lines. Sort the input if necessary.

```bash
$ printf '3) cherry\n1) apple\n2) banana\n1) almond\n'
3) cherry
1) apple
2) banana
1) almond

$ printf '3) cherry\n1) apple\n2) banana\n1) almond\n' | sort | uniq -u -w2
2) banana
3) cherry
```

**8)** Count the number of times input lines are repeated and display the results in the format shown below.

```bash
$ printf 'brown\nbrown\nbrown\ngreen\nbrown\nblue\nblue' | sort | uniq -c | sort -n
      1 green
      2 blue
      4 brown
```

**9)** Display lines present in `c1.txt` but not in `c2.txt` using the `comm` command. Assume that the input files are already sorted.

```bash
# can also use: comm -13 c2.txt c1.txt
$ comm -23 c1.txt c2.txt
Brown
Purple
Teal
```

**10)** Use appropriate options to get the expected output shown below.

```bash
# wrong usage, no output
$ join <(printf 'apple 2\nfig 5') <(printf 'Fig 10\nmango 4')

# expected output
$ join -i <(printf 'apple 2\nfig 5') <(printf 'Fig 10\nmango 4')
fig 5 10
```

**11)** What are the differences between `sort -u` and `uniq -u` options, if any?

`sort -u` retains first copy of duplicates deemed to be equal. `uniq -u` retains only the unique copies (i.e. not even a single copy of the duplicates will be part of the output).

<br>

## Comparing Files

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises.

**1)** Which `cmp` option would you use if you just need the exit status reflecting whether the given inputs are same or not?

>`-s, --quiet, --silent`
>
>suppress all normal output

**2)** Which `cmp` option would you use to skip the initial bytes for comparison purposes? The below example requires you to skip the first two bytes.

```bash
$ echo '1) apple' > x1.txt
$ echo '2. apple' > x2.txt
$ cmp x1.txt x2.txt
x1.txt x2.txt differ: byte 1, line 1

$ cmp -i2 x1.txt x2.txt
$ echo $?
0

$ rm x[12].txt
```

>`-i, --ignore-initial=SKIP`
>
>skip first SKIP bytes of both inputs

**3)** What does the `diff -d` option do?

>`-d, --minimal`
>
>try hard to find a smaller set of changes

**4)** Which option will help you get colored output with `diff`?

>`--color[=WHEN]`
>
>colorize  the output; WHEN can be `never`, `always`, or `auto` (the
>default)

**5)** Use appropriate options to get the desired output shown below.

```bash
# instead of this output
$ diff -W 40 --suppress-common-lines -y f1.txt f2.txt
2                  |    hello
world              |    4

# get this output
$ diff -W 40 --left-column -y f1.txt f2.txt
1                  (
2                  |    hello
3                  (
world              |    4
```

>`--left-column`
>
>output only the left column of common lines

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
$ diff -si d1.txt d2.txt
Files d1.txt and d2.txt are identical

$ rm d[12].txt
```

<br>

## Assorted Text Processing Tools

>![info](../images/info.svg) Use the [example_files/text_files](https://github.com/learnbyexample/cli-computing/tree/master/example_files/text_files) directory for input files used in the following exercises.

**1)** Generate the following sequence.

```bash
$ seq 100 -5 80
100
95
90
85
80
```

**2)** Is the sequence shown below possible to generate with `seq`? If so, how?

```bash
$ seq -w -s, 01.5 6
01.5,02.5,03.5,04.5,05.5
```

**3)** Display three random words from `/usr/share/dict/words` (or an equivalent dictionary word file) containing `s` and `e` and `t` in any order. The output shown below is just an example.

```bash
# can also use: grep 's' /usr/share/dict/words | grep 'e' | grep 't' | shuf -n3
$ grep -P '^(?=.*s)(?=.*e).*t' /usr/share/dict/words | shuf -n3
supplemental
foresight
underestimates
```

**4)** Briefly describe the purpose of the `shuf` command options `-i`, `-e` and `-r`.

>`-i, --input-range=LO-HI`
>
>treat each number LO through HI as an input line
>
>`-e, --echo`
>
>treat each ARG as an input line
>
>`-r, --repeat`
>
>output lines can be repeated

**5)** Why does the below command not work as expected? What other tools can you use in such cases?

`cut` ignores all repeated fields and output field order always follows the same order as input fields.

```bash
# not working as expected
$ echo 'apple,banana,cherry,dates' | cut -d, -f3,1,3
apple,cherry

# expected output
$ echo 'apple,banana,cherry,dates' | awk -F, -v OFS=, '{print $3, $1, $3}'
cherry,apple,cherry

# alternate solutions
$ echo 'apple,banana,cherry,dates' | perl -F, -lane 'print join ",", @F[2,0,2]'
```

**6)** Display except the second field in the format shown below. Can you construct two different solutions?

```bash
$ echo 'apple,banana,cherry,dates' | cut -d, --output-delimiter=' ' -f1,3-
apple cherry dates

$ echo '2,3,4,5,6,7,8' | cut -d, --output-delimiter=' ' --complement -f2
2 4 5 6 7 8
```

**7)** Extract the first three characters from the input lines as shown below. Can you also use the `head` command for this purpose? If not, why not?

```bash
$ printf 'apple\nbanana\ncherry\ndates\n' | cut -c-3
app
ban
che
dat
```

`head` cannot be used because it acts on the input as a whole, whereas `cut` works line wise.

**8)** Display only the first and third columns of the `scores.csv` input file in the format as shown below. Note that only space characters are present between the two columns, not tab.

```bash
$ cat scores.csv
Name,Maths,Physics,Chemistry
Ith,100,100,100
Cy,97,98,95
Lin,78,83,80

$ cut -d, -f1,3 scores.csv | column -s, -t
Name  Physics
Ith   100
Cy    98
Lin   83
```

**9)** Display the contents of `table.txt` in the format shown below.

```bash
$ column -t table.txt
brown   bread   mat     hair   42
blue    cake    mug     shirt  -7
yellow  banana  window  shoes  3.14
```

**10)** Implement [ROT13](https://en.wikipedia.org/wiki/ROT13) cipher using the `tr` command.

```bash
$ echo 'Hello World' | tr 'a-zA-Z' 'n-za-mN-ZA-M'
Uryyb Jbeyq

$ echo 'Uryyb Jbeyq' | tr 'a-zA-Z' 'n-za-mN-ZA-M'
Hello World
```

**11)** Retain only alphabets, digits and whitespace characters.

```bash
$ echo 'Apple_42 cool,blue Dragon:army' | tr -dc '[:alnum:][:space:]'
Apple42 coolblue Dragonarmy
```

**12)** Use `tr` to get the output shown below.

```bash
$ echo '!!hhoowwww !!aaaaaareeeeee!! yyouuuu!!' | tr -sd '!' 'a-z'
how are you
```

**13)** `paste -s` works separately for multiple input files. How would you workaround this if you needed to treat all the input files as a single source?

```bash
# this works individually for each input file
$ paste -sd, fruits.txt ip.txt
banana,papaya,mango
deep blue,light orange,blue delight

# expected output
$ cat fruits.txt ip.txt | paste -sd,
banana,papaya,mango,deep blue,light orange,blue delight

# alternate solutions
$ awk '{printf s $0; s=","} END{print ""}' fruits.txt ip.txt
```

**14)** Use appropriate options to get the expected output shown below.

```bash
# default output
$ paste fruits.txt ip.txt
banana  deep blue
papaya  light orange
mango   blue delight

# expected output
$ paste -d'\n' fruits.txt ip.txt
banana
deep blue
papaya
light orange
mango
blue delight
```

**15)** Use the `pr` command to get the expected output shown below.

```bash
$ seq -w 16 | pr -4ats,
01,02,03,04
05,06,07,08
09,10,11,12
13,14,15,16

$ seq -w 16 | pr -4ts,
01,05,09,13
02,06,10,14
03,07,11,15
04,08,12,16
```

**16)** Use the `pr` command to join the input files `fruits.txt` and `ip.txt` as shown below.

```bash
$ pr -mts' : ' fruits.txt ip.txt
banana : deep blue
papaya : light orange
mango : blue delight
```

**17)** The `cut` command doesn't support a way to choose the last `N` fields. Which tool presented in this chapter can be combined to work with `cut` to get the output shown below?

```bash
# last two characters from each line
$ printf 'apple\nbanana\ncherry\ndates\n' | rev | cut -c-2 | rev
le
na
ry
es

# alternate solutions
$ printf 'apple\nbanana\ncherry\ndates\n' | grep -o '..$'
```

**18)** Go through the `split` documentation and use appropriate options to get the output shown below for the input file `purchases.txt`.

```bash
# split input by 3 lines (max) at a time
$ split -l3 purchases.txt

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

>`-l, --lines=NUMBER`
>
>put NUMBER lines/records per output file

**19)** Go through the `split` documentation and use appropriate options to get the output shown below.

```bash
$ echo 'apple,banana,cherry,dates' | split -t, -l1

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

>`-t, --separator=SEP`
>
>use SEP instead of newline as the  record  separator;  `\0`  (zero)
>specifies the NUL character

**20)** Split the input file `purchases.txt` such that the text before a line containing `powder` is part of the first file and the rest are part of the second file as shown below.

```bash
$ csplit -q purchases.txt '/powder/'

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

$ tr ',' '\n' <scores.csv | pr -$(wc -l <scores.csv)ts,
Name,Ith,Cy,Lin
Maths,100,97,78
Physics,100,98,83
Chemistry,100,95,80

# alternate solution if you have GNU datamash installed
$ datamash -t, transpose <scores.csv
```

See also my blog post [CLI computation with GNU datamash](https://learnbyexample.github.io/cli-computation-gnu-datamash/).

**22)** Reshape the contents of `table.txt` to the expected output shown below.

```bash
$ cat table.txt
brown bread mat hair 42
blue cake mug shirt -7
yellow banana window shoes 3.14

$ xargs -a table.txt -n4 | column -t
brown   bread  mat     hair
42      blue   cake    mug
shirt   -7     yellow  banana
window  shoes  3.14
```

<br>

## Shell Scripting

>![info](../images/info.svg) Use a temporary working directory before attempting the exercises. You can delete such practice directories afterwards.

**1)** What's wrong with the script shown below? Also, will the error go away if you use `bash try.sh` instead?

`!#` should be `#!`. If you get confused which one should be used, remember that shebang is a **comment** that is treated specially at the start of the script. And no, the error won't go away if you call the script using the `bash` command.

```bash
$ printf '    \n!#/bin/bash\n\necho hello\n' > try.sh
$ chmod +x try.sh
$ ./try.sh
./try.sh: line 2: !#/bin/bash: No such file or directory
hello

# expected output
$ printf '    \n#!/bin/bash\n\necho hello\n' > try.sh
$ ./try.sh
hello
```

**2)** Will the command shown below work? If so, what would be the output?

Yes, it will work. `echo hello` is being passed as the script to be executed by the `bash` command.

```bash
$ echo echo hello | bash
hello
```

**3)** When would you `source` a script instead of using `bash` or creating an executable using shebang?

Using `source` to execute scripts helps when you want to work within the current shell environment instead of a sub-shell.

**4)** How would you display the contents of a variable with `shake` appended?

```bash
$ fruit='banana'

$ echo "${fruit}shake"
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
$ declare -i n=100
$ n+=100
$ echo "$n"
200
```

**6)** Is the following code valid? If so, what would be the output of the `echo` command?

Yes, it is valid. Array index can be arbitrarily used, they do not have to be contiguous.

```bash
$ declare -a colors
$ colors[3]='green'
$ colors[1]='blue'

$ echo "${colors[@]}"
blue green
```

**7)** How would you get the last three characters of a variable's contents?

```bash
$ fruit='banana'

$ echo "${fruit: -3}"
ana
```

**8)** Will the second `echo` command give an error? If not, what will be the output?

No error. It will give the length of the element at index `0`.

```bash
$ fruits=('apple' 'fig' 'mango')
$ echo "${#fruits[@]}"
3

$ echo "${#fruits}"
5
```

**9)** For the given array, use parameter expansion to remove characters until the first/last space.

```bash
$ colors=('green' 'dark brown' 'deep sky blue white')

# remove till the first space
$ printf '%s\n' "${colors[@]#* }"
green
brown
sky blue white

# remove till the last space
$ printf '%s\n' "${colors[@]##* }"
green
brown
white
```

**10)** Use parameter expansion to get the expected outputs shown below.

```bash
$ ip='apple:banana:cherry:dragon'

$ echo "${ip%:*}"
apple:banana:cherry

$ echo "${ip%%:*}"
apple
```

**11)** Is it possible to achieve the expected outputs shown below using parameter expansion? If so, how?

Yes it is possible. For the second and third cases, `extglob` has to be enabled.

```bash
$ ip1='apple:banana:cherry:dragon'
$ ip2='Cradle:Mistborn:Piranesi'

$ echo "${ip1/:*:/ 42 }"
apple 42 dragon
$ echo "${ip2/:*:/ 42 }"
Cradle 42 Piranesi

$ shopt -s extglob
$ echo "${ip1/#+([^:])/fig}"
fig:banana:cherry:dragon
$ echo "${ip2/#+([^:])/fig}"
fig:Mistborn:Piranesi

$ echo "${ip1/%+([^:])/end}"
apple:banana:cherry:end
$ echo "${ip2/%+([^:])/end}"
Cradle:Mistborn:end
```

**12)** For the given input, change case as per the expected outputs shown below.

```bash
$ ip='This is a Sample STRING'

$ echo "${ip^^}"
THIS IS A SAMPLE STRING

$ echo "${ip,,}"
this is a sample string

$ echo "${ip~~}"
tHIS IS A sAMPLE string
```

**13)** Why does the conditional expression shown below fail?

```bash
$ touch ip.txt
$ [[-f ip.txt]] && echo 'file exists'
[[-f: command not found

# need to use space after [[ and before ]]
$ [[ -f ip.txt ]] && echo 'file exists'
file exists
```

**14)** What is the difference between the `==` and `=~` string comparison operators?

* `s1 = s2` or `s1 == s2` checks if two strings are equal
    * unquoted portions of `s2` will be treated as a wildcard while testing against `s1`
* `s1 =~ s2` checks if `s1` matches the POSIX extended regular expression provided by `s2`

**15)** Why does the conditional expression used below show `failed` both times? Modify the expressions such that the first one correctly says `matched` instead of `failed`.

Quoted portions will be treated as literal strings. Wildcards should be unquoted.

```bash
$ f1='1234.txt'
$ f2='report_2.txt'

$ [[ $f1 == '+([0-9]).txt' ]] && echo 'matched' || echo 'failed'
failed
$ [[ $f2 == '+([0-9]).txt' ]] && echo 'matched' || echo 'failed'
failed

# corrected code
$ [[ $f1 == +([0-9]).txt ]] && echo 'matched' || echo 'failed'
matched
$ [[ $f2 == +([0-9]).txt ]] && echo 'matched' || echo 'failed'
failed
```

**16)** Extract the digits that follow a `:` character for the given variable contents.

```bash
$ item='chocolate:50'
$ [[ $item =~ :([0-9]+) ]] && echo "${BASH_REMATCH[1]}"
50

$ item='50 apples, fig:100, books-12'
$ [[ $item =~ :([0-9]+) ]] && echo "${BASH_REMATCH[1]}"
100
```

**17)** Modify the expression shown below to correctly report `true` instead of `false`.

```bash
$ num=12345
$ [[ $num > 3 ]] && echo 'true' || echo 'false'
false

# corrected code
$ [[ $num -gt 3 ]] && echo 'true' || echo 'false'
true

# alternate solutions
$ (( num > 3 )) && echo 'true' || echo 'false'
```

**18)** Write a shell script named `array.sh` that accepts array input from the user followed by another input as index. Display the corresponding value at that index. Couple of examples are shown below.

```bash
$ cat array.sh
read -p 'enter array elements: ' -a arr
read -p 'enter array index: ' idx
echo "element at index '$idx' is: ${arr[$idx]}"

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
$ cat case.sh
if (( $# != 2 )) ; then
    echo 'Error! Two arguments expected.' 1>&2
    exit 1
else
    if [[ $1 == 'upper' ]] ; then
        echo "${2^^}"
    elif [[ $1 == 'lower' ]] ; then
        echo "${2,,}"
    elif [[ $1 == 'swap' ]] ; then
        echo "${2~~}"
    else
        echo "Error! '$1' command not recognized." 1>&2
        exit 1
    fi
fi

$ chmod +x case.sh

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

$ cat loop.sh
for file in "$@"; do
    echo "number of lines in '$file' is:" $(wc -l < "$file")
done

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

$ cat read_file.sh
while IFS= read -r line; do
    paste -sd, "$line"
done < "$1"

$ bash read_file.sh list.txt
apple,banana,cherry
dragon,owl,unicorn,troll,centaur

# note that -n1 is not necessary here due to how paste works for multiple files
# but -n1 is necessary to be equivalent to the shell script shown above
$ xargs -a list.txt -d'\n' -n1 paste -sd,
apple,banana,cherry
dragon,owl,unicorn,troll,centaur
```

**22)** Write a function named `add_path` which prefixes the path of the current working directory to the arguments it receives and displays the results. Examples are shown below.

```bash
$ add_path() { echo "${@/#/$PWD/}" ; }

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

>`-x`
>
>Print commands and their arguments as they are executed.
>
>`-v`
>
>Print shell input lines as they are read.

**24)** What is `shellcheck` and when would you use it?

[shellcheck](https://www.shellcheck.net/) is a static analysis tool that gives warnings and suggestions for scripts.

From `man shellcheck`:

>ShellCheck  is  a  static  analysis  and linting tool for sh/bash scripts.
>It’s mainly focused on handling typical beginner  and  intermediate  level
>syntax errors and pitfalls where the shell just gives a cryptic error message
>or strange behavior, but it also reports on a few more  advanced  issues
>where corner cases can cause delayed failures.

<br>

## Shell Customization

**1)** Which command would you use to display the name and value of all or specific environment variables?

```bash
$ whatis printenv
printenv (1)         - print all or part of environment
```

**2)** If you add an alias for an already existing command (`ls` for example), how would you invoke the original command instead of the alias?

By prefixing `\` or using the `command` builtin. For example, `\ls` or `command ls`.

**3)** Why doesn't the alias shown below work? What would you use instead?

You cannot pass arguments to aliases, need to use functions instead.

```bash
# doesn't work as expected
$ alias ext='echo "${1##*.}"'
$ ext ip.txt
 ip.txt

# expected output
$ ext() { echo "${1##*.}" ; }
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
$ unalias hw
$ hw
hw: command not found

$ hw() { echo hello there ; }
$ hw
hello there
$ unset -f hw
$ hw
hw: command not found
```

**5)** Write an alias and a function to display the contents of the `PATH` environment variable on separate lines by changing `:` to the newline character. Sample output is shown below.

```bash
$ echo "$PATH"
/usr/local/bin:/usr/bin:/bin:/usr/games

# alias
$ alias a_p='echo "$PATH" | tr ":" "\n"'
$ a_p
/usr/local/bin
/usr/bin
/bin
/usr/games

# function
$ f_p() { echo "${PATH//:/$'\n'}" ; }
$ f_p
/usr/local/bin
/usr/bin
/bin
/usr/games
```

**6)** Will a login shell read and execute `~/.bashrc` automatically?

No. From `info bash`:

>When an interactive shell that is not a login shell is started, Bash
>reads and executes commands from '~/.bashrc', if that file exists.

See also [unix.stackexchange: why does bashrc check whether the current shell is interactive?](https://unix.stackexchange.com/q/257571/109046)

**7)** What should be the value assigned to `HISTSIZE` if you wish to have unlimited history entries?

Any negative number.

>`HISTSIZE`
>
>The maximum number of commands to remember on the history list.  If
>the value is 0, commands are not saved in the history list.
>Numeric values less than zero result in every command being saved
>on the history list (there is no limit).  The shell sets the
>default value to 500 after reading any startup files.

**8)** What does the binding `set completion-ignore-case on` do?

>`completion-ignore-case`
>
>If set to `on`, Readline performs filename matching and
>completion in a case-insensitive fashion.  The default value
>is `off`.

**9)** Which shortcut helps you interactively search the command history?

>To search backward in the history for a particular string, type `C-r`.  Typing `C-s` searches forward through the history.

**10)** What do the shortcuts `Alt+b` and `Alt+f` do?

>`forward-word (M-f)`
>
>Move forward to the end of the next word.  Words are composed of
>letters and digits.
>
>`backward-word (M-b)`
>
>Move back to the start of the current or previous word.  Words are
>composed of letters and digits.

**11)** Are there differences between the `Ctrl+l` shortcut and the `clear` command?

`Ctrl+l` retains whatever is typed so far and doesn't try to remove the scrollback buffer altogether. You can use the `clear` command for that purpose.

**12)** Which shortcut will you use to delete characters before the cursor till the start of the line?

>`unix-line-discard (C-u)`
>
>Kill backward from the cursor to the beginning of the current line.

**13)** What do the shortcuts `Alt+t` and `Ctrl+t` do?

>`transpose-chars (C-t)`
>
>Drag the character before the cursor forward over the character at
>the cursor, moving the cursor forward as well.  If the insertion
>point is at the end of the line, then this transposes the last two
>characters of the line.  Negative arguments have no effect.
>
>`transpose-words (M-t)`
>
>Drag the word before point past the word after point, moving point
>past that word as well.  If the insertion point is at the end of
>the line, this transposes the last two words on the line.

**14)** Is there a difference between the `Shift+Insert` and `Shift+Ctrl+v` shortcuts?

* `Shift+Ctrl+v` pastes clipboard contents
* `Shift+Insert` pastes the last highlighted portion (not necessarily the clipboard contents)

