dir_name='rm_examples'
if [[ -e "$dir_name" ]] ; then
    cd "$dir_name"
    return
fi

mkdir "$dir_name" && cd $_

mkdir -p reports projects/{tictactoe,calculator} empty_dir
touch hello.py loops.py read_only.txt reports/jan.log
touch projects/tictactoe/game.py projects/calculator/calc.sh
chmod -w read_only.txt

