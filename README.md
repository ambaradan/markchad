# markchad

## Objective

Create a configuration of NvChad dedicated to writing documentation with Markdown code by implementing the following features.

* Automatically set Neovim options for Markdown files
* Highlighting Markdown tags in the buffer
* Providing a *zen mode* for document editing

## Introduction

[Nvchad](https://nvchad.com/) is a custom configuration of **Neovim** that provides *out of the box* an IDE for *Lua* code development, its modularity however allows useful features for any type of language to be implemented in the configuration.
This project intends to create a version of the NvChad configuration with the best solutions for the Markdown language provided by Neovim plugins and settings.
There are also features useful for project management both in terms of workspace management (file manager, session manager) and *git* repository management.

## Requirements

The configuration requires the same [pre-requisites needed](https://nvchad.com/docs/quickstart/install) for its use as running a standard installation of *NvChad* with the addition of the `sqlite` packages for storing strings to be copied with *yank.nvim* and `pandoc` for aligning markdown tables.

### Features

* **Configuration:** all configurations of the additional plugins have been written with great care to make them independent of each other, this allows them to be disabled when needed by means of the *Plugin Spec* `enabled = false/true` of *lazy.nvim* present in all configuration files. Keyboard keys to invoke the various features have been included in the configuration files and converted where possible to the *lazy style* format
* **UI - Interface:** some changes were made to the layout strategy of `Telescope` in order to have a more modern and functional interface, themes (*dropdown* and *ivy*) were also used for the `pickers` provided by default and for those inserted by additional plugins.
No changes have been made to the themes provided by *NvChad*, this is to allow you to use it according to your own aesthetic tastes. Not all themes offer a *rich* display for highlights, and the default `onedark` theme was used for graphic development.
* **Editor:** the section of plugins that provide functionality to the editor have been supplemented with a *git* repository manager a session manager that enables faster project management and other small utilities to improve workflow.
* **Markdown:** several features have been included for writing Markdown documentation including a preview of the document in the browser, highlighting in the buffer of markdown tags, conversion by keyboard keys of attributes to text, and more.

## Test installation

For its installation, it is recommended to start with a test one using the `NVIM_APPNAME` variable provided by Neovim. Using this variable allows you to run an instance of Neovim with the **markchad** configuration completely independent of the current system configuration found in `.config/nvim`. To run the installation, type:

```bash
git clone https://github.com/ambaradan/markchad.git ~/.config/markchad && NVIM_APPNAME=markchad nvim
```

The command clones the installation in `~/.config/markchad/` and starts *nvim* with the settings from that path, installs all set plugins and parsers, when finished all that remains is to install the LSP set with `:MasonInstallAll`.

The neovim instance creates two folders where to hold the additional files of the installation, in particular the folder `~/.local/share/markchad/` will be created where to save plugins (lazy) and LSP components (mason) and the folder `~/.cache/markchad/` for temporary files.

## Starting the installation

To keep the installation independent of the system installation, its post-installation startup must also be done using the NVIM_APPNAME variable, so neovim will initialize the instance with the paths described above, to start it type:

```bash
NVIM_APPNAME=markchad nvim
```

**NOTE:** This project was developed using the [Rocky Linux](https://rockylinux.org/) distribution and should therefore run on all derived RHEL distributions, for instructions on package installation and configurations on another Linux system please refer to the relevant documentations.

## Removal

For complete deletion of the installation, simply remove the folders created by the installation:

```bash
rm -rf ~/.config/markchad/
rm -rf ~/.cache/markchad/
rm -rf ~/.local/share/markchad/
```
