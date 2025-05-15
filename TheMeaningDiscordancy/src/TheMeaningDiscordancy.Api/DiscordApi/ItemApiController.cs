using Microsoft.AspNetCore.Mvc;
using TheMeaningDiscordancy.Core.CoreServices.Item.Services.Interfaces;

namespace TheMeaningDiscordancy.Api.DiscordApi;

[ApiController]
[Route(PATH_ITEM_API)]
public class ItemApiController : Controller
{
    private const string PATH_ITEM_API = "items";
    private const string PATH_ITEM_GET = "get";

    private readonly ILogger<ItemApiController> _logger;
    private readonly IItemService _itemService;

    public ItemApiController(ILogger<ItemApiController> logger,
        IItemService itemService)
    {
        _itemService = itemService;
        _logger = logger;
    }

    [HttpGet(PATH_ITEM_GET)]
    [ProducesResponseType(200)]
    [ProducesResponseType(404)]
    [ProducesResponseType(500)]
    public async Task<IActionResult> GetItem(int id)
    {
        return null;
    }
}
