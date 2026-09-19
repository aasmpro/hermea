# Hermea (0.1.0)

Hermea is a Hermes orchestrator project for bringing Hermes profiles, models,
sessions, and future agent features together across desktop platforms.

The first integration is an Omarchy status bar plugin. It provides a compact
Hermes control panel today while keeping the project ready for additional
features and platform integrations later.

## Project layout

```text
hermea/
├── plugins/omarchy/hermea/   # Git submodule: standalone Omarchy plugin
├── tools/                    # Validation and packaging commands
├── README.md                 # Orchestrator project documentation
└── LICENSE
```

The Omarchy plugin is maintained in the separate
[`aasmpro/hermea-omarchy`](https://github.com/aasmpro/hermea-omarchy)
repository and linked here as a Git submodule. It owns its manifest, QML entry
points, Hermes adapter, browser launcher, tests, README, and license.
Future Hermes features can be added under `features/`, and other platform
integrations can use `plugins/<platform>/` without adding platform code to the
project root.

## Current Omarchy integration

The `hermea` bar widget provides:

- profile-aware Hermes status cards for gateway, dashboard, sessions, jobs, version, and skills;
- profile and model selection with per-profile model persistence;
- new-terminal Hermes CLI chats;
- dashboard startup and browser launch at the selected profile;
- per-profile AI agent icons;
- configurable refresh, panel size, dashboard endpoint, visible cards, and actions;
- safe first-run behavior when Hermes or a profile is not initialized.

Hermes Agent must be installed separately from this project.

## Installation guide

### Requirements

Install and initialize these components before enabling Hermea:

- Omarchy with the Quickshell status bar;
- Hermes Agent with at least one Hermes profile;
- `mise`, when model catalog discovery is needed;
- a configured terminal available through `xdg-terminal-exec` for CLI chats;
- `omarchy-launch-browser` or `xdg-open` for dashboard links.

Hermea does not install Hermes, change Hermes authentication, or create a
profile. The first panel open is safe when Hermes is missing or uninitialized:
it shows a setup state and enables profile actions after a later refresh finds a
usable profile.

### Install the published Omarchy plugin

Install the standalone plugin directly from its public repository:

```bash
omarchy plugin add https://github.com/aasmpro/hermea-omarchy.git --enable
omarchy bar move io.github.aasmpro.hermea --section right
```

### Work from the Hermea source checkout

```bash
git clone --recurse-submodules https://github.com/aasmpro/hermea.git
cd hermea
./tools/validate-omarchy-plugin.sh
```

For an existing clone, initialize or update the plugin submodule:

```bash
git submodule update --init --recursive
```

The plugin can then be installed locally from the checked-out submodule:

```bash
./tools/package-omarchy-plugin.sh
PLUGIN_DIR="$HOME/.config/omarchy/plugins/io.github.aasmpro.hermea"
rm -rf "$PLUGIN_DIR"
mkdir -p "$PLUGIN_DIR"
cp -a .dist/omarchy/hermea/. "$PLUGIN_DIR/"
omarchy bar move io.github.aasmpro.hermea --section right
omarchy-shell shell rescanPlugins
```

The installed directory must contain `manifest.json` directly. Do not copy the
whole Hermea orchestrator repository into the Omarchy plugin directory.

### Update or remove

To update a local installation, rebuild the package and copy it over the
installed directory. For a repository installation, use the normal Omarchy
plugin update flow or reinstall the plugin from its repository.

Remove the plugin with:

```bash
omarchy plugin remove io.github.aasmpro.hermea
```

Removing Hermea does not delete Hermes profiles, model configuration, sessions,
or profile icons.

## Validate

```bash
./tools/validate-omarchy-plugin.sh
```

## Build a standalone Omarchy plugin package

The plugin is already available as a standalone repository. The packaging
command remains useful for local testing and for checking the exact files that
the submodule provides:

```bash
./tools/package-omarchy-plugin.sh
```

The package is written to `.dist/omarchy/hermea/`. The source of truth for
published Omarchy installs is
[`aasmpro/hermea-omarchy`](https://github.com/aasmpro/hermea-omarchy).

See the [standalone plugin documentation](https://github.com/aasmpro/hermea-omarchy/blob/master/README.md)
for plugin settings, runtime dependencies, and troubleshooting.

## License

Hermea is released under the MIT License.
