using Microsoft.EntityFrameworkCore;
using Models;

namespace WorkoutTracker.Context
{
    public class WorkoutDbContext : DbContext
    {
        public WorkoutDbContext(DbContextOptions<WorkoutDbContext> options) : base(options) { }

        //SQL'deki tabloları C# tarafında sanal bir liste haline getirir
        //Bunlar üzerinde işlem yaptığımzda SQL komuduna çevirir
        public DbSet<Exercise> Exercises { get; set; }
        public DbSet<MuscleGroup> MuscleGroups { get; set; }
    }
}
