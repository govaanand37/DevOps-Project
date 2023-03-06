Hello All, so in this shell script, we will interact with the GitHub API to retrieve user and repository details.

using this script, we can get repository detail which is under a particular group or member

**Use Case:** Within an organization, we can use this script to create a repository report for the manager's view.

Refer to [GitHub API Documentation](https://docs.github.com/en/rest?apiVersion=2022-11-28)

### Pre-requisites:

* Access Key
    
* Script file
    

# Step1:Creating Access key in GitHub

* Firstly, go to your GitHub account
    
* open settings then under setting in the bottom left panel you can see developer settings select it
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678102491740/6a097a07-70ac-4f38-90e9-675034e9f21f.png align="left")

* Now under personal access tokens select tokens
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678102542920/58047416-2d59-4689-be16-a6f36bf30c9f.png align="left")

* click on generate a new token and select the classic option
    
* ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678102687215/3d5a7e5e-164c-4b44-b1bd-bb25a161c2b7.png align="center")
    
    Now it will prompt you with scopes, here we can provide some privileges for this token I'm giving few permissions for this particular token
    
* ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678102830124/c80b62f6-e9fe-4370-b1fe-8c506d3af050.png align="center")
    
    initially, I'm selecting repo scope then users scope
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678102867838/8ffe6348-cf9d-4cef-922e-11ee632f6b02.png align="center")

you can give scope whatever you wanted to do with this token and click on generate a token in the bottom, and it will provide you the hash code\[access key\] copy that and open your terminal put the access key in a variable called password\[(<mark>user defined) give whatever name you want for the variable, for understanding purpose I used the variable name as password</mark>\]

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678103152697/7c1f2b35-cd18-4d60-a647-920939c0340b.png align="center")

<mark>NOTE: never share this token with anyone since it's your private access token</mark>

# Step2: Script and explanation

```bash
#!/bin/bash
#############################################################################
# This Script will help us to retrieve user details and repos detail that we have in our github  
#############################################################################

# GitHub access token
access_token=$1

#Read user name
echo "Enter the user name: "
read user_name

# GitHub API endpoint for a specific user
user_endpoint="https://api.github.com/users/${user_name}"

# GitHub API endpoint for a user's repositories
repo_endpoint="https://api.github.com/users/${user_name}/repos"


echo -e "Enter the Options to fetch detail \n 1.Userdetails \n 2.Repodetails \n"
read num
case $num in
[1])

# Send a GET request to the user endpoint
user_response=$(curl -s -H "Authorization: token $access_token" $user_endpoint)

# Get the user's information from the response
user_name=$(echo  $user_response | jq -r .name)
user_login=$(echo $user_response | jq -r .login)
user_location=$(echo $user_response | jq -r .location)
bio=$(echo $user_response | jq -r .bio)

echo "User informations are:"
echo "Name: $user_name"
```

this is the entire shell script file.

The first two lines are shebang and a comment describes the purpose of this script.

```bash
access_token=$1
```

This line assigns the first argument passed to the script to the variable `access_token`. This argument is expected to be the GitHub access token.

```bash
echo "Enter the user name: "
read user_name
```

These two lines prompt the user to enter the GitHub username and read the input into the `user_name` variable.

```bash
user_endpoint="https://api.github.com/users/${user_name}"
repo_endpoint="https://api.github.com/users/${user_name}/repos"
```

These lines assign the API endpoints for the GitHub user and repository information to the `user_endpoint` and `repo_endpoint` variables, respectively.

```bash
echo -e "Enter the Options to fetch detail \n 1.Userdetails \n 2.Repodetails"
read num
```

These lines prompt the user to choose an option to fetch details, either user details or repository details, and read the input into the `num` variable.

```bash
case $num in
[1])
  # commands for option 1
  ;;
[2])
  # commands for option 2
  ;;
*)
  echo "Please enter 1 or 2"
  ;;
esac
```

This is a `case` statement that checks the value of the `num` variable and executes the corresponding commands for each option. If the user enters an invalid option, an error message is printed.

```bash
user_response=$(curl -s -H "Authorization: token $access_token" $user_endpoint)
```

This line uses the `curl` command to send a GET request to the GitHub API endpoint for the user information, with `The authorization` header set to the GitHub access token passed as the first argument to the script. The response is captured in the `user_response` variable.

```bash
user_name=$(echo $user_response | jq -r .name)
user_login=$(echo $user_response | jq -r .login)
user_location=$(echo $user_response | jq -r .location)
bio=$(echo $user_response | jq -r .bio)
```

The above lines use the `jq` command to extract the relevant user information from the `user_response` JSON data and assign it to corresponding variables.

So here I'm just filtering some JSON values, but by default we will get many values for this API call.

```bash
repo_response=$(curl -s -H "Authorization: token $access_token" $repo_endpoint)
repo_names=$(echo $repo_response | jq -r '.[].name')
```

The above lines use the `curl` commands to send a GET request to the GitHub API endpoint for the repository information and extract the names of the repositories into the `repo_names` variable using `jq` command

```bash
echo "User information:"
echo "Name: $user_name"
echo "Login: $user_login"
echo "Location: $user_location"
echo "Bio: $bio"
```

The above lines print the user information extracted earlier.

```bash
echo -e "\n Repositories:"
for repo_name in $repo_names; do
  echo "- $repo_name"
done
```

above lines print the list of repository names extracted earlier. The `for` loop iterates over each repository name and prints it with a bullet point prefix.

# Step3:How to use?

Create a script.sh file in your Linux terminal using `touch` like below and also provide execute access to that script using `chmod`

```bash
touch script.sh
sudo chmod +x script.sh
```

and open the script. sh and paste the script that I provided and save it

Now we have to run that script using the below command and here I'm providing my access key via a variable called password \[that we did initially\]

```bash
./script.sh $password
```

After executing the script using the above command, it will prompt the user to enter the username

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678104332340/6330ec97-9714-4e56-bb45-b3c97b099325.png align="center")

After entering the name, it will again prompt the user to select any one option to provide details if the user enters 1 they will get the user detail

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678104416711/51419b82-f39e-4139-8263-edbe01fa2466.png align="center")

If they choose 2, they will get information about what repositories the user has in his GitHub account.

<mark>Final note: This is a simple GitHub API integration script as we can do the same for Bitbucket, JIRA...etc., but the API endpoint will vary with a couple of values.</mark>