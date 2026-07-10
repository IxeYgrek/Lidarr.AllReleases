#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-1.0.0}"

if [ ! -d "Submodules/Lidarr" ]; then
  git clone --depth 1 --branch plugins https://github.com/Lidarr/Lidarr.git Submodules/Lidarr
fi

REPO_URL="https://github.com/OWNER/Lidarr.AllReleases"
if git remote get-url origin >/dev/null 2>&1; then
  REMOTE_URL="$(git remote get-url origin)"
  if [[ "$REMOTE_URL" =~ github.com[:/]([^/]+/[^/.]+)(\.git)?$ ]]; then
    REPO_URL="https://github.com/${BASH_REMATCH[1]}"
  fi
fi

dotnet restore ./Lidarr.AllReleases.csproj --configfile ./NuGet.config -p:NuGetAudit=false
dotnet build ./Lidarr.AllReleases.csproj -c Release --no-restore -p:Version="$VERSION" -p:RepositoryUrl="$REPO_URL" -p:NuGetAudit=false -p:RunAnalyzers=false -p:TreatWarningsAsErrors=false -p:WarningsAsErrors=

mkdir -p artifacts/package
cp -f ./bin/Release/net8.0/Lidarr.Plugin.AllReleases.dll artifacts/package/
if [ -f ./bin/Release/net8.0/Lidarr.Plugin.AllReleases.pdb ]; then
  cp -f ./bin/Release/net8.0/Lidarr.Plugin.AllReleases.pdb artifacts/package/
fi

(
  cd artifacts/package
  zip -r ../Lidarr.Plugin.AllReleases.net8.0.zip .
)

echo "Created artifacts/Lidarr.Plugin.AllReleases.net8.0.zip"
