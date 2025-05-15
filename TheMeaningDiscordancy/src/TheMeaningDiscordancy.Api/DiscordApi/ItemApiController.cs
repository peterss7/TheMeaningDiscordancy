using Microsoft.AspNetCore.Mvc;

namespace TheMeaningDiscordancy.Api.DiscordApi;

[ApiController]
[Route(PATH_ITEM_API)]
public class ItemApiController
{
    private const string PATH_ITEM_API = "items";
    private const string PATH_ITEM_GET = "get";

    private readonly ILogger<ItemApiController> _logger;

    public ItemApiController(ILogger<ItemApiController> logger)
    {
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
