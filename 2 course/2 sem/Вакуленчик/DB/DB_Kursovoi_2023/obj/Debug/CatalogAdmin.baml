   M S B A M L   `   `   `  ����K  GDB_Kursovoi_2023, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null3clr-namespace:DB_Kursovoi_2023DB_Kursovoi_2023  5      #    DB_Kursovoi_2023.CatalogAdmin   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      0localclr-namespace:DB_Kursovoi_2023     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5        � Title$  CatalogAdmin��5      $	��800��5	      $	��450��5
      .��5      �  � RowDefinitions 5   
   �� 5      $��* �6   �� 5      $
��0.2* �6   .+�5   
   �� -   5         ��Name$ 
allTabCtrl��5      $��0��6)   .@�5      �� $��ORDER��6   ��5      &   System.Windows.Controls.DataGrid  5      -   5          Name$ 
tableOrder��5         
IsReadOnly . 63   5      �� 5      $��CLIENT��6   ��5        5      -   5        $ tableClient��5       . 64   5      �� 5      $	��CAR��6   ��5         5!      -   5        $ tableCar��5!       . 61   5#      �� 5%      $��SUPPLIER��6   ��5&        5'      -   5        $ tableSupplier��5'       . 66   5)      5*      � 5+   
   $��1��6    � ColumnDefinitions 5,      �� 5-      $��* �6#   �� 5.      $
��0.2* �6#   .+�50      ��  �� Orientation$ 
Horizontal=�6   .+�51      �� -   5        $��40��52      $��10,0,0,0q�53      $
��15,5q�54      $	��Add��56      �� 58      -   5        $��40��59      $��10,0,0,0q�5:      $
��15,5q�5;      $��Delete��5=      �� 5?      -   5        $��40��5@      $��10,0,0,0q�5A      $
��15,5q�5B      $
��Edit��5D      �� 5F      -	   5        $��40��5G      $��10,0,0,0q�5H      $
��15,5q�5I      $��Refresh��5K      5L      � 5M      $��1��6   .+�5N      �� -
   5        $��40��5O      $��	10,0,10,0q�5P      $
��10,5q�5Q      $��Sign in��5S      5T      5U      5W      5X      