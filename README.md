# About Docker Progtest

### See translations! [[CZ](https://github.com/jmeinlschmidt/docker-progtest/blob/master/README_CZ.md), [EN](https://github.com/jmeinlschmidt/docker-progtest/blob/master/README.md)]

Docker image providing environment for stable development. Designed for students of **Faculty of Information Technology**, Czech Technical University in Prague.

This image is not an official tool provided by university and is maintained by students. In order to match official tools, see according course page at courses.fit.cvut.cz, for further information.

Image should solve common issues, experienced by **macOS** or Windows users. Similiar to WSL in Windows system. Performance should be similiar. After all, this image comes pre-configured and is ready to use.

## What's inside

Matches all recommended tools as mentioned in **BI-PA1 and BI-PA2** specifications.

✅ debian \
✅ gcc \
✅ valgrind \
✅ gdb

and many others.

Also including tools such as vim, nano, man, sudo, curl etc. and is ready to be used in **BI-PS1**, especially recommended for macOS users since some programs (such as grep) may differ.

# How to use the image

## Get Docker!

Tutorial comming soon.

Now you are on your own but **you can do it**! See the documentation here. https://docs.docker.com/docker-for-windows/install/

## Running the image

Replace the `<HOST_OS_LOCATION>` with whatever destination you want. This folder will by accessible from both your host computer and the Docker container.

```
$ docker run --name progtest -td \
    -v <HOST_OS_LOCATION>:/home/user/data \
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

Now you're in! Navigate to `/home/user/data` and feel free to fight progtest. Remember, this folder is also accessible from your host OS.

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

## Optional: Configuring SSH

When using docker, the recommended way to connect into the container is to use `exec` command as mentioned before.

However, connecting via SSH has been added in order to let you configure your favourite IDE to join directly into the container as it is the most universal way.

Default configuration is:
- username `user`
- password `1234`

To change this credentials, you can modify the `run` command to something like

```
$ docker run --name progtest -td \
    -v <HOST_OS_LOCATION>:/home/<SSH_USERNAME>/data \
    -p 2222:22 \
    -p 2000:2000 \
    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
    jmeinlschmidt/progtest:latest
    <SSH_USERNAME> <SSH_PASSWORD>
```

The init script will create custom user for you.

The propper way to SSH into the container is

```
$ ssh <USERNAME>@localhost -p 2222
```

# Miscellaneous features

## Aliases
```bash
alias g="gcc -Wall -pedantic -g -o a.out"
alias gf="gcc -Wall -pedantic -g -fsanitize=address -o a.out"
alias gg="g++ -Wall -pedantic -std=c++14 -g -o a.out"
alias ggf="g++ -Wall -pedantic -std=c++14 -g -fsanitize=address -o a.out"
```

## Vim

`vim` is displaying white-space characters by default.

In order to disable
- temporarily by executing `:set nolist` (re-enable using `:set list`)
- or permanently by uncommenting `"set nolist` in `~/.vimrc`
