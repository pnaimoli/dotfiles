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
cd "$(python2 -c "import sys, imp, os
path = sys.path
for i in '${1}'.split('.'): path = [imp.find_module(iath)[1],]
path = path[0] if os.path.isdir(path[0]) else os.path.dirname(path[0])
print path")"
}

function cdp3 () {
cd "$(python3 -c "import sys, imp, os
path = sys.path
for i in '${1}'.split('.'): path = [imp.find_module(iath)[1],]
path = path[0] if os.path.isdir(path[0]) else os.path.dirname(path[0])
print path")"
}
