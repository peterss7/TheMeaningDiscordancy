using Microsoft.Extensions.Logging;
using TheMeaningDiscordancy.Core.CoreServices.Item.Models.Entities;
using TheMeaningDiscordancy.Core.CoreServices.Item.Repositories.Interfaces;
using TheMeaningDiscordancy.Infrastructure;

namespace TheMeaningDiscordancy.Core.CoreServices.Item.Repositories;

public class ItemRepository : IItemRepository
{
    private readonly DiscordContext _context;
    private readonly ILogger<ItemRepository> _logger;

    public ItemRepository(DiscordContext context,
        ILogger<ItemRepository> logger)
    {
        _context = context;
        _logger = logger;
    }

    public Task CreateAsync(ItemEfc entity)
    {
        throw new NotImplementedException();
    }

    public Task CreateAsync(List<ItemEfc> entities)
    {
        throw new NotImplementedException();
    }

    public void Delete(ItemEfc entity)
    {
        throw new NotImplementedException();
    }

    public Task<List<ItemEfc>> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public Task<ItemEfc?> GetAsync(int id)
    {
        throw new NotImplementedException();
    }

    public Task SaveChangesAsync()
    {
        throw new NotImplementedException();
    }

    public void Update(ItemEfc entity)
    {
        throw new NotImplementedException();
    }
}
