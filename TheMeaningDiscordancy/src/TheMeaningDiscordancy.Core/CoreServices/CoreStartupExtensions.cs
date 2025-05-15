using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheMeaningDiscordancy.Core.CoreServices;

public static class CoreStartupExtensions
{
    public static void ConfigureCoreServices(this IServiceCollection services)
    {
        services.ConfigureItemServices();
    }
}
