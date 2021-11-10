# makeanywhere: Run make from any subdirectory of a directory with a Makefile.

## Usage

```
$ makeanywhere --help
USAGE: /home/hugo/bin/makeanywhere [-h|--help|make arguments]                                            
  Run make from any subdirectory of a directory with a Makefile.  
```

To run a make command from any directory that has a parent directory with a Makefile:

```
makeanywhere <MAKE ARGUMENTS>
```

### Examples

```
$ ls
Makefile src
$ cd src
$ makeanywhere test
<Runs tests while within src/>
```

If `vim` is setup to change directories to that of the current file,
you can use this script to run `make` while within any directory of your
`make` based project.

```
$ vim src/main.c
!makeanywhere test
<Runs tests in vim while within src/>
!makeanywhere format-fix FILES=%:p
<Formats this specific file>
```

## Installation

1. Download [raw.githubusercontent.com/roguh/gp/main/gp](https://raw.githubusercontent.com/roguh/gp/main/gp).
2. Make executable and move to your preferred binary location.

```
chmod +x gp
sudo cp gp /usr/bin/gp
```

## Shell Integration

### Bash and ZSH

Use `alias ma=makeanywhere` for a convenient alias.

### ZSH

To support `make` autocompletions, try using the zsh-completions plugin
and using `compdef makeanywhere make`.
See [manual](https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org#copying-completions-from-another-command)

### Fish Shell

Copy `makeanywhere.fish` to `~/.config/fish/functions/`.

## Vim Integration

Simply make sure this script is in your `$PATH`.

Usage: `!makeanywhere <MAKE ARGUMENTS>`

Look at `./example.vimrc` for how to setup aliases in Vim.
The contents of `~/.bash_vim` are in `~/example.bash_vim`.

## For developers

### Cloning and Installation

```
git clone https://github.com/roguh/gp.git
cd gp
```

Then one of:

```
make install
make install-to-user
make install-symlink-to-user
```

## Integration Testing

If the test script fails, the tests have failed.
Also read the output to determine if `makeanywhere` is behaving correctly.

Note the `test-integration-all-shells.sh` script runs the `test-integration.sh` script using the test shell itself.

### Linux: Running tests for many shells at once

```
make test-on-linux
```

### MacOS: Running tests for many shells at once

```
make test-on-macos
```

### Running tests for stricter POSIX shells

```
make test-on-strict-posix-shells
```

### Running tests one shell at a time

```
./tests/test-integration.sh dash
```

## Test results

### Linux

Tested using GNU coreutils 9.0 in these shells:

- dash 0.5
- bash 5.1
- bash 5.1 in bash 3.1 compatibility mode BASH_COMPAT=31
- zsh 5.8
- yash 2.52
- ksh version 2020.0.0

### MacOS

Not tested on MacOS, yet. It should work fine.

## Linting and Compatibility Check

Use shellcheck to check shellscripts.

```
make check
```
