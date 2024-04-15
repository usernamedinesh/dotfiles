#!/usr/bin/env bash
languages=`echo "go lua cpp c typescript js python" | tr ' ' '\n'`
core_utils=`echo "xargs mv awk sed grep find" | tr ' ' '\n'`
#
# selected=`printf "$languages\n$core_utils" | fzf`
#
# read -p "query: " query
#
# if printf $languages | grep -qs $selected; then
#     # tmux new bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
#      bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
# else
#     # tmux new bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
#      bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
# fi
#

#!/usr/bin/env bash


selected=$(printf "%s\n%s" "$languages" "$core_utils" | fzf)

read -p "query: " query

# Debug output
echo "Selected: $selected"
echo "Query: $query"

if printf "$languages" | grep -qs "$selected"; then
    url="cht.sh/$selected/$(echo "$query" | tr ' ' '+')"
else
    url="cht.sh/$selected~$query"
fi

# Debug output
echo "URL: $url"

# Fetch the cheat sheet
bash -c "curl $url & while [ : ]; do sleep 1; done"
