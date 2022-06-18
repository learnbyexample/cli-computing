for file in "$@"; do 
    echo mv "$file" "$file.bkp"
done
