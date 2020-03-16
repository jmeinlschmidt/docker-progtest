# About Docker Progtest

### See translations! [[CZ](https://github.com/jmeinlschmidt/docker-progtest/blob/master/README_CZ.md), [EN](https://github.com/jmeinlschmidt/docker-progtest/blob/master/README.md)]

Docker image providing environment for stable development. Designed for students of **Faculty of Information Technology**, Czech Technical University in Prague.

This image is not an official tool provided by university and is maintained by students. In order to match official tools, see according course page at courses.fit.cvut.cz, for further information.

# General purpose

Image inherits directly from faculty official image but introduces more features and is primarily focused on **development**. The goal is to provide stable environment based on official requirements without needing to use heavier virtualisation software such as VirtualBox or even install Linux on your computer.

All of the required tools (even needed in BI-PS1) are located within one container. It is possible to easily connect **VSCode, CLion or any other IDE** remotely to running Docker container. So there are no modifications needed on your host computer.

Image should also solve common issues, experienced by **macOS** or Windows users. Similiar to WSL in Windows system. Performance should be similiar. After all, this image comes pre-configured and is ready to use. Docker has been chosen due to its universality.

Meets requirements in classes **BI-PA1, BI-PA2 and BI-PS1**.

# Installation

## Get Docker!

Tutorial comming soon. Now you are on your own but **you can do it**! See the documentation here. https://docs.docker.com/docker-for-windows/install/

## Running the image

Replace the `<HOST_OS_LOCATION>` with whatever destination you want. This folder will by accessible from both your host computer and the Docker container.

```
$ docker run --name progtest -td \
    -v <HOST_OS_LOCATION>:/home/progtest/data \
    -p 2222:22 \
    -p 2000:2000 \
    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
    jmeinlschmidt/progtest:latest
```

And that's all folks! Make sure the container is running properly.

```
$ docker ps
```

Get into the container.

```
$ docker exec -it progtest /bin/bash
```

In order to get out of it, just type `exit`.

Now you're in! Navigate to `/home/progtest/data` and feel free to fight progtest. Remember, this folder is also accessible from your host OS.

Once the container has been created. You can repeatedly start it by using.

```
$ docker start progtest
```

Or gently stop it.

```
$ docker stop progtest
```

For further information, see some Basic Docker tutorials.

## Using the image

✅ [CLion development](https://github.com/jmeinlschmidt/docker-progtest/blob/master/doc/en/clion_setup.md) \
✅ [VSCode development](https://github.com/jmeinlschmidt/docker-progtest/blob/master/doc/en/vscode_setup.md)

## Login via SSH

When using docker, the recommended way to connect into the container is to use `exec` command as mentioned before.

However, connecting via SSH has been added in order to let you configure your favourite IDE to join directly into the container as it is the most universal way.

Default configuration is:
- username `progtest`
- password `1234`

Propper way to SSH into the container is

```
$ ssh progtest@localhost -p 2222
```

# Miscellaneous features

## Aliases

Some pre-configured aliases.

```bash
g = "gcc -Wall -pedantic -g -o a.out"
gf = "gcc -Wall -pedantic -g -fsanitize=address -o a.out"
gg = "g++ -Wall -pedantic -std=c++14 -g -o a.out"
ggf = "g++ -Wall -pedantic -std=c++14 -g -fsanitize=address -o a.out"
```

For git

```bash
git ll = "log --oneline --graph --all --decorate"
```

## Vim

`vim` is displaying white-space characters by default.

In order to disable
- temporarily by executing `:set nolist` (re-enable by using `:set list`)
- or permanently by uncommenting `"set nolist` in `~/.vimrc`

![vim setlist](https://raw.githubusercontent.com/jmeinlschmidt/docker-progtest/master/doc/image-vim-setlist.png "vim selist example")

## Root

Default account is `progtest` and is able to launch `sudo`. However, if you need to access the container as a root user anyway, it can be done via

```
$ docker exec -it -u 0 progtest /bin/bash
```