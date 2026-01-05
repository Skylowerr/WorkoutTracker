using System.ComponentModel.DataAnnotations.Schema;

namespace Models
{
    // Egzersiz bilgilerini tutan ana sınıf
    [Table("Exercises")] //Exercises in SQL
    public class Exercise
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public bool IsCardio { get; set; }
        public int Sets { get; set; }
        public int Reps { get; set; }
        public int MuscleGroupID { get; set; }
    }

    [Table("MuscleGroups")]
    public class MuscleGroup
    {
        public int Id { get; set; }
        public string GroupName { get; set; } = string.Empty;
        public int YearEstablished { get; set; }
    }
}
