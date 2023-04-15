# dotfiles

# Setup

### Installation
- Clone this repo to ~/tools/dotfiles
- Install the following:
| Package       | Install Location                                       | Description               |
| ----------    | ---------------                                        | ----------                |
| rustup        | [rustup.rs](https://rustup.rs/)                        | rust toolchain            |
| starship      | [starship.rs](https://starship.rs/)                    | shell prompt              |
| exa           | `cargo install exa`                                    | ls replacement            |
| bat           | [github](https://github.com/sharkdp/bat/releases)      | cat replacement           |
| fzf           | [github](https://github.com/junegunn/fzf)              | fuzzy finder              |
| fd-find       | `cargo install fd-find`                                | find replacement          |
| cargo-update  | `cargo install cargo-update`                           | keeps cargo pkgs updated  |
| neovim        | [github](https://github.com/neovim/neovim)             | editor                    |

### Symlinks
Add the following symlinks to the path in this repo
- `~/.zshrc` -> .zshrc
- `~/.config/nvim/init.lua` -> `nvim/init.lua`
- `~/.config/nvim/lua` -> `nvim/lua`
- `~/.config/starship.toml` -> starship.toml
- `~/.gitconfig` -> .gitconfig
    - Or add the following to the current `.gitconfig`:
    ```
    [include]
        path = ~/tools/dotfiles/.gitconfig
    ```
