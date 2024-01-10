
using System.ComponentModel.DataAnnotations;

public class CreateTweetDto
{
    [Required]
    [MaxLength(256)]
    public required string Username { get; set; }

    [Required]
    [MaxLength(256)]
    public required string Tweet { get; set; }
}