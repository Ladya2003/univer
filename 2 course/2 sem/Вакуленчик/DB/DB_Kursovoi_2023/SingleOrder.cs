using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DB_Kursovoi_2023
{
    public class SingleOrder
    {
        public decimal id { get; set; }
        public string brand { get; set; }
        public string model { get; set; }
        public decimal? weight { get; set; }
        public decimal? cost { get; set; }
        public string value { get; set; }
        public string name { get; set; }
        public string surname { get; set; }
        public decimal? quantity { get; set; }
        public decimal? IsTestDrive { get; set; }
    }
}
