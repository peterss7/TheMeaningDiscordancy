using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheMeaningDiscordancy.Infrastructure.Repositories.Interfaces;
using TheMeaningDiscordancy.Infrastructure.Repositories;

namespace TheMeaningDiscordancy.Infrastructure.Extensions;

public static class DiscordStartupExtensions
{
    public static void ConfigureDiscordServices(this IServiceCollection services)
    {
        services.ConfigureRepositories();
    }

    private static void ConfigureRepositories(this IServiceCollection services)
    {
        services.AddScoped(typeof(IDiscordRepository), typeof(DiscordRepository));
    }
}
