using Microsoft.AspNetCore.Mvc;

namespace stonepoc.Controllers;

[ApiController]
[Route("[controller]")]
public class HealthController : ControllerBase
{
    [HttpGet(Name = "GetHealth")]
    public IActionResult Get()
    {
        var healthStatus = new Health();
        return Ok(healthStatus);
    }
}