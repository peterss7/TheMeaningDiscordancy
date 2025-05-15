using Microsoft.Extensions.DependencyInjection;
using TheMeaningDiscordancy.Core.CoreServices.Item.Extensions;

namespace TheMeaningDiscordancy.Core.CoreServices;

public static class CoreStartupExtensions
{
    public static void ConfigureCoreServices(this IServiceCollection services)
    {
        services.ConfigureItemServices();
    }
}
