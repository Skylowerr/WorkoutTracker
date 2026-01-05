using Microsoft.EntityFrameworkCore;
using WorkoutTracker.Context;
using WorkoutTracker.Interfaces;

namespace WorkoutTracker.Services
{
    public class DbService : IDbService
    {
        private readonly WorkoutDbContext _context;
        public DbService(WorkoutDbContext context) => _context = context;
        
        //If Exercise appears instead of T, it focuses on the Exercises table.
        public async Task<List<T>> GetAll<T>() where T : class 
            => await _context.Set<T>().ToListAsync();

        public async Task<T?> Get<T>(int id) where T : class 
            => await _context.Set<T>().FindAsync(id);

        public async Task<T> AddAsync<T>(T entity) where T : class
        {
            await _context.Set<T>().AddAsync(entity); //Veriyi hafızaya (takibe) ekler
            await _context.SaveChangesAsync(); // Hafızadaki değişikliği SQL'e INSERT INTO olarak yazar
            return entity;
        }

        public async Task UpdateAsync<T>(T entity) where T : class
        {
            _context.Set<T>().Update(entity); // Güncellenecek olarak işaretle
            await _context.SaveChangesAsync(); // SQL'e UPDATE komutunu gönderir
        }

        public async Task DeleteAsync<T>(int id) where T : class
        {
            var entity = await Get<T>(id);
            if (entity != null)
            {
                _context.Set<T>().Remove(entity); // Silinecek olarak işaretle
                await _context.SaveChangesAsync(); // SQL'den DELETE komutuyla kalıcı olarak uçur
            }
        }
    }
}
