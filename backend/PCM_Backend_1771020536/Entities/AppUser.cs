using Microsoft.AspNetCore.Identity;

namespace PCM_Backend_1771020536.Entities
{
    public class AppUser : IdentityUser
    {
        public string FullName { get; set; } = string.Empty;
        public string Tier { get; set; } = "Standard"; // Hạng: Standard, Silver, Gold, Diamond
        public decimal WalletBalance { get; set; } = 0; // Số dư ví điện tử
        public decimal TotalSpent { get; set; } = 0;    // Tổng chi tiêu (để tính hạng)
        public string? AvatarUrl { get; set; }          // Link ảnh đại diện
    }
}