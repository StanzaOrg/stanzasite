#USAGE: ./scripts/install-stanza.sh 0_13_26
if [ $# -lt 1 ]; then
    echo "Not enough arguments"
    exit 2
fi

CURRENT_DIR="`pwd`"
cd /Applications/stanza
rm -r *
unzip $CURRENT_DIR/resources/stanza/stanza_$1.zip 
