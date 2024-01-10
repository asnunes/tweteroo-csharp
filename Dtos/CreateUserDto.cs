
using System.ComponentModel.DataAnnotations;

public class CreateUserDto
{
    [Required]
    [MaxLength(256)]
    public required string Username { get; set; }

    [Required]
    [MaxLength(256)]
    public required string Avatar { get; set; }
}