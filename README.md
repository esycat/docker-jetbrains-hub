# JetBrains Hub

[Hub](https://jetbrains.com/hub/) is a system that provides centralized authentication, authorization; users, groups, permissions and project management across multiple installations of [JetBrains](https://jetbrains.com/) team collaboration tools.

## Info
- Version 2.5 Build 330

## Usage

Pull the image, create a new container and start it:

```bash
docker pull seti/jetbrains-hub
docker run -d \
	--name jetbrains-hub  \
	-p 8080:8080 \
	--restart=always \
	-v HOST/DIR:/data
	seti/jetbrains-hub
```
