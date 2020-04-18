# fzf-preview.zsh

fzf-completion plugin

**WARNING: This project is in beta stage. Any changes are applied without announcements.**

## Usage

The completion for the configured command is switched to completion using fzf.

Example:

```shell
$ git add <Tab>
```

## Requirements

- [junegunn/fzf: A command-line fuzzy finder](https://github.com/junegunn/fzf)
- [sharkdp/bat: A cat(1) clone with wings.](https://github.com/sharkdp/bat)

## Installation

### zinit

```zsh
zinit ice lucid wait"0" depth"1" blockf
zinit light yuki-ycino/fzf-preview.zsh
```

and write `.zshrc`

```zsh
bindkey '^i' fzf-or-normal-completion
```

## Support

- git
  - add
  - branch (-d|-D)
  - reset (none|--hard|--soft)
  - reset --
  - diff
  - diff --
  - checkout (-t)
  - checkout --

- gh
  - issue view (--web)
  - pr view (--web)
  - checkout
