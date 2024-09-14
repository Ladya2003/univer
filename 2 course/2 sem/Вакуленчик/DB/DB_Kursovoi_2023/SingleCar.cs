using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DB_Kursovoi_2023
{
    public class SingleCar
    {
        public decimal ID { get; set; }
        public string BRAND { get; set; }
        public string MODEL { get; set; }
        public string COLOR { get; set; }
        public decimal? WEIGHT { get; set; }
        public decimal? COST { get; set; }
        public string DESCRIPTION { get; set; }
        public string COMPANY_NAME { get; set; }
        public decimal? rating { get; set; }
        public string imageSource { get; set; }
    }
}
