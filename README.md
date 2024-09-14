# Markchad

**NOTE**: Rocky Linux 9.4 is the development platform for Markchad. The following should work for any Linux operating system derived from RHEL. If you are not on RHEL or a clone, adjustments will be needed for your operating system.

 **Disclaimer**: The developer of the Markchad scripts and files guarantees them for no purpose whatsoever. Use them at your own risk. That said, the script is tested by the developer and others, and it is believed to function for the desired purpose of creating a Neovim configuration for writing in Markdown that works very well. Your feedback is welcome!

## Objective

Create a configuration of NvChad dedicated to writing documentation with Markdown code by implementing the following features.

* Automatically set Neovim options for Markdown files
* Highlighting Markdown tags in the buffer
* Providing a *zen mode* for document editing

## Introduction

[Nvchad](https://nvchad.com/) is a custom configuration of **Neovim** that provides *out of the box* an IDE for *Lua* code development, its modularity however allows useful features for the implementation of any type of language in the configuration.
This project intends to create a version of the NvChad configuration with the best solutions for the Markdown language provided by Neovim plugins and settings.
Features useful for project management, in terms of workspace management (file manager, session manager), and *git* repository management, are also available.

## Requirements

Installation of Markchad is by way of a script, which will check the availability of minimum requirements. To ensure you have them all, you can follow these steps ahead of Markchad installation. This instruction should work on any Rocky Linux, RHEL Linux, or clone, version 9 or above. If you are using a different Linux operating system, then you will need to extrapolate these instructions to fit your operating system. If you *do* create a new instruction for your operating system, consider pushing those changes here. You will also need `sudo` permissions throughout.

### Repositories

With the standard repositories, you will also need Extra Packages for Enterprise Linux (EPEL), and a Cool Other Package Repo (COPR) for `lazygit`:

```bash
sudo dnf install epel-release -y
sudo dnf copr enable atim/lazygit -y
```

### Packages

Install the packages:

```bash
sudo dnf install gcc make unzip compat-lua-libs libtermkey libtree-sitter libvterm luajit luajit2.1-luv msgpack unibilium xsel ripgrep sqlite pandoc rsync curl lazygit tar git
```

### Neovim

You will need a modern, recent, version of Neovim. At the time of this writing, the version was 0.10.1. You can install Neovim [from source](https://github.com/neovim/neovim/blob/master/BUILD.md), or the [pre-compiled binary](https://github.com/neovim/neovim/releases/tag/v0.10.1) (recommended). Because of the fast-paced development cycle, RPM packages found in the Extra Packages for Enterprise Linux repository (EPEL) are many versions behind and will not work with Markchad.

If using the pre-compiled binary, you will need to adjust your `$PATH` variable in your user's `.bashrc` file. This procedure assumes you have installed Neovim in your home folder:

1. Edit your `.bashrc` file with your favorite editor.

2. Add the following at the bottom of the file:

    ```bash
    export PATH=~/nvim-linux64/bin/:$PATH
    ```

3. Prior to running `nvim`, run `bash` at the command line and then verify your path with the `echo $PATH` command. You should see the `/nvim-linux64/bin/` in your path. If you see this, you are ready for the next steps.

### Nerd fonts

For the proper display of icons, use the [Nerd Font installation procedure here](https://docs.rockylinux.org/books/nvchad/nerd_fonts/).

## Features

* **Configuration:** careful writing of all configurations of the additional plugins makes them independent of each other. This allows disabling them when needed by means of the *Plugin Spec* `enabled = false/true` of *lazy.nvim* present in all configuration files. Include in the configuration files are keyboard keys to invoke the various features and convert them where possible to the *lazy style* format.
* **UI - Interface:** some changes made to the layout strategy of `Telescope` to have a more modern and functional interface. Themes (*dropdown* and *ivy*) were also used for the `pickers` provided by default, and for those inserted by additional plugins.
Made no changes to the themes provided by *NvChad*. This allows you to use it according to your own aesthetic tastes. Not all themes offer a *rich* display for highlights and, implemented for graphic development, the default `onedark` theme is used.
* **Editor:** supplemented the section of plugins that provide functionality to the editor with a *git* repository manager, a session manager that enables faster project management, and other small utilities to improve workflow.
* **Markdown:** included several features for writing Markdown documentation including a preview of the document in the browser, highlighting in the buffer of markdown tags, conversion by keyboard keys of attributes to text, and more.

## Installation

1. Get the latest version of the Markchad install script:

    `curl -LO https://raw.githubusercontent.com/ambaradan/markchad/main/install.sh`

2. Change the attributes to make it executable:

    `chmod +x install.sh`

3. Run the script:
    `./install.sh`

4. The Markchad splash screen appears. If you are ready to continue with the install, follow the on-screen directions:

    ![markchad_splash_screen](images/markchad_splash.png)

5. The installation script provides two ways to install *Markchad*. You can install it as the default ("Nvim"), or if you prefer to keep your markdown editor separate from other work, using "Markchad."

    ![markchad_install](/images/markchad_install.png)

All releases, and the changelog information for each, are available [on this page](https://github.com/ambaradan/markchad/releases).

## Mapping - Quick Reference

This table lists the main *Markchad* features and their respective mappings. The mappings marked as *Toggle* allow with the same command to open and close the respective functionality.

### Editor

| Mapping    | Description                                                               |
|------------|---------------------------------------------------------------------------|
| Space + ff | Search for files within the working folder with *Telescope*               |
| Space + fo | Opens recent files, for quick reopening                                   |
| Space + fb | List in *Telescope* buffers open in the editor for easy navigation        |
| - (minus)  | Opens the file manager (NeoTree) in a floating buffer (Toggle)            |
| , (comma)  | Opens the alternative Command Line                                        |
| Ctrl + d   | Scroll down                                                               |
| Ctrl + u   | Scroll up                                                                 |
| Space + cx | Closes all open buffers in the editor, recommended for switching sessions |
| Ctrl + n   | Opens the file manager sideways (Toggle)                                  |
| Alt + g    | Opens a *Telescope* buffer with ripgrep, a line-oriented search tool      |
| Alt + y    | Displays the strings saved by *Yanky* (copy) for their insertion          |
| Alt + s | Opens the *Telescope* buffer for session management |
| Alt + l | Reopens the last closed session |
| Space + ss | Save current session |
| Space + st | Stop recording the current session |
| Space + sS | Allows you to select the session to be opened (normal mode) |
| Space + sl | Reload current session |

### Markdown

| Mapping       | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| Alt + o       | Open Markdown preview                                                       |
| Alt + c       | Close Markdown Preview                                                      |
| Ctrl + i      | In VISUAL mode converts selection to *italic*                               |
| Ctrl + b      | In VISUAL mode converts selection to **bold**                               |
| Ctrl + c      | In VISUAL mode converts selection to `code inline`                          |
| Space + gsiwi | In NORMAL mode converts text (curson on t^text) to *italic*                 |
| Space + gsiwb | In NORMAL mode converts text (curson on t^text) to **bold**                 |
| Space + gsiwc | In NORMAL mode converts text (curson on t^text) to `code inline`            |
| Space + gl    | Create a link from the selected text, also select the blank space preceding |

### Git Repository

| Mapping    | Description                                                                                |
|------------|--------------------------------------------------------------------------------------------|
| Space + cm | Opens *Telescope* on commits made to the repository                                        |
| Space + gg | Opens NeoTree by listing the status of the files against the *git* repository (Git Status) |
| Space + lg | Opens *lazygit* for repository management (need *lazygit* installed)                       |
| Space + ng | Opens *Neogit* for repository management                                                   |

### Diagnostics

| Mapping    | Description                                                                |
|------------|----------------------------------------------------------------------------|
| Space + tt | Opens the diagnostics buffer (*Trouble*) for the entire workspace (Toggle) |
| Space + tb | Opens the diagnostics buffer only for the active buffer (Toggle)           |
| Space + ts | Opens symbol buffer sideways, in Markdown lists *Header* tags (Toggle)     |

### Miscellaneous

| Mapping    | Description                                                                |
|------------|----------------------------------------------------------------------------|
| Space + cS | Colors the corresponding markers (e.g. #FFFFFF), useful for editing the Nvchad UI (Toggle) |
| Space + fh | Opens *Telescope* on help pages, enabling search                                           |

## Acknowledgements

A big thank you goes to [Siduck](https://github.com/siduck), the main developer, and to all those who contributed to the creation of *NvChad*, without them this project could not exist.
A big thank you also goes to all the developers of the plugins used in this setup for sharing their knowledge.
