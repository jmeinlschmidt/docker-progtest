# Docker Progtest

### See translations! [[CZ](https://github.com/jmeinlschmidt/docker-progtest/blob/master/README_CZ.md), [EN](https://github.com/jmeinlschmidt/docker-progtest/blob/master/README.md)]

Image je určena pro studenty **Fakulty informačních technologií**, České vysoké učení technické v Praze.

Nejedná se o oficiální nástroj poskytnutý fakultou! Image je spravována studenty a pro oficiální nástroje prosím navštivte stránky konkrétního předmětu na courses.fit.cvut.cz.

## Hlavní využití

Image přímo dědí z oficiální image Progtestu. Obsahuje proto nejen schválené nástroje pro testování, ale navíc **nástroje vhodné pro vývoj**. Cílem je poskytnout linuxové prostředí využívané na fakultě bez potřeby využít virtualizaci typu Virtual Box nebo vůbec instalovat Linux.

Všechny potřebné nástroje (i pro předmět BI-PS1) jsou tak zabalené na jednom místě. Pohodlně lze připojit **VSCode, CLion nebo jiné IDE**, které bude vzdáleně připojené k běžícímu Dockeru. Není tak potřeba ve vašem oblíbeném operačním systému cokoliv konfigurovat nebo jej měnit za Linux.

Image také řeší časté problémy, především zaznamenávané na **macOS** (jako absence distribuce Valgrind, nefungující GDB debug v CLion atd.). Systém je založen na podobném principu jako WSL v operačním systému Windows. Nakonfigurovaná image pro WSL v současné době neexistuje. Docker byl zvolen vzhledem k univerzálnímu použití.

Splňuje požadavky na prostředí v předmětech **BI-PA1 a BI-PA2**, zároveň obsahuje všechny používané programy v předmětu **BI-PS1**.

# Instalace

## Nainstalujte Docker!

Návod v řešení. Tutorial i s krásnými obrázky je v dokumentaci. https://docs.docker.com/docker-for-windows/install/

## Spuštění image

Nahraďte `<HOST_OS_LOCATION>` jakýmkoliv umístěním na hostitelském počítači. Složka poté bude přístupná z fyzického i virtuálního počítače.

```
$ docker run --name progtest -td \
    -v <HOST_OS_LOCATION>:/home/progtest/data \
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

Přejděte do `/home/progtest/data` a užijte si dlouhé noci s progtestem. Nezapomeňte, že složka je přístupná i z hostitelského počítače.

Nyní již můžete container spouštět následujícím způsobem.

```
$ docker start progtest
```

A způsobně vypnout pomocí.

```
$ docker stop progtest
```

Pro více manipulací s Dockerem doporučuji dokumentaci a basic tutoriály.

# Využívání

✅ [Vývoj v CLion](https://github.com/jmeinlschmidt/docker-progtest/blob/master/doc/cz/clion_setup.md) \
✅ [Vývoj ve VSCode](https://github.com/jmeinlschmidt/docker-progtest/blob/master/doc/cz/vscode_setup.md)

## Přihlášení přes SSH

Pro připojení do containeru používejte prosím příkaz `exec` uvedený o několik řádků výše.

Pokud ale skutečně potřebujete do containeru přistupovat pomocí SSH (např. IDE apod.), je zde běžící SSH server.

Výchozí nastavení:
- jméno `progtest`
- heslo `1234`

Způsob, jak přistupovat do containeru s pomocí SSH.
```
$ ssh progtest@localhost -p 2222
```

# Ostatní výhody

## Aliasy

Předkonfigurované aliasy.

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

![vim setlist](https://raw.githubusercontent.com/jmeinlschmidt/docker-progtest/master/doc/image-vim-setlist.png "vim selist example")

## Root

Defaultně dochází k příhlášení přes uživatele `progtest`, který má oprávnění využívat `sudo`. Pokud by ale z nějakého duvodu bylo potřeba se příhlasit jako root uživatel. Lze modifikovat původní příkaz k přístupu do containeru na

```
$ docker exec -it -u 0 progtest /bin/bash
```