public class Course
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public List<Module> ModuleCollection { get; set; }

    // Author: Foreign key and
    // Reference Navigation Property
    public User Author { get; set; }

    // Contributor: Foreign key and
    // Reference Navigation Property
    public User Contributor { get; set; }
}

public class User
{
    public int Id { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }

    [InverseProperty("Author")]
    public List<Course> Authors { get; set; }

    [InverseProperty("Contributor")]
    public List<Course> ContributedToCourse { get; set; 
