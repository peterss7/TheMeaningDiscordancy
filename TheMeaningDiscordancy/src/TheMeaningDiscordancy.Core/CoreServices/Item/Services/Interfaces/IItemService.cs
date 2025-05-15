using TheMeaningDiscordancy.Core.CoreServices.Item.Models.Entities;
using TheMeaningDiscordancy.Core.Results;

namespace TheMeaningDiscordancy.Core.CoreServices.Item.Services.Interfaces;

public interface IItemService
{
    Task<DiscordResult<ItemEfc?>> GetItemAsync(int id);
}
