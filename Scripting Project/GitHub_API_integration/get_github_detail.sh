#!/bin/bash
#################################################################################################
#This Script will help us to retrieve user details and repos detail that we have in our github  #
#################################################################################################

# GitHub access token
access_token=$1

#Read user name
echo "Enter the user name: "
read user_name

# GitHub API endpoint for a specific user
user_endpoint="https://api.github.com/users/${user_name}"

# GitHub API endpoint for a user's repositories
repo_endpoint="https://api.github.com/users/${user_name}/repos"

# Prompt User to select option
echo -e "Enter the Options to fetch detail \n 1.Userdetails \n 2.Repodetails"
read num

# Switch case condition
case $num in

[1])
# Send a GET request to the user endpoint
user_response=$(curl -s -H "Authorization: token $access_token" $user_endpoint)

# Get the user's information from the response
echo -e "\n"
user_name=$(echo  $user_response | jq -r .name)
user_login=$(echo $user_response | jq -r .login)
user_location=$(echo $user_response | jq -r .location)
bio=$(echo $user_response | jq -r .bio)

echo "User information:"
echo "Name: $user_name"
echo "Login: $user_login"
echo "Location: $user_location"
echo "Bio: $bio"
;;

[2])
# Send a GET request to the repository endpoint
repo_response=$(curl -s -H "Authorization: token $access_token" $repo_endpoint)
# Get the user's repositories from the response
repo_names=$(echo $repo_response | jq -r '.[].name')
echo -e "\n Repositories:"
for repo_name in $repo_names; do
    echo "- $repo_name"
done
;;

*)
echo "Please enter 1 or 2"
;;

esac

