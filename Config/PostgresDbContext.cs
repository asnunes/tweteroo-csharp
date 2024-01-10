using Microsoft.EntityFrameworkCore;

public class PostgresDbContext : DbContext
{
    public PostgresDbContext(DbContextOptions<PostgresDbContext> options) : base(options)
    {
    }

    public DbSet<User> Users { get; set; }
    public DbSet<Tweet> Tweets { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>()
            .HasIndex(u => u.Username);

        modelBuilder.Entity<Tweet>()
            .HasOne(t => t.User)
            .WithMany(u => u.Tweet)
            .HasForeignKey(t => t.UserId);
    }

}