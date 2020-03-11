# Develop using JetBrains CLion

https://www.jetbrains.com/help/clion/remote-projects-support.html

## Setting up the remote development in CLion

1. Navigate to **Settings / Preferences | Build, Execution, Deployment | Toolchains**, from the list of toolchains or click plus icon and select Remote Host from the drop-down menu to create a new toolchain.

2. Click ⚙️ next to the Credentials field. In the dialog that opens, provide the credentials for accessing you remote machine
    - SSH credentials you specified in `docker run`
    - default `user/1234`
    - address `localhost`
    - port `2222`

3. After establishing the connection, fill up following 
    - CMake `/usr/local/bin/cmake`
    - Make `/usr/bin/make`
    - C Compiler `/usr/bin/gcc`
    - C++ Compiler `/usr/bin/g++`
    - Debugger `/usr/bin/gdb`
    
![screenshot](https://raw.githubusercontent.com/jmeinlschmidt/docker-progtest/master/doc/image-clion-1.png "Screenshot")

4. Set the Remote Host you just created as default option. Move it to the top of the toolchains list by clicking arrow buttons.

Everything is set up. Please report any issues in the git repository.

## FAQ

1. CLion debug fails, folder doesn't exist `/tmp/tmp.OQx4asd2l4/cmake-build-debug/...`
    - **Cause**: Restarting Docker or host OS
    - Check if Docker running properly
    - CLion, navigate to **File** and hit **Reload Cmake Project**
2. Connecting via SSH doesn't work
    - see https://github.com/jmeinlschmidt/docker-progtest/issues/6
    - **Cause**: New container has been created but it's SSH key is different
    - Manually delete `localhost:2222` in `~/.ssh/known_hosts`
3. Clion debug fails, cannot access file ...
    - same as above
