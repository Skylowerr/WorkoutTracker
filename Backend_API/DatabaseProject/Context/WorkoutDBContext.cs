using Microsoft.EntityFrameworkCore;
using Models;

namespace WorkoutTracker.Context
{
    public class WorkoutDbContext : DbContext
    {
        public WorkoutDbContext(DbContextOptions<WorkoutDbContext> options) : base(options) { }

        // Model dosyasındaki sınıf isminle aynı olmalı
        public DbSet<Exercise> Exercises { get; set; }
        public DbSet<MuscleGroup> MuscleGroups { get; set; }
    }
}