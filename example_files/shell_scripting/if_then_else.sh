if (( $# != 1 )) ; then
    echo 'Error! One file argument expected.' 1>&2
    exit 1
else
    if [[ ! -f $1 ]] ; then
        echo "Error! '$1' is not a valid file" 1>&2
        exit 1
    else
        echo "No. of lines in '$1' is $(wc -l < "$1")"
    fi
fi
