using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace stonepoc.Controllers;

[ApiController]
[Route("[controller]")]
public class TweetsController(PostgresDbContext context) : ControllerBase
{
    private readonly PostgresDbContext _context = context;

    [HttpPost(Name = "PostTweets")]
    public async Task<IActionResult> Post([FromBody] CreateTweetDto createTweetDto)
    {
        var existingUser = await _context.Users.FirstOrDefaultAsync(u => u.Username == createTweetDto.Username);
        if (existingUser == null)
        {
            return UnprocessableEntity(new { message = "User does not exist" });
        }

        var newTweet = new Tweet
        {
            UserId = existingUser.Id,
            Value = createTweetDto.Tweet
        };


        await _context.Tweets.AddAsync(newTweet);
        await _context.SaveChangesAsync();

        return CreatedAtRoute("GetTweets/{id}", new { id = newTweet.Id }, new { message = "Ok" });
    }

    [HttpGet(Name = "GetTweets")]
    public async Task<IActionResult> Get()
    {
        var tweets = await _context.Tweets
            .OrderByDescending(t => t.Id)
            .Take(10)
            .ToListAsync();

        return Ok(tweets);
    }

    [HttpGet("{id}", Name = "GetTweets/{id}")]
    public async Task<IActionResult> Get(int id)
    {
        var tweet = await _context.Tweets.FirstOrDefaultAsync(t => t.Id == id);
        if (tweet == null)
        {
            return NotFound();
        }

        return Ok(tweet);
    }
}