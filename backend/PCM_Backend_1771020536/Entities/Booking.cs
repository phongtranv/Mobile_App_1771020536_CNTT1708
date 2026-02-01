using System.ComponentModel.DataAnnotations.Schema;

namespace PCM_Backend_1771020536.Entities
{
    public class Booking
    {
        public int Id { get; set; }
        public int CourtId { get; set; }
        public string MemberId { get; set; } = string.Empty; 
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public decimal TotalPrice { get; set; }
        public string Status { get; set; } = "Confirmed";
        public bool IsRecurring { get; set; } = false;

        [ForeignKey("CourtId")]
        public Court? Court { get; set; }
        [ForeignKey("MemberId")]
        public AppUser? Member { get; set; }
    }
}