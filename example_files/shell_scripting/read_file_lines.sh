while IFS= read -r line; do
    # do something with each line
    echo "$line"
done < "$1"
