dir_name='du_examples'
if [[ -e "$dir_name" ]] ; then
    cd "$dir_name"
    return
fi

mkdir "$dir_name" && cd $_

mkdir -p projects/scripts todos

</dev/urandom tr -cd '[:alnum:]_ \n' | head -c7654321 > report.log
</dev/urandom tr -cd '[:alnum:]_ \n' | head -c12345 > projects/errors.log
</dev/urandom tr -cd '[:alnum:]_ \n' | head -c22222 > projects/scripts/calc.sh
</dev/urandom tr -cd '[:alnum:]_ \n' | head -c3333 > todos/books.txt
