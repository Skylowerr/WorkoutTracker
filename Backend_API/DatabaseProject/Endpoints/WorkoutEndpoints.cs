using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Routing;
using WorkoutTracker.Interfaces;
using Models;

namespace WorkoutTracker.Endpoints
{
    public static class WorkoutEndpoints
    {
        public static void MapAllEndpoints(this IEndpointRouteBuilder app)
        {
            // --- EXERCISE ENDPOINTS ---
            var exGroup = app.MapGroup("/api/exercises");

            exGroup.MapGet("/", async (IDbService db, string? search) =>
            {
                var list = await db.GetAll<Exercise>();
                if (!string.IsNullOrEmpty(search))
                    return Results.Ok(list.Where(x => x.Name.Contains(search, StringComparison.OrdinalIgnoreCase)));
                return Results.Ok(list);
            });

            exGroup.MapGet("/{id}", async (IDbService db, int id) => 
                await db.Get<Exercise>(id) is Exercise item ? Results.Ok(item) : Results.NotFound());

            exGroup.MapPost("/", async (IDbService db, Exercise item) => {
                await db.AddAsync(item);
                return Results.Created($"/api/exercises/{item.Id}", item);
            });

            exGroup.MapPut("/{id}", async (IDbService db, int id, Exercise input) => {
                var existing = await db.Get<Exercise>(id);
                if (existing == null) return Results.NotFound();
                existing.Name = input.Name;
                existing.Description = input.Description;
                existing.IsCardio = input.IsCardio;
                existing.Sets = input.Sets;
                existing.Reps = input.Reps;
                existing.MuscleGroupID = input.MuscleGroupID;
                await db.UpdateAsync(existing);
                return Results.NoContent();
            });

            exGroup.MapDelete("/{id}", async (IDbService db, int id) => {
                await db.DeleteAsync<Exercise>(id);
                return Results.NoContent();
            });

            // --- MUSCLE GROUP ENDPOINTS ---
            var mgGroup = app.MapGroup("/api/musclegroups");

            // WorkoutEndpoints.cs içinde
            mgGroup.MapGet("/", async (IDbService db) => {
                var list = await db.GetAll<MuscleGroup>();
                // Eğer liste null ise hata vermek yerine boş bir liste [] döndür
                return Results.Ok(list ?? new List<MuscleGroup>()); 
            });
            
            
            mgGroup.MapPost("/", async (IDbService db, MuscleGroup item) => {
                var allGroups = await db.GetAll<MuscleGroup>();
                
                // Aynı isimde (büyük/küçük harf duyarsız) grup var mı kontrol et
                if (allGroups.Any(x => x.GroupName.Equals(item.GroupName, StringComparison.OrdinalIgnoreCase)))
                {
                    return Results.Conflict("Bu kategori zaten mevcut.");
                }

                await db.AddAsync(item);
                return Results.Created($"/api/musclegroups/{item.Id}", item);
            });

            mgGroup.MapPut("/{id}", async (IDbService db, int id, MuscleGroup input) => {
                var existing = await db.Get<MuscleGroup>(id);
                if (existing == null) return Results.NotFound();
                existing.GroupName = input.GroupName;
                existing.YearEstablished = input.YearEstablished;
                await db.UpdateAsync(existing);
                return Results.NoContent();
            });

            mgGroup.MapDelete("/{id}", async (IDbService db, int id) => {
                await db.DeleteAsync<MuscleGroup>(id);
                return Results.NoContent();
            });
        }
    }
}