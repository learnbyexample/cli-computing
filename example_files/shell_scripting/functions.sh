add_border ()
{
    size='10'
    color='grey'
    if (( $# == 1 )) ; then
        ip="$1"
    elif (( $# == 2 )) ; then
        if [[ $1 =~ ^[0-9]+$ ]] ; then
            size="$1"
        else
            color="$1"
        fi
        ip="$2"
    else
        size="$1"
        color="$2"
        ip="$3"
    fi

    op="${ip%.*}_border.${ip##*.}"
    echo convert -border "$size" -bordercolor "$color" "$ip" "$op"
}

add_border flower.png
add_border 5 insect.png
add_border red lake.png
add_border 20 blue sky.png

