//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DB_Kursovoi_2023
{
    using System;
    using System.Collections.Generic;
    
    public partial class ORDERTABLE
    {
        public decimal ID { get; set; }
        public Nullable<decimal> IDCLIENT { get; set; }
        public Nullable<decimal> IDCAR { get; set; }
        public Nullable<decimal> QUANTITY { get; set; }
        public Nullable<bool> ISTESTDRIVE { get; set; }
    
        public virtual CAR CAR { get; set; }
        public virtual CLIENT CLIENT { get; set; }
    }
}
