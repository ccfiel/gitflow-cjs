CURRENT_TAG="v0.0.2"
NUMERIC_TAG="${CURRENT_TAG//[!0-9.]/}"
IFS='.' read -ra array_tag <<< "$NUMERIC_TAG"
array_tag[1]=$((${array_tag[1]}+1))
TAGNAME="$(IFS=.; echo "${array_tag[*]}")"