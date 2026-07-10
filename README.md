# Lidarr.AllReleases

Plugin Lidarr qui ajoute une option globale **All types and statuses** pour ignorer le filtrage Metadata Profile (Primary Types / Secondary Types / Release Statuses).

## Comportement

- Option activée (par défaut) : toutes les releases sont conservées.
- Option désactivée : comportement natif Lidarr (filtrage Metadata Profile).

## Où configurer

Dans les paramètres Metadata du provider **All Releases Filter Override**.

---

## Publication automatique (GitHub Release + zip net8.0)

Ce dépôt contient un workflow GitHub Actions (`.github/workflows/release.yml`) qui :

1. clone Lidarr (`branch: plugins`) dans `Submodules/Lidarr`,
2. restaure via `NuGet.config` (inclut les feeds Lidarr/Servarr),
3. build en `Release`,
4. génère `artifacts/Lidarr.Plugin.AllReleases.net8.0.zip`,
5. publie la GitHub Release avec l'asset zip.

### Ce que tu as à faire

1. Pousser ces fichiers sur ton repo GitHub.
2. Créer un tag, ex: `v1.0.0`.
3. Push le tag.

Exemple :

```bash
# depuis ton repo
git tag v1.0.0
git push origin v1.0.0
```

Le workflow fabriquera automatiquement la release installable par Lidarr.

---

## Installation dans Lidarr

Dans **System > Plugins > Add Plugin** :

- colle l'URL GitHub du repo (ou `owner/repo`),
- installe,
- redémarre Lidarr.

Lidarr téléchargera l'asset `*.net8.0.zip` depuis la release.

---

## Build local (optionnel)

### PowerShell (Windows)

```powershell
./build-package.ps1 -Version 1.0.0
```

### Bash (Linux/macOS)

```bash
chmod +x ./build-package.sh
./build-package.sh 1.0.0
```

Le zip sera produit dans `artifacts/Lidarr.Plugin.AllReleases.net8.0.zip`.
