dir_name='find_examples'
if [[ -e "$dir_name" ]] ; then
    cd "$dir_name"
    return
fi

mkdir "$dir_name" && cd $_

mkdir -p backups/dot_files projects/{.venv,tictactoe,calculator} todos
ln -s ../../scripts

printf 'long\nshot\n' > ip.txt
touch -a -d "$(date '+%Y-%m-%d %H:%M:%S' -d '-1 days')" ip.txt

printf '#!/usr/bin/python3\n\nprint("Hello World!")\n' > hello_world.py

printf '#!/bin/bash\n\necho hi\n' > hi.sh
touch -d "$(date '+%Y-%m-%d %H:%M:%S' -d '-10 days')" hi.sh

echo 'ghost' > .hidden
touch -d '2018-12-21 22:33:44' .hidden

</dev/urandom tr -cd '[:alnum:]_ \n' | head -c1234567 > report.log
</dev/urandom tr -cd '[:alnum:]_ \n' | head -c54321 > errors.log
touch -d '2022-01-01 01:01:01' report.log
touch -d '2022-01-01 03:30:33' errors.log

touch backups/bookmarks.html backups/{jan,aug}.log
touch backups/dot_files/{.bashrc,.inputrc,.vimrc}
touch projects/tictactoe/game.py projects/calculator/calc.sh
touch todos/{books,TRIP,wow}.txt

chmod +x hello_world.py hi.sh
