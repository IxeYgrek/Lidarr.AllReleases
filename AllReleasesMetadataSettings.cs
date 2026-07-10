using FluentValidation;
using NzbDrone.Core.Annotations;
using NzbDrone.Core.Extras.Metadata;
using NzbDrone.Core.ThingiProvider;
using NzbDrone.Core.Validation;

namespace Lidarr.Plugin.AllReleases;

public class AllReleasesMetadataSettingsValidator : AbstractValidator<AllReleasesMetadataSettings>
{
}

public class AllReleasesMetadataSettings : IProviderConfig
{
    private static readonly AllReleasesMetadataSettingsValidator Validator = new();

    [FieldDefinition(0,
        Label = "All types and statuses",
        Type = FieldType.Checkbox,
        Section = MetadataSectionType.Metadata,
        HelpText = "Ignore Metadata Profile filtering and include all MusicBrainz release types/statuses.")]
    public bool AllTypesAndStatuses { get; set; } = true;

    public NzbDroneValidationResult Validate()
    {
        return new NzbDroneValidationResult(Validator.Validate(this));
    }
}
