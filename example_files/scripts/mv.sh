dir_name='mv_examples'
if [[ -e "$dir_name" ]] ; then
    cd "$dir_name"
    return
fi

mkdir "$dir_name" && cd $_

mkdir -p backups/projects dot_files manuals
touch hello.py loops.py ip.txt
touch backups/projects/game.py manuals/mv.info

