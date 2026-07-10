# Lidarr.AllReleases

`Lidarr.AllReleases` is a Lidarr plugin that adds an override to keep **all release types and statuses** when metadata is refreshed.

By default, Lidarr filters releases using the configured Metadata Profile (primary types, secondary types, statuses). This plugin can bypass that filtering so you can keep every release returned by metadata providers.

## What it does

- **Enabled (default):** keeps all releases, regardless of Metadata Profile filtering rules.
- **Disabled:** uses the normal Lidarr behavior.

## Where to configure it

In Lidarr:

1. Go to **Settings → Metadata**.
2. Add/enable the provider **All Releases Filter Override**.
3. Use the option **All types and statuses**.

## Installation

### From Lidarr UI

1. Open **System → Plugins → Add Plugin**.
2. Enter your GitHub plugin repository (`owner/repo` or full URL).
3. Install the plugin.
4. Restart Lidarr.

After restart, enable it from **Settings → Metadata** (see section above).

## Automated releases (GitHub Actions)

This repository includes a release workflow at:

- `.github/workflows/release.yml`

On a version tag (`v*`), it:

1. Builds the plugin for `net8.0`.
2. Creates `Lidarr.Plugin.AllReleases.net8.0.zip`.
3. Publishes/updates a GitHub Release with the zip artifact.

### Create a release

```bash
# from repository root
git tag v1.0.0
git push origin v1.0.0
```

## Local build (optional)

### PowerShell (Windows)

```powershell
./build-package.ps1 -Version 1.0.0
```

### Bash (Linux/macOS)

```bash
chmod +x ./build-package.sh
./build-package.sh 1.0.0
```

Output package:

- `artifacts/Lidarr.Plugin.AllReleases.net8.0.zip`
