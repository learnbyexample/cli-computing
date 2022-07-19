while IFS= read -r line; do
    # do something with each line
    wc -l "$line"
done < "$1"
