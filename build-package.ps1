param(
    [string]$Version = "1.0.0"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path "Submodules/Lidarr")) {
    git clone --depth 1 --branch plugins https://github.com/Lidarr/Lidarr.git Submodules/Lidarr
}

dotnet restore .\Lidarr.AllReleases.csproj --configfile .\NuGet.config
$RepoUrl = "https://github.com/OWNER/Lidarr.AllReleases"

$RemoteUrl = (git remote get-url origin) 2>$null
if ($LASTEXITCODE -eq 0 -and $RemoteUrl) {
    if ($RemoteUrl -match "github.com[:/](.+?/.+?)(\.git)?$") {
        $RepoUrl = "https://github.com/$($Matches[1])"
    }
}

dotnet build .\Lidarr.AllReleases.csproj -c Release --no-restore -p:Version=$Version -p:RepositoryUrl=$RepoUrl -p:NuGetAudit=false -p:RunAnalyzers=false -p:TreatWarningsAsErrors=false -p:WarningsAsErrors=

New-Item -ItemType Directory -Path .\artifacts\package -Force | Out-Null
Copy-Item .\bin\Release\net8.0\Lidarr.Plugin.AllReleases.dll .\artifacts\package\ -Force
if (Test-Path .\bin\Release\net8.0\Lidarr.Plugin.AllReleases.pdb) {
    Copy-Item .\bin\Release\net8.0\Lidarr.Plugin.AllReleases.pdb .\artifacts\package\ -Force
}

if (Get-Command Compress-Archive -ErrorAction SilentlyContinue) {
    Compress-Archive -Path .\artifacts\package\* -DestinationPath .\artifacts\Lidarr.Plugin.AllReleases.net8.0.zip -Force
}
else {
    throw "Compress-Archive not available"
}

Write-Host "Created artifacts/Lidarr.Plugin.AllReleases.net8.0.zip"
