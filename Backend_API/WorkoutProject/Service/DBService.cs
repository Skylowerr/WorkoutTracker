using Microsoft.EntityFrameworkCore;
using WorkoutTracker.Context;
using WorkoutTracker.Interfaces;

namespace WorkoutTracker.Services
{
    public class DbService : IDbService
    {
        private readonly WorkoutDbContext _context;
        public DbService(WorkoutDbContext context) => _context = context;

        public async Task<List<T>> GetAll<T>() where T : class 
            => await _context.Set<T>().ToListAsync();

        public async Task<T?> Get<T>(int id) where T : class 
            => await _context.Set<T>().FindAsync(id);

        public async Task<T> AddAsync<T>(T entity) where T : class
        {
            await _context.Set<T>().AddAsync(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public async Task UpdateAsync<T>(T entity) where T : class
        {
            _context.Set<T>().Update(entity);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync<T>(int id) where T : class
        {
            var entity = await Get<T>(id);
            if (entity != null)
            {
                _context.Set<T>().Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
    }
}