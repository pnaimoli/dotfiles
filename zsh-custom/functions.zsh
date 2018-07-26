# Easily swap two files
function swap()         
{
    if [ $# -eq 0 ]
    then
        echo "usage: swap filename1 filename2"
        return 1
    fi
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE $2
}

# https://chris-lamb.co.uk/2010/04/22/locating-source-any-python-module/
function cdp () {
    cd "$(python2.7 -c "import os.path as _, ${1}; \
            print(_.dirname(_.realpath(${1}.__file__[:-1])))"
        )"
}

function cdp3 () {
    cd "$(python3 -c "import os.path as _, ${1}; \
            print(_.dirname(_.realpath(${1}.__file__[:-1])))"
        )"
}
