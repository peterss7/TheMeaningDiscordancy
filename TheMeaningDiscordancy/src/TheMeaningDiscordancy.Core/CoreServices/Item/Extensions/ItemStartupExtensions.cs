using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using TheMeaningDiscordancy.Core.CoreServices.Item.Interfaces;

namespace TheMeaningDiscordancy.Core.CoreServices.Item.Extensions;

public static class ItemStartupExtensions
{
    public static void ConfigureItemServices(this IServiceCollection services)
    {
        services.ConfigureServices();
    }

    private static void ConfigureServices(this IServiceCollection services)
    {
        services.AddScoped<IItemService, ItemService>();
    }

    private static void ConfigureRespositories(this IServiceCollection services)
    {
    }
}
