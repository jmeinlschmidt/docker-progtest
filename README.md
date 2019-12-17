# About Docker Progtest
Docker image with FIT CTU Progtest environment. Solving issues for MacOS or Windows users.

Similiar to WSL in Windows system.

## What's inside

Inside are recommended tools as mentioned in **BI-PA1 and BI-PA2** official specifications.

✅ debian \
✅ gcc compiler \
✅ valgrind \
✅ gdb

Also including tools such as (vim, nano, man, sudo, curl etc.) used in **BI-PS1**.

# How to use this image

Run the image using the following command

```
$ docker run --name progtest -td jmeinlschmidt/progtest:latest
```

Attaching console to the container

```
$ docker exec -it progtest /bin/bash
```

## Mounting volumes

Keep on mind host os permissions (especially in MacOS).

```
$ docker run --name progtest -td -v <HOST_OS_LOCATION>/data:/root/data jmeinlschmidt/progtest:latest
```

Usage of argument `-v` is

```
-v <HOST_OS_LOCATION>:<VIRTUAL_OS_LOCATION>
```

## Using with Microsoft VS Code

VS Code natively supports Docker containers. See the [link](https://code.visualstudio.com/docs/remote/containers) for further information.

Requirements:

- Install offcial VS Code extension [Remote Development extension pack](https://aka.ms/vscode-remote/download/extension)
- Optional - Docker extension (for managing container via GUI, not console)

After installing just hit *Remote explorer* in the sidebar menu and attaching to running container.

![Example of attached VS Code environment](https://github.com/jmeinlschmidt/docker-progtest/blob/master/image-vscode-1.png)

The terminal is working natively as well.

## Optional: Attach the container using SSH

When using docker, the recommended way to connect in to the container is to use `exec` command as mentioned before.

However, connecting via SSH has been added in order to let you configure your favourite IDE to join directly into the container as it is the most universal way.

```
$ docker run --name progtest -td -p 2222:22 jmeinlschmidt/progtest:latest <SSH_USERNAME> <SSH_PASSWORD>
```

If no `<SSH_USERNAME>` or `<SSH_PASSWORD>` is provided, following credentials will be used:

- `user` and the password `1234`.

When using MacOS, the propper way to SSH into the container is

```
$ ssh <USERNAME>@localhost -p 2222
```

Combining all together can look like

```
$ docker run --name progtest -td -p 2222:22 -v <HOST_OS_LOCATION>/data:/root/data jmeinlschmidt/progtest:latest <SSH_USERNAME> <SSH_PASSWORD>
```
