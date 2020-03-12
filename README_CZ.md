# Docker Progtest

### See translations! [[CZ](https://github.com/jmeinlschmidt/docker-progtest/blob/master/README_CZ.md), [EN](https://github.com/jmeinlschmidt/docker-progtest/blob/master/README.md)]

Docker image poskytující stabilní prostředí, které se velmi podobá prostředí progtestu. Image je určena pro studenty **Fakulty informačních technologií** při Českém vysokém učení technickém v Praze.

Nejedná se o oficiální nástroj poskytnutý fakultou! Image je spravována studenty a pro oficiální nástroje prosím navštivte stránky konkrétního předmětu na courses.fit.cvut.cz.

Image také řeší časté problémy, především zaznamenávané na **macOS** (jako absence distribuce Valgrind, nefungující GDB debug v CLion atd.). Systém je podobný WSL v operačním systému Windows. Nakonfigurovaná image pro WSL v současné době neexistuje. Rychlost obou systémů je srovnatelná.

## Co je uvnitř

Splňuje požadavky v předmětech **BI-PA1 a BI-PA2**

✅ debian \
✅ gcc \
✅ valgrind \
✅ gdb

atd.

Mimo to obsahuje i nástroje jako vim, nano, man, sudo, curl apod. a je také vhodná pro předmět **BI-PS1**. Opět doporučejme uživatelům macOS, jelikož distribuce některých programů se v macOS a předmětu BI-PS1 liší.

# Jak image používat

## Nainstalujte Docker!

Návod v řešení.

Jste v tom sami, ale **to zvládnete**! Návod i s krásnými obrázky je v dokumentaci (analogicky pro macOS). https://docs.docker.com/docker-for-windows/install/

## Spuštění image

Nahradtě `<HOST_OS_LOCATION>` jakýmkoliv umístěním na hostitelském počítači. Složka poté bude přístupná z fyzického i virtuálního počítače.

```
$ docker run --name progtest -td \
    -v <HOST_OS_LOCATION>:/home/user/data \
    -p 2222:22 \
    -p 2000:2000 \
    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
    jmeinlschmidt/progtest:latest
```

A to je vše! Ujistěte se, že virtuální počítač funguje.

```
$ docker ps
```

Připojte se do virtuálního počítače.

```
$ docker exec -it progtest /bin/bash
```

Pro vystoupení použijte jednoduše `exit`.

Přejděte do `/home/user/data` a užijte si dlouhé noci s progtestem. Nezapomeňte, že složka je přístupná i z hostitelského počítače.

Nyní již můžete container spouštět následujícím způsobem (tentokrát již nezabere 15 minut).

```
$ docker start progtest
```

A způsobně vypnout pomocí.

```
$ docker stop progtest
```

Pro více manipulací s Dockerem doporučuji dokumentaci a basic tutoriály.

## Příklady použití

✅ [Vývoj v CLion](https://github.com/jmeinlschmidt/docker-progtest/blob/master/doc/cz/clion_setup.md) \
✅ [Vývoj ve VSCode](https://github.com/jmeinlschmidt/docker-progtest/blob/master/doc/cz/vscode_setup.md)

## Volitelné: Nastavení SSH

Pro připojení do containeru používejte prosím příkaz `exec` uvedený o několik řádků výše.

Pokud ale skutečně potřebujete do containeru přistupovat pomocí SSH (např. IDE apod.), je zde běžící SSH server.

Výchozí nastavení:
- jméno `user`
- heslo `1234`

Toto nastavení je mimo jiné možné změnit při prvním spuštění.

```
$ docker run --name progtest -td \
    -v <HOST_OS_LOCATION>:/home/<SSH_USERNAME>/data \
    -p 2222:22 \
    -p 2000:2000 \
    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
    jmeinlschmidt/progtest:latest
    <SSH_USERNAME> <SSH_PASSWORD>
```

Spouštěcí skript přepíše výchozí jména.

Způsob, jak přistupovat do containeru s pomocí SSH.
```
$ ssh <USERNAME>@localhost -p 2222
```

# Ostatní výhody

## Aliasy

Před-konfigurované aliasy.

```bash
g = "gcc -Wall -pedantic -g -o a.out"
gf = "gcc -Wall -pedantic -g -fsanitize=address -o a.out"
gg = "g++ -Wall -pedantic -std=c++14 -g -o a.out"
ggf = "g++ -Wall -pedantic -std=c++14 -g -fsanitize=address -o a.out"
```

Git (z předmětu BI-GIT)

```bash
git ll = "log --oneline --graph --all --decorate"
```

## Vim

`vim` implicitně zobrazuje i bílé znaky.

Jak vypnout?
- dočasně (pro daný soubor) `:set nolist` (znovu spustit lze `:set list`)
- trvale, zrušením komentáře `"set nolist` v souboru `~/.vimrc`


