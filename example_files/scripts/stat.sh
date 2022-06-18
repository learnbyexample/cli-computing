dir_name='stat_examples'
if [[ -e "$dir_name" ]] ; then
    cd "$dir_name"
    return
fi

mkdir "$dir_name" && cd $_

printf 'long\nshot\n' > ip.txt
touch -a -d '2022-06-01 13:25:18.693823117' ip.txt
touch -m -d '2022-05-24 14:39:41.285714934' ip.txt

ln -s /usr/share/dict/words words.txt

printf '#!/bin/bash\n\necho hi\n' > hi.sh
