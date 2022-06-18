while IFS=' : ' read -r field1 field2; do
    echo "$field2,$field1"
done < "$1"
