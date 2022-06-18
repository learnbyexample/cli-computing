dir_name='ls_examples'
if [[ -e "$dir_name" ]] ; then
    cd "$dir_name"
    return
fi

mkdir "$dir_name" && cd $_

mkdir -p backups/dot_files projects/{tictactoe,calculator} todos
ln -s ../../scripts

printf 'long\nshot\n' > ip.txt
touch -d '2017-07-21 10:11:44' ip.txt

printf '#!/usr/bin/python3\n\nprint("Hello World!")\n' > hello_world.py
touch -d '2020-02-29 20:20:20' hello_world.py

printf '#!/bin/bash\n\necho hi\n' > hi
touch -d '2019-12-05 15:10:05' hi

echo 'ghost' > .hidden
touch -d '2018-12-21 22:33:44' .hidden

</dev/urandom tr -cd '[:alnum:]_ \n' | head -c7654321 > report.log
</dev/urandom tr -cd '[:alnum:]_ \n' | head -c12345 > errors.log
touch -d '2022-01-01 01:01:01' report.log
touch -d '2022-01-01 03:30:33' errors.log

touch backups/bookmarks.html backups/dot_files/{.bashrc,.inputrc,.vimrc}
touch projects/tictactoe/game.py projects/calculator/calc.sh
touch todos/{books,outing}.txt

touch  -d '2022-02-04 09:23:25' backups
touch  -d '2022-03-05 11:21:27' projects
touch  -d '2022-04-06 13:19:29' todos
touch -hd '2022-05-07 15:17:31' scripts

chmod +x hello_world.py hi
