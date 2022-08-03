# dotfiles

My configurations for:

- tmux
- vim
- neovim
- alacritty

## Usage

After clone repository

```sh
cd <repository_folder>
./install.sh
```

> On Windows use cmd to execute install.bat

Require:

- [git](https://git-scm.com/)
- [nerd fonts](https://www.nerdfonts.com/) (for icons in status bar)

## neovim

Into vim:

> :PlugInstall

## vim
Into vim:

> :PlugInstall

### Using COC

Needed NodeJS. [Install](https://github.com/nvm-sh/nvm)

For C/C++ needed install clangd, and make a alternative link to clangd-10.

```sh
sudo apt-get install clangd-10 llvm
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-10 100
```

Into vim:

```sh
CocInstall coc-tsserver coc-pyright coc-json coc-css coc-clangd coc-markdownlint coc-rls coc-go coc-prettier coc-calc coc-cmake coc-sh
```

**Extensions:**

- `coc-tsserver` for javascript and typescript
- `coc-pyright` for python, Pyright extension
- `coc-json` for json
- `coc-css` for css, scss and less
- `coc-clangd` for C/C++/Objective-C, use clangd
- `coc-markdownlint` for markdown linting
- `coc-rls` for rust, use Rust Language Server
- `coc-go` for go, use gopls
- `coc-prettier` a fork of prettier-vscode
- `coc-calc` expression calculation extension
- `coc-cmake` for cmake code completion
- `coc-sh` for bash using bash-language-server

Require:
- [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)

