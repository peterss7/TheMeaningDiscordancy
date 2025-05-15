using Microsoft.Extensions.Logging;
using TheMeaningDiscordancy.Core.CoreServices.Item.Models.Entities;
using TheMeaningDiscordancy.Core.CoreServices.Item.Repositories.Interfaces;
using TheMeaningDiscordancy.Core.CoreServices.Item.Services.Interfaces;
using TheMeaningDiscordancy.Core.Results;

namespace TheMeaningDiscordancy.Core.CoreServices.Item.Services;

public class ItemService : IItemService
{
    private readonly IItemRepository _itemRepository;
    private readonly ILogger<ItemService> _logger;

    public ItemService(IItemRepository itemRepository,
        ILogger<ItemService> logger)
    {
        _itemRepository = itemRepository;
        _logger = logger;
    }

    public async Task<DiscordResult<ItemEfc?>> GetItemAsync(int id)
    {
        DiscordResult<ItemEfc?> result = new();

        try
        {
            var t = await _itemRepository.GetAsync(id);
        }
        catch (Exception ex)
        {
            _logger.LogError("An error occurred while trying to GetItemAsync: {ErrorMessage}", ex.Message);
            result.Errors.Add(new DiscordError(Error.ExceptionError, ex.Message));
        }

        return result;
    }
}
