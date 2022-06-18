read -p 'Enter a search pattern: ' search

if grep -q "$search" hello.sh ; then
    echo "match found"
else
    echo "match not found"
fi
