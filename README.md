# ThunderByte Homebrew tap

Formulae for ThunderByte command-line tools.

## thin-wrap

```bash
brew install thunderbyte-labs/tap/thin-wrap
```

Upgrade:

```bash
brew update
brew upgrade thin-wrap
```

Uninstall:

```bash
brew uninstall thin-wrap
```

Configuration lives in `~/.config/thin-wrap/`.

## Automatic updates

The workflow `.github/workflows/update-thin-wrap.yml` checks the latest
`thunderbyte-labs/thin-wrap` GitHub release every hour (and on manual
`workflow_dispatch`). When a new Darwin pair of assets is published, it
rewrites `version`, `url`, and `sha256` in `Formula/thin-wrap.rb` and
pushes the change to this tap.
