# JetBrains Hub
[![](https://images.microbadger.com/badges/image/esycat/jetbrains-hub.svg)](https://microbadger.com/images/esycat/jetbrains-hub "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/esycat/jetbrains-hub.svg)](https://microbadger.com/images/esycat/jetbrains-hub "Get your own version badge on microbadger.com")

[Hub](https://jetbrains.com/hub/) is a system that provides centralized authentication, authorization; users, groups, permissions and project management across multiple installations of [JetBrains](https://jetbrains.com/) team collaboration tools.

Version `2.5`, build `359` (released October 10, 2016).

The image based on [Ubuntu 16.04 LTS](https://registry.hub.docker.com/u/esycat/java/) with [Oracle Java 8](https://registry.hub.docker.com/u/esycat/java/).

## Usage

Pull the image, create a new container and start it:

```bash
docker pull esycat/jetbrains-hub
docker create --name jetbrains-hub -p 8080:8080 --restart=always esycat/jetbrains-hub
docker start jetbrains-hub
```
