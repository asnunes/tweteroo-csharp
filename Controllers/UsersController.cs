using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace stonepoc.Controllers;

[ApiController]
[Route("[controller]")]
public class UsersController(PostgresDbContext context) : ControllerBase
{
    private readonly PostgresDbContext _context = context;

    [HttpPost(Name = "PostUsers")]
    public async Task<IActionResult> Post([FromBody] CreateUserDto createUserDto)
    {
        var existingUser = await _context.Users.FirstOrDefaultAsync(u => u.Username == createUserDto.Username);
        if (existingUser != null)
        {
            return Ok(existingUser);
        }

        var newUser = new User
        {
            Username = createUserDto.Username,
            Avatar = createUserDto.Avatar
        };


        await _context.Users.AddAsync(newUser);
        await _context.SaveChangesAsync();

        return CreatedAtRoute("GetUsers/{id}", new { id = newUser.Id }, newUser);
    }

    [HttpGet(Name = "GetUsers")]
    public async Task<IActionResult> Get()
    {
        var users = await _context.Users.ToListAsync();
        return Ok(users);
    }

    [HttpGet("{id}", Name = "GetUsers/{id}")]
    public async Task<IActionResult> Get(int id)
    {
        var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == id);
        if (user == null)
        {
            return NotFound();
        }

        return Ok(user);
    }
}