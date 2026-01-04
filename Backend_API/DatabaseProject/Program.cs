using Microsoft.EntityFrameworkCore;
using WorkoutTracker.Context;
using WorkoutTracker.Interfaces;
using WorkoutTracker.Services;
using WorkoutTracker.Endpoints;
using Models;

var builder = WebApplication.CreateBuilder(args);

// DB & DI
var connectionString = builder.Configuration.GetConnectionString("UTB");
builder.Services.AddDbContext<WorkoutDbContext>(options => options.UseSqlServer(connectionString));
builder.Services.AddScoped<IDbService, DbService>();

// Swift PascalCase Uyumu (Büyük Harf Ayarı)
builder.Services.Configure<Microsoft.AspNetCore.Http.Json.JsonOptions>(options => {
    options.SerializerOptions.PropertyNamingPolicy = null;
});

builder.Services.AddCors(options => {
    options.AddPolicy("AllowSwiftUI", p => p.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();
app.UseCors("AllowSwiftUI");

app.MapAllEndpoints(); // Bütün endpointleri bağladık

app.Run();