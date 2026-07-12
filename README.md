> [!WARNING]
> This plugin was fully coded by AI, but tested by a human. On July 12, 2026, it works.

# Lidarr.AllReleases

`Lidarr.AllReleases` is a Lidarr plugin that adds an override to keep **all release types and statuses** when metadata is refreshed.

By default, Lidarr filters releases using the configured Metadata Profile (primary types, secondary types, statuses). This plugin can bypass that filtering so you can keep every release returned by metadata providers.

## Prerequisite

The tests were performed with a MusicBrainz database and a locally hosted "LidarrAPI.Metadata" cache. Full documentation is available on this page: https://github.com/blampe/hearring-aid/blob/main/docs/self-hosted-mirror-setup.md

All applications used are Docker containers:
- **Lidarr** (Docker image : ghcr.io/hotio/lidarr:nightly) with the Tubifarry plugin (https://github.com/TypNull/Tubifarry)
- **Musicbrainz** (Docker release : https://github.com/metabrainz/musicbrainz-docker/releases/tag/v-2026-05-13.0-mbdb31-pg18)
- **Lidarrapi.metadata** (Docker image : blampe/lidarr.metadata:70a9707)

> [!NOTE]
> I think the plugin also works with the default Lidarr cache server. I did not test without, but based on the queries I made to the local MusicBrainz cache and database, filtering does not apply to the Lidarr cache but only to the Web interface.
> However, since the official Lidarr cache server has been in reconstruction on their Github page since April 2025, I advise the use of a local cache server and a local MusicBrainz database.

## What it does

- **If plugin is enabled (default):** keeps all releases, regardless of Metadata Profile filtering rules.
- **If plugin is disabled:** uses the normal Lidarr behavior.
- These releases are also visible from applications using the Lidarr database (e.g. MusicSeerr)

For example, with a classic installation of Lidarr without this plugin, you are not able to find the release having the ID [eb7ead5b-6b29-41e9-a42f-8dc7e26a0049](https://musicbrainz.org/release/eb7ead5b-6b29-41e9-a42f-8dc7e26a0049) because it is a DVD format. With the plugin you can find it, add it to the library and link it to your files. It is also included in the artist's release list. 

![ps://xymaster.fr/upload/github/allrelease.jpg](https://xymaster.fr/upload/github/allrelease.jpg)

![ps://xymaster.fr/upload/github/allrelease2.jpg](https://xymaster.fr/upload/github/allrelease2.jpg)

![ps://xymaster.fr/upload/github/musicseerr.jpg](https://xymaster.fr/upload/github/musicseerr.jpg)

## What he doesn't

- **It does not display the titles of certain releases** whose type was not originally supported by Lidarr (e.g. a DVD). But it is still possible to add it to your library, link it to your files and have it detected by other applications that use Lidarr's database (e.g. MusicSeer)

## Installation

### From Lidarr UI

1. Open **System → Plugins → Add Plugin**.
2. Enter GitHub plugin repository (https://github.com/IxeYgrek/Lidarr.AllReleases).
3. Install the plugin.
4. Restart Lidarr.

After restart, enable it from **Settings → Metadata** (see section below).

### Where to configure it

In Lidarr:

1. Go to **Settings → Metadata**.
2. Click on **All Releases Filter Override**.
3. Check the two options **All types and statuses** and **Enable**.

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
