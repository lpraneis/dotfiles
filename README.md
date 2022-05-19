# dotfiles

# Setup

### Symlinks
Add the following symlinks to the path in this repo
- .zshrc
- .config/nvim/init.lua
- .config/starship.toml

### Configure Alacritty
- Add the following in ~/.alacritty.yml, replacing the `dotfiles` path
```yaml
import:
  - /path/to/this/cloned/repo/dotfiles/alacritty.yml
```
- any overrides ( font size, font title, etc. ) can be placed in the repo
