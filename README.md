# JetBrains Hub
[![](https://badge.imagelayers.io/esycat/jetbrains-hub:latest.svg)](https://imagelayers.io/?images=esycat/jetbrains-hub:latest 'Get your own badge on imagelayers.io')

[Hub](https://jetbrains.com/hub/) is a system that provides centralized authentication, authorization; users, groups, permissions and project management across multiple installations of [JetBrains](https://jetbrains.com/) team collaboration tools.

Version `1.0`, build `770` (released January 11, 2016).

The image based on [Ubuntu 14.04 LTS](https://registry.hub.docker.com/u/esycat/java/) with [Oracle Java 8](https://registry.hub.docker.com/u/esycat/java/).

## Usage

Pull the image, create a new container and start it:

```bash
docker pull esycat/jetbrains-hub
docker create --name jetbrains-hub -p 8080:8080 --restart=always esycat/jetbrains-hub
docker start jetbrains-hub
```
