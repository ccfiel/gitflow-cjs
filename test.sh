GIT_URL=$(git config --get remote.origin.url)
access_token="1234567890"
authenticated_git_url="${GIT_URL/\:\/\//://$access_token@}"
echo $authenticated_git_url
