# Hermea repository instructions

Hermea is the Hermes orchestrator monorepo. The Omarchy integration is a
separate Git repository checked out as the `plugins/omarchy/hermea` submodule.

## Repository layout

- Keep orchestrator and future platform work in this repository.
- Treat `plugins/omarchy/hermea` as an independently versioned plugin. Make
  plugin implementation changes in the submodule repository, then update the
  submodule pointer here.
- Do not commit credentials, Hermes profile data, generated state, or files
  copied from a user's `~/.config` or `~/.local/state` directory.

## Development workflow

Before working on the plugin from a fresh clone, run:

```bash
git submodule update --init --recursive
```

Run the repository validation after changes:

```bash
./tools/validate-omarchy-plugin.sh
./tools/package-omarchy-plugin.sh
```

The package command validates and writes only to `.dist/`, which is ignored by
Git. `qmllint` is optional locally; when available, validate against the
Omarchy shell imports.

## Change and release rules

- Preserve the public plugin contract and the `hermea`
  plugin ID.
- Keep the plugin README and root README aligned with the actual repository
  layout and install commands.
- Keep plugin and orchestrator commits separate. Push the plugin first, then
  update and push the parent submodule pointer.
- Run the plugin tests before publishing a plugin commit:

```bash
python3 -B -m unittest discover -s plugins/omarchy/hermea/tests -v
```
