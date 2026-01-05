namespace WorkoutTracker.Interfaces
{
    public interface IDbService
    {
        //Interfaces (Contract) & Generics 
        Task<List<T>> GetAll<T>() where T : class;
        Task<T?> Get<T>(int id) where T : class;
        Task<T> AddAsync<T>(T entity) where T : class;
        Task UpdateAsync<T>(T entity) where T : class;
        Task DeleteAsync<T>(int id) where T : class;
    }
}
