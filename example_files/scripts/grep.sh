dir_name='grep_examples'
if [[ -e "$dir_name" ]] ; then
    cd "$dir_name"
    return
fi

mkdir "$dir_name" && cd $_

mkdir -p backups/dot_files projects/{python,shell}

printf 'teal\nlight blue\nbrown\nyellow\n' > colors_1
printf 'blue\nblack\ndark green\nyellow\n' > colors_2
printf 'ghost\nclear blue sky\n' > .hidden

echo 'print("Hello, Python!")' > projects/python/hello.py
echo 'echo "Hello, Bash!"' > projects/shell/hello.sh

printf 'alias p=pwd\nalias c=clear\n' > backups/dot_files/.bash_aliases
echo 'set completion-ignore-case on' > backups/dot_files/.inputrc
printf 'red\ngreen\nblue\n' > 'backups/color list.txt'

