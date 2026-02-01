using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCM_Backend_1771020536.Data;
using PCM_Backend_1771020536.Entities;
using System.Security.Claims;

namespace PCM_Backend_1771020536.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize] // BẮT BUỘC: Phải đăng nhập mới được nạp tiền
    public class WalletController : ControllerBase
    {
        private readonly AppDbContext _context;

        public WalletController(AppDbContext context)
        {
            _context = context;
        }

        // API 1: Nạp tiền (Có upload ảnh)
        [HttpPost("deposit")]
        public async Task<IActionResult> Deposit([FromForm] DepositRequest request)
        {
            // 1. Lấy ID người dùng từ Token
            var userId = User.FindFirst("UserId")?.Value;
            if (userId == null) return Unauthorized();

            // 2. Xử lý lưu ảnh (Nếu có gửi ảnh lên)
            string imagePath = "";
            if (request.ProofImage != null)
            {
                // Tạo thư mục lưu ảnh nếu chưa có
                var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "uploads");
                if (!Directory.Exists(uploadsFolder)) Directory.CreateDirectory(uploadsFolder);

                // Đặt tên file không trùng (Dùng Guid)
                var uniqueFileName = Guid.NewGuid().ToString() + "_" + request.ProofImage.FileName;
                var filePath = Path.Combine(uploadsFolder, uniqueFileName);

                // Lưu file vật lý
                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    await request.ProofImage.CopyToAsync(fileStream);
                }
                imagePath = "/uploads/" + uniqueFileName;
            }

            // 3. Tạo giao dịch (Lưu vào Database)
            var transaction = new WalletTransaction
            {
                MemberId = userId,
                Amount = request.Amount,
                Type = "Deposit", // Loại giao dịch: Nạp tiền
                Status = "Completed", // Tạm thời cho "Thành công" luôn để bạn test cho dễ
                EvidenceImageUrl = imagePath,
                Description = "Nạp tiền qua App",
                CreatedDate = DateTime.Now
            };

            _context.WalletTransactions.Add(transaction);

            // 4. Cộng tiền vào ví User luôn
            var user = await _context.Users.FindAsync(userId);
            if (user != null)
            {
                user.WalletBalance += request.Amount;
            }

            await _context.SaveChangesAsync();

            return Ok(new { Status = "Success", Message = "Nạp tiền thành công!", NewBalance = user?.WalletBalance });
        }

        // API 2: Xem lịch sử giao dịch
        [HttpGet("history")]
        public async Task<IActionResult> GetHistory()
        {
            var userId = User.FindFirst("UserId")?.Value;
            var history = await _context.WalletTransactions
                .Where(x => x.MemberId == userId)
                .OrderByDescending(x => x.CreatedDate)
                .ToListAsync();

            return Ok(history);
        }
    }

    // Class hứng dữ liệu từ Mobile gửi lên
    public class DepositRequest
    {
        public decimal Amount { get; set; }
        public IFormFile? ProofImage { get; set; } // File ảnh
    }
}