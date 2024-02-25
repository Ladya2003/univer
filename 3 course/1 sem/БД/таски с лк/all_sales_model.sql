CREATE TABLE all_sales (
  year INTEGER NOT NULL,
  month INTEGER NOT NULL,
  prd_type_id INTEGER,
  emp_id INTEGER,
  amount NUMBER(8, 2),
  CONSTRAINT all_sales_pk PRIMARY KEY (
    year, month, prd_type_id, emp_id )
);

comment on column all_sales.year is
'Stores the year the sales took place';

comment on column all_sales.month is
'Stores the month the sales took place (1 to 12)';

comment on column all_sales.prd_type_id is
'Stores the product_type_id of the product';

comment on column all_sales.emp_id is
'Stores the employee_id of the employee who handled the sales';

comment on column all_sales.amount is
'Stores the total dollar amount of the sales';



-- insert sample data into all_sales table

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 1, 10034.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 2, 15144.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 3, 20137.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 4, 25057.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 5, 17214.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 6, 15564.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 7, 12654.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 8, 17434.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 9, 19854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 10, 21754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 11, 13029.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 1, 2003, 12, 10034.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 1, 1034.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 2, 1544.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 3, 2037.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 4, 2557.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 5, 1714.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 6, 1564.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 7, 1264.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 8, 1734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 9, 1854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 10, 2754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 11, 1329.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 2, 2003, 12, 1034.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 1, 6034.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 2, 1944.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 3, 2537.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 4, 4557.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 5, 3714.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 6, 3564.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 7, 21264.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 8, 21734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 9, 12854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 10, 32754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 11, 15329.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 3, 2003, 12, 14034.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 1, 3034.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 2, 2944.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 3, 5537.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 4, 3557.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 5, 2714.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 6, 7564.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 7, 1264.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 8, 21734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 9, 14854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 10, 22754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 11, 11329.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 4, 2003, 12, 11034.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 1, 11034.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 2, 16144.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 3, 24137.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 4, 29057.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 5, 19214.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 6, 16564.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 7, 13654.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 8, 17834.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 9, 21854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 10, 18754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 11, 16529.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 1, 2003, 12, 9434.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 1, 1234.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 2, 1044.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 3, 2537.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 4, 2657.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 5, 1314.56
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 6, 1264.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 7, 1964.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 8, 1234.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 9, 1954.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 10, 2254.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 11, 1229.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 2, 2003, 12, 1134.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 1, 6334.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 2, 1544.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 3, 2737.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 4, 4657.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 5, 3714.56
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 6, 3864.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 7, 27264.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 8, 17734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 9, 10854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 10, 15754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 11, 10329.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 3, 2003, 12, 12034.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 1, 3334.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 2, 2344.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 3, 5137.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 4, 3157.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 5, 2114.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 6, 7064.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 7, 1564.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 8, 12734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 9, 10854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 10, 20754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 11, 10329.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 4, 2003, 12, 2034.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 1, 4034.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 2, 7144.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 3, 12137.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 4, 16057.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 5, 13214.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 6, 3564.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 7, 7654.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 8, 5834.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 9, 6754.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 10, 12534.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 11, 2529.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 1, 2003, 12, 7434.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 1, 1234.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 2, 2244.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 3, 2137.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 4, 2357.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 5, 1314.56
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 6, 1364.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 7, 1364.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 8, 1334.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 9, 1354.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 10, 2354.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 11, 1329.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 2, 2003, 12, 1334.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 1, 6334.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 2, 1344.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 3, 2337.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 4, 4357.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 5, 3314.56
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 6, 3364.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 7, 23264.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 8, 13734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 9, 13854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 10, 13754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 11, 13329.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 3, 2003, 12, 13034.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 1, 3334.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 2, 2344.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 3, 5337.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 4, 3357.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 5, 2314.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 6, 7364.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 7, 1364.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 8, 13734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 9, 13854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 10, 23754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 11, 13329.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 4, 2003, 12, 2334.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 1, 7034.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 2, 17144.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 3, 22137.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 4, 24057.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 5, 25214.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 6, 14564.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 7, 17654.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 8, 15834.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 9, 15854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 10, 22754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 11, 14529.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 1, 2003, 12, 10434.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 1, 1934.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 2, 2844.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 3, 2837.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 4, 2697.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 5, 7314.56
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 6, 1864.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 7, 2364.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 8, 4334.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 9, 6654.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 10, 2254.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 11, 5429.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 2, 2003, 12, 3334.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 1, 2334.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 2, 4544.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 3, 6337.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 4, 3357.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 5, 2314.56
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 6, 1364.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 7, 5264.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 8, 1734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 9, 1854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 10, 1354.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 11, 1332.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 3, 2003, 12, 3034.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 1, 3364.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 2, 4344.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 3, 4337.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 4, 2357.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 5, 6314.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 6, 4364.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 7, 2364.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 8, 3734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 9, 3854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 10, 3754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 11, 1329.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 4, 2003, 12, 7334.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 1, 1234.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 2, 6144.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 3, 8137.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 4, 14057.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 5, 12214.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 6, 4564.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 7, 5654.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 8, 8834.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 9, 10854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 10, 12754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 11, 3529.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 1, 2003, 12, 5434.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 1, 3434.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 2, 1844.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 3, 2137.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 4, 1697.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 5, 4314.56
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 6, 3264.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 7, 5364.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 8, 3334.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 9, 2654.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 10, 454.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 11, 2429.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 2, 2003, 12, 1334.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 1, 1434.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 2, 3544.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 3, 1337.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 4, 1457.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 5, 1314.56
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 6, 4364.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 7, 1264.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 8, 2734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 9, 4354.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 10, 2354.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 11, 3432.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 3, 2003, 12, 1534.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 1, 1164.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 2, 2144.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 3, 4337.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 4, 1357.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 5, 2314.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 6, 2364.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 7, 3264.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 8, 2234.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 9, 3454.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 10, 2754.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 11, 3429.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 4, 2003, 12, 4334.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 1, 5534.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 2, 8844.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 3, 5137.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 4, 12057.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 5, 10214.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 6, 2564.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 7, 3654.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 8, 9834.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 9, 9854.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 10, 16754.27
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 11, 5529.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 1, 2003, 12, 3434.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 1, 5434.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 2, 3844.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 3, 5137.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 4, 3697.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 5, 2314.56
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 6, 5264.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 7, 3364.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 8, 4334.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 9, 4654.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 10, 3454.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 11, 4429.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 2, 2003, 12, 4334.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 1, 2434.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 2, 2544.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 3, 5337.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 4, 5457.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 5, 4314.56
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 6, 3364.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 7, 3264.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 8, 4734.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 9, 2354.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 10, 4354.34
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 11, 2432.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 3, 2003, 12, 4534.84
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 1, 3164.23
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 2, 3144.65
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 3, 6337.83
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 4, 2357.45
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 5, 4314.564
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 6, 4364.64
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 7, 2264.84
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 8, 4234.82
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 9, 2454.57
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 10, 1554.19
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 11, 2429.73
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 4, 2003, 12, 3334.85
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 1, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 2, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 3, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 4, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 5, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 6, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 7, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 8, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 9, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 10, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 11, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  21, 5, 2003, 12, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 1, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 2, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 3, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 4, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 5, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 6, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 7, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 8, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 9, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 10, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 11, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  22, 5, 2003, 12, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 1, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 2, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 3, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 4, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 5, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 6, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 7, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 8, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 9, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 10, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 11, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  23, 5, 2003, 12, NULL
);


INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 1, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 2, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 3, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 4, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 5, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 6, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 7, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 8, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 9, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 10, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 11, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  24, 5, 2003, 12, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 1, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 2, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 3, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 4, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 5, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 6, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 7, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 8, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 9, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 10, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 11, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  25, 5, 2003, 12, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 1, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 2, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 3, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 4, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 5, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 6, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 7, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 8, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 9, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 10, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 11, NULL
);

INSERT INTO all_sales (
  emp_id, prd_type_id, year, month, amount
) VALUES (
  26, 5, 2003, 12, NULL
);

-- commit the transaction
COMMIT;

CREATE TABLE all_sales (
  year INTEGER NOT NULL,
  month INTEGER NOT NULL,
  prd_type_id INTEGER,
  emp_id INTEGER,
  amount NUMBER(8, 2),
  CONSTRAINT all_sales_pk PRIMARY KEY (
    year, month, prd_type_id, emp_id )
);

comment on column all_sales.year is
'Stores the year the sales took place';

comment on column all_sales.month is
'Stores the month the sales took place (1 to 12)';

comment on column all_sales.prd_type_id is
'Stores the product_type_id of the product';

comment on column all_sales.emp_id is
'Stores the employee_id of the employee who handled the sales';

comment on column all_sales.amount is
'Stores the total dollar amount of the sales';



select * from all_sales;


with t (year, month, prd_type_id, emp_id,amount)
as
       (select *
        from all_sales)
select * from t
model
dimension by (emp_id)
         measures (amount, result)
          rules (
    result[0] = amount[0] + amount[0] * 0.1
  )


select year, month, prd_type_id, emp_id,plan_for_2023 from all_sales
model
  partition by (emp_id)
  dimension by (amount)
  measures (plan_for_2023 amount)
  rules (plan_for_2023 [0] = amount[0] + all_sales.amount[0]*0.1)
  order by prd_type_id;


WITH MaxSales2003 AS (
  SELECT emp_id, month,MAX(amount) AS max_amount
  FROM all_sales WHERE year = 2003
  GROUP BY emp_id, month
),
SalesPlan2023 AS (
  SELECT
    s.emp_id,
    s.month,
    s.amount AS max_amount_2022,
    CASE
      WHEN s.emp_id IN (21, 22) THEN ROUND(s.amount * 1.10, 2)
      ELSE ROUND(s.amount * 1.05, 2)
    END AS sales_plan_2023
  FROM
    all_sales s
  WHERE
    s.year = 2022
) select * from MaxSales2022;


select  year, month, prd_type_id, emp_id, amount
from all_sales
model
  partition by (emp_id,month)
  dimension by (year)
  measures (amount sales_amount)
  rules (sales_amount[1,2003] = sales_amount[1,2022])
order by year DESC ,  month, prd_type_id, emp_id, amount



SELECT year, month, emp_id, max_sales_amount
FROM all_sales
MODEL
  PARTITION BY (month)
  DIMENSION BY (year)
  MEASURES (amount AS max_sales_amount, emp_id AS emp_id, RANK() OVER (PARTITION BY month ORDER BY amount DESC) AS rnk)
  RULES (max_sales_amount[2003, 1] = max_sales_amount[2003, 1],
         max_sales_amount[2003, 2] = max_sales_amount[2003, 2],
         max_sales_amount[2003, 3] = max_sales_amount[2003, 3],
         max_sales_amount[2003, 4] = max_sales_amount[2003, 4],
         max_sales_amount[2003, 5] = max_sales_amount[2003, 5],
         max_sales_amount[2003, 6] = max_sales_amount[2003, 6],
         max_sales_amount[2003, 7] = max_sales_amount[2003, 7],
         max_sales_amount[2003, 8] = max_sales_amount[2003, 8],
         max_sales_amount[2003, 9] = max_sales_amount[2003, 9],
         max_sales_amount[2003, 10] = max_sales_amount[2003, 10],
         max_sales_amount[2003, 11] = max_sales_amount[2003, 11],
         max_sales_amount[2003, 12] = max_sales_amount[2003, 12])
         
         
SELECT EMP_ID, PRD_TYPE_ID, year, month, sales_amount
FROM ALL_SALES
    MODEL
        PARTITION BY (PRD_TYPE_ID, month)
        DIMENSION BY(emp_id, year)
        MEASURES(amount sales_amount)
        RULES( sales_amount[FOR emp_id FROM 22 TO 23 INCREMENT 1, 2022] = sales_amount[22, 2022] * 1.1,
               sales_amount[emp_id < 22, 2022] = sales_amount[cv(emp_id),2022] * 1.05,
               sales_amount[emp_id > 23, 2022] = sales_amount[cv(emp_id),2022] * 1.05)
ORDER BY year DESC, month, emp_id, prd_type_id;

SELECT EMP_ID, PRD_TYPE_ID, year, month, sales_amount
FROM ALL_SALES
    MODEL
        PARTITION BY(PRD_TYPE_ID, EMP_ID)
        DIMENSION BY (month, year)
        MEASURES(amount sales_amount)
        RULES(sales_amount[FOR month FROM 1 TO 12 INCREMENT 1, 2023] = 
        AVG(sales_amount)[month BETWEEN (cv() - 2) AND cv(), 2022]
        )
ORDER BY year DESC, month, emp_id, prd_type_id

SELECT EMP_ID, PRD_TYPE_ID, year, month, sales_amount
FROM ALL_SALES
    MODEL
        PARTITION BY(PRD_TYPE_ID)
        DIMENSION BY (EMP_ID, MONTH, YEAR)
        MEASURES(AMOUNT sales_amount)
        RULES (sales_amount[FOR EMP_ID FROM 21 TO 26 INCREMENT 1, FOR MONTH FROM 1 TO 12 INCREMENT 1, 2023]
        = (MAX(sales_amount)[EMP_ID BETWEEN 21 AND 26, cv(), 2022] - sales_amount[cv(),cv(), 2022])/2 + sales_amount[cv(),cv(), 2022]
        )
ORDER BY YEAR ASC, MONTH, EMP_ID, PRD_TYPE_ID;