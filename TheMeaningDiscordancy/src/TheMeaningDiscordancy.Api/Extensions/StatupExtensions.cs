using TheMeaningDiscordancy.Core.CoreServices;
using TheMeaningDiscordancy.Infrastructure.Extensions;

namespace TheMeaningDiscordancy.Api.Extensions;

public static class StatupExtensions
{
    public static void ConfigureServices(this IServiceCollection services)
    {
        services.ConfigurePersistenceServices();
        services.ConfigureCoreServices();
    }
}
