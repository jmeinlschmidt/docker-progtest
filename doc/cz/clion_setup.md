# Vývoj s pomocí JetBrains CLion

https://www.jetbrains.com/help/clion/remote-projects-support.html

## Nastavení vzdáleného vývoje v CLion

1. Přejděte do **Settings / Preferences | Build, Execution, Deployment | Toolchains**, přidejte novou položku. Při výběru zvolte Remote Host.

2. Po přidání zvolte ikonu ⚙️ u možnosti připojení a vyplňte přihlašovací údaje SSH
    - SSH údaje jste volili u prvotního `docker run`
    - implicitně `user/1234`
    - adresa `localhost`
    - port `2222`

3. Po úspěšném připojení vyplňte následující položky
    - CMake `/usr/local/bin/cmake`
    - Make `/usr/bin/make`
    - C Compiler `/usr/bin/gcc`
    - C++ Compiler `/usr/bin/g++`
    - Debugger `/usr/bin/gdb`
    
![screenshot](https://raw.githubusercontent.com/jmeinlschmidt/docker-progtest/master/doc/image-clion-1.png "Screenshot")

4. Pomocí šipek nad seznamem existujících Toolchain nastavte Remote Host jako default (tj. přesuňte jej v seznamu úplně nahoru)

V tuto chvíli by měl již být vzdálený vývoj plně funkční. Jakékoliv komplikace prosím hlaste do issues na gitu.

## FAQ

1. CLion při debugování hlásí, že složka `/tmp/tmp.OQx4asd2l4/cmake-build-debug/...` neexistuje
    - **Příčina**: Restart Dockeru/host. počítače (výmaz tmp adresáře)
    - Ujistěte se, že Docker container běží
    - V CLionu přejděte do nabídky a zvolte **Reload Cmake Project**
2. SSH do containeru nefunguje a hlásí, že se neshodují klíče
    - více zde https://github.com/jmeinlschmidt/docker-progtest/issues/6
    - **Příčina**: Došlo k vytvoření nového containeru (např. update), neshodují se klíče v known_hosts a nový klíč containeru
    - Ručně odmažte `localhost:2222` záznam v `~/.ssh/known_hosts`
    - Tato issue bude ještě předmětem řešení
