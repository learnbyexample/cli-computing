dir_name='globs_examples'
if [[ -e "$dir_name" ]] ; then
    cd "$dir_name"
    return
fi

mkdir "$dir_name" && cd $_

touch ip.txt notes.txt 42.txt
touch f1.txt f2.txt f2_old.txt f4.txt f7.txt
touch report-{98,0{0,2,4}}.log
touch calc.py hello.py hi.sh 100.sh
touch main.c math.h
touch .hidden .somerc
