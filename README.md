# My Neovim Configuration
This is my personal configuration for [Neovim](https://neovim.io/), a modern version of the Vim text editor that provides improved performance and a maximized extensibility.

## Installation
***Note: This repository is created according to my personal needs and likings. If you're not interested in using my configuration, please skip Intallation and Usage sections.***

To use this configuration, you'll need to have Neovim installed on your system. You can install it by following the instructions on the [official Neovim website](https://neovim.io/) or on the [Neovim GitHub repository](https://github.com/neovim/neovim). Personally, I use [bob](https://github.com/MordechaiHadad/bob) (Neovim version manager) for easy installing and switching between Neovim [versions](https://github.com/neovim/neovim/releases/).
Once Neovim is installed, you can clone this repository and copy the files into your `~/.config/nvim/` directory:
```
git clone https://github.com/NStefan002/nvim_config.git
cp -r nvim_config ~/.config/nvim
```
## Usage
Once you've copied the configuration files, you can launch Neovim and start using it. Here are a few things to keep in mind:

- Almost all of the used plugins are configured in `nvim/lua/custom/plugins/` directory. If you want, customize their settings according to your needs.
- You may want to customize the keybindings to better suit your workflow. You can do this by editing the `nvim/lua/my_config/remap.lua` file and adding your own mappings.
- You may need to install some additional packages and dependencies, some of them being `git`, `build-essential`, `npm`, `rustc` and `cargo`, etc.
- I recently switched to [Lazy](https://github.com/folke/lazy.nvim), so now plugins are automaticly installed when you open Neovim (open Lazy with ```:Lazy```), see [migrating from Packer to Lazy](https://github.com/folke/lazy.nvim#-migration-guide)

## Credits
- Plugins GitHub repositories (see most popular plugins [here](https://github.com/rockerBOO/awesome-neovim))
- [Neovide](https://github.com/neovide/neovide) (an amazing Neovim GUI)
- I borrowed some code from [ThePrimeagen's init.lua repository](https://github.com/ThePrimeagen/init.lua)

## Sources
Here are the sources I used to learn about Neovim, Lua, and plugins:
- [TJ DeVries YouTube channel](https://www.youtube.com/@teej_dv)
- [Tj Devries GitHub page](https://github.com/tjdevries)
- [ThePrimeagen YouTube channel](https://www.youtube.com/@ThePrimeagen)
- Source code of some of the plugins
- [Neovim documentation](https://neovim.io/doc/)

If you run into any issues or have suggestions for improvements, please don't hesitate to open an issue or submit a pull request on this repository. I'm always happy to hear feedback and improve this configuration.
