using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using PCM_Backend_1771020536.Entities;

namespace PCM_Backend_1771020536.Data
{
    public class AppDbContext : IdentityDbContext<AppUser>
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Court> Courts { get; set; }
        public DbSet<Booking> Bookings { get; set; }
        public DbSet<WalletTransaction> WalletTransactions { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            // 1. Đổi tên bảng theo MSSV
            builder.Entity<Court>().ToTable("536_Courts");
            builder.Entity<Booking>().ToTable("536_Bookings");
            builder.Entity<WalletTransaction>().ToTable("536_WalletTransactions");

            // 2. FIX LỖI DECIMAL: Cấu hình độ chính xác cho tiền tệ
            foreach (var property in builder.Model.GetEntityTypes()
                .SelectMany(t => t.GetProperties())
                .Where(p => p.ClrType == typeof(decimal) || p.ClrType == typeof(decimal?)))
            {
                property.SetColumnType("decimal(18,2)");
            }

            // 3. Seed Data (Dữ liệu mẫu)
            builder.Entity<Court>().HasData(
                new Court { Id = 1, Name = "Sân 1 (VIP)", PricePerHour = 100000 },
                new Court { Id = 2, Name = "Sân 2 (Thường)", PricePerHour = 50000 }
            );
        }
    }
}