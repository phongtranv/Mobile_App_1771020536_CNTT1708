using System.ComponentModel.DataAnnotations.Schema;

namespace PCM_Backend_1771020536.Entities
{
    public class WalletTransaction
    {
        public int Id { get; set; }
        public string MemberId { get; set; } = string.Empty; 
        public decimal Amount { get; set; }
        public string Type { get; set; } = "Deposit";       
        public string Status { get; set; } = "Pending";    
        public string? EvidenceImageUrl { get; set; }
        public string? Description { get; set; }
        public DateTime CreatedDate { get; set; } = DateTime.Now;

        [ForeignKey("MemberId")]
        public AppUser? Member { get; set; }
    }
}