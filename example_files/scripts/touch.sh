dir_name='touch_examples'
if [[ -e "$dir_name" ]] ; then
    cd "$dir_name"
    return
fi

mkdir "$dir_name" && cd $_

printf 'apple\nbanana\ncherry\n' > fruits.txt
touch -a -d '2017-07-19 17:06:01.523308599' fruits.txt
touch -m -d '2017-07-13 13:54:03.576055933' fruits.txt

printf 'long\nshot\n' > ip.txt
touch -a -d '2022-06-01 13:25:18.693823117' ip.txt
touch -m -d '2022-05-24 14:39:41.285714934' ip.txt

printf '#!/bin/bash\n\necho hi\n' > hi.sh
touch -m -d '2022-06-14 13:00:46.170416890' hi.sh
