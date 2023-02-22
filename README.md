# My Neovim Configuration
This is my personal configuration for [Neovim](https://neovim.io/), a modern version of the Vim text editor that provides improved performance and a maximized extensibility.

## Installation
***Note: This repository is created according to my personal needs and likings. If you're not interested in using my configuration, please skip Intallation and Usage section.***

To use this configuration, you'll need to have NeoVim installed on your system. You can install it by following the instructions on the [official NeoVim website](https://neovim.io/) or on the [NeoVim github repository](https://github.com/neovim/neovim).
Once Neovim is installed, you can clone this repository and copy the files into your `~/.config/nvim/` directory:
```
git clone https://github.com/NStefan002/nvim_config.git
cp -r nvim_config ~/.config/nvim
```
## Usage
Once you've copied the configuration files, you can launch Neovim and start using it. Here are a few things to keep in mind:

- Almost all of the used plugins are configured in nvim/after directory. If you want, customize their settings according to your needs.
- You may want to customize the keybindings to better suit your workflow. You can do this by editing the nvim/lua/my_config/remap.lua file and adding your own mappings.
- You may need to install some additional packages and dependencies, some of them being `git`, `build-essential`, `npm`, `rustc` and `cargo`, etc.
- When you start NeoVim (type `nvim` in your terminal), go to `nvim/lua/my_config/packer.lua` file (use vim command `:e ~/.config/nvim/lua/my_config/packer.lua` or my shortcut `<space>vpp`), source packer.lua file (use vim command `:source %` or my shortcut `<space><space>s`) and run `:PackerSync` to install and update all of the plugins.

## Credits
- Plugins GitHub repositories (names of the repositories can be found in `nvim/lua/my_config/packer.lua` file
- I borrowed some code from [ThePrimeagen's init.lua repository](https://github.com/ThePrimeagen/init.lua)

## Sources
Here are the sources I used to learn about Neovim, Lua, and plugins:
- [TJ DeVries YouTube channel](https://www.youtube.com/@teej_dv)
- [Tj Devries GitHub page](https://github.com/tjdevries)
- [ThePrimeagen YouTube channel](https://www.youtube.com/@ThePrimeagen)
- Source code of some of the plugins

If you run into any issues or have suggestions for improvements, please don't hesitate to open an issue or submit a pull request on this repository. I'm always happy to hear feedback and improve this configuration.
