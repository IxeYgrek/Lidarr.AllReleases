using System.Reflection;
using NzbDrone.Core.Plugins;

namespace Lidarr.Plugin.AllReleases;

public class AllReleasesPlugin : Plugin
{
    private static readonly string RepoUrl = ResolveRepositoryUrl();

    public override string Name => "Lidarr.AllReleases";

    public override string Owner => ResolveOwner(RepoUrl);

    public override string GithubUrl => RepoUrl;

    private static string ResolveRepositoryUrl()
    {
        var repo = typeof(AllReleasesPlugin).Assembly
            .GetCustomAttributes<AssemblyMetadataAttribute>()
            .FirstOrDefault(x => x.Key == "RepositoryUrl")
            ?.Value;

        return string.IsNullOrWhiteSpace(repo)
            ? "https://github.com/OWNER/Lidarr.AllReleases"
            : repo;
    }

    private static string ResolveOwner(string url)
    {
        try
        {
            var uri = new Uri(url);
            var parts = uri.AbsolutePath.Trim('/').Split('/');
            return parts.Length > 0 ? parts[0] : "unknown";
        }
        catch
        {
            return "unknown";
        }
    }
}
