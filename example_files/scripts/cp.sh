dir_name='cp_examples'
if [[ -e "$dir_name" ]] ; then
    cd "$dir_name"
    return
fi

mkdir "$dir_name" && cd $_

mkdir -p backups/reports reference
echo 'apple banana cherry' > backups/ip.txt
touch backups/reports/jan.log
