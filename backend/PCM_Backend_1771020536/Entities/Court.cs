namespace PCM_Backend_1771020536.Entities
{
    public class Court
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty; // Ví dụ: Sân 1, Sân 2
        public decimal PricePerHour { get; set; }        // Giá thuê (VD: 50.000 vnđ/h)
        public bool IsActive { get; set; } = true;
        public string? Description { get; set; }
    }
}