# Add private key to ssh-agent
touch $PK_PATH
echo "$PK" > $PK_PATH

# Add the server to known_hosts
mkdir -p ~/.ssh
eval $(ssh-agent -s)
chmod 700 $PK_PATH
touch ~/.ssh/config