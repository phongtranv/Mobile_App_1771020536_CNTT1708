using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using PCM_Backend_1771020536.Data;

namespace PCM_Backend_1771020536
{
    public class AppDbContextFactory : IDesignTimeDbContextFactory<AppDbContext>
    {
        public AppDbContext CreateDbContext(string[] args)
        {
            // Chuỗi kết nối cứng (Đảm bảo 100% kết nối được)
            var connectionString = "Server=(localdb)\\MSSQLLocalDB;Database=PCM_Exam_DB_1771020536;Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=True";

            var builder = new DbContextOptionsBuilder<AppDbContext>();
            builder.UseSqlServer(connectionString);

            return new AppDbContext(builder.Options);
        }
    }
}