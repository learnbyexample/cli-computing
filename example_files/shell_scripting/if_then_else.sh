if (( $# != 1 )) ; then
    echo 'Error! One file argument expected.' 1>&2
    exit 1
else
    if [[ ! -f $1 ]] ; then
        printf 'Error! %q is not a valid file\n' "$1" 1>&2
        exit 1
    else
        echo "No. of lines in '$1' is $(wc -l < "$1")"
    fi
fi
