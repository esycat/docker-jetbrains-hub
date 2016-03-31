# JetBrains Hub

[Hub](https://jetbrains.com/hub/) is a system that provides centralized authentication, authorization; users, groups, permissions and project management across multiple installations of [JetBrains](https://jetbrains.com/) team collaboration tools.

- Version: 1.0
- Build: 809

## Usage

```bash
NAME="jetbrains-hub"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
mkdir $DIR/data
chown 1000:1000 $DIR/data
docker run -d \
	-m 2g \
	-e BASE_URL=[your URL] \
	--name $NAME  \
	-p 8080:8080 \
	--restart=always \
	-v $DIR/data:/data
	seti/jetbrains-hub
```

## Credits
 - forked from esycat/jetbrains-hub
