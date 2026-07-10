using NzbDrone.Core.Extras.Metadata;
using NzbDrone.Core.Extras.Metadata.Files;
using NzbDrone.Core.MediaFiles;
using NzbDrone.Core.Music;

namespace Lidarr.Plugin.AllReleases;

public class AllReleasesMetadata : MetadataBase<AllReleasesMetadataSettings>
{
    public override string Name => "All Releases Filter Override";

    public override MetadataFile? FindMetadataFile(Artist artist, string path)
    {
        return null;
    }

    public override MetadataFileResult? ArtistMetadata(Artist artist)
    {
        return null;
    }

    public override MetadataFileResult? AlbumMetadata(Artist artist, Album album, string albumPath)
    {
        return null;
    }

    public override MetadataFileResult? TrackMetadata(Artist artist, TrackFile trackFile)
    {
        return null;
    }

    public override List<ImageFileResult> ArtistImages(Artist artist)
    {
        return new List<ImageFileResult>();
    }

    public override List<ImageFileResult> AlbumImages(Artist artist, Album album, string albumPath)
    {
        return new List<ImageFileResult>();
    }

    public override List<ImageFileResult> TrackImages(Artist artist, TrackFile trackFile)
    {
        return new List<ImageFileResult>();
    }
}
