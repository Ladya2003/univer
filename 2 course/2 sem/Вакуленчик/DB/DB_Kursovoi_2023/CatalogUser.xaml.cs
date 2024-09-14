using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.ComponentModel;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace DB_Kursovoi_2023
{
    /// <summary>
    /// Логика взаимодействия для CatalogUser.xaml
    /// </summary>
    public partial class CatalogUser : Window
    {
        BindingList<SingleCar> cars = new BindingList<SingleCar>();
        BindingList<SingleCar> searchCars = new BindingList<SingleCar>();

        decimal _userId;
        string _userName, _userSurname;
        decimal? quantityCount = 0;
        int isTestDrive = 0;

        //public CatalogUser()
        //{

        //}
        public CatalogUser(decimal userId, string userName, string userSurname)
        {
            InitializeComponent();
            _userId = userId;
            _userName = userName;
            _userSurname = userSurname;

            clientNameTxtBlock.Text = userName;
            clientSurNameTxtBlock.Text = userSurname;
            //clientNameTxtBlock2.Text = "0";


            using (Entities3 ent = new Entities3())
            {

                cars.Clear();
                foreach (var item in ent.GETALLCARINFO())
                {
                    cars.Add(new SingleCar()
                    {
                        ID = item.ID,
                        BRAND = item.BRAND,
                        MODEL = item.MODEL,
                        COLOR = item.COLOR,
                        WEIGHT = item.WEIGHT,
                        COST = item.COST,
                        DESCRIPTION = item.DESCRIPTION,
                        COMPANY_NAME = item.COMPANY_NAME,
                        rating = item.CARRATING,
                        imageSource = item.IMGSOURCE
                    });
                }

                Autos.ItemsSource = cars;
            }
            //using (Entities2 ent = new Entities2())
            //{

            //    cars.Clear();
            //    foreach (var item in ent.GETALLCARINFO())
            //    {
            //        cars.Add(new SingleCar()
            //        {
            //            ID = item.ID,
            //            BRAND = item.BRAND,
            //            MODEL = item.MODEL,
            //            COLOR = item.COLOR,
            //            WEIGHT = item.WEIGHT,
            //            COST = item.COST,
            //            DESCRIPTION = item.DESCRIPTION,
            //            COMPANY_NAME = item.COMPANY_NAME,
            //            rating = item.CARRATING,
            //            imageSource = item.IMGSOURCE
            //        });
            //    }

            //    Autos.ItemsSource = cars;
            //}
        }

        private void SearchBox_TextChanged(object sender, System.Windows.Controls.TextChangedEventArgs e)
        {

            using (Entities2 ent = new Entities2())
            {
                if (SearchBox.Text == string.Empty)
                {
                    Autos.ItemsSource = cars;
                }
                else
                {
                    searchCars.Clear();
                    foreach (var item in ent.GETALLCARINFO())
                    {
                        if (item.BRAND.ToLower().Contains(SearchBox.Text.ToLower()))
                        {
                            searchCars.Add(new SingleCar()
                            {
                                ID = item.ID,
                                BRAND = item.BRAND,
                                MODEL = item.MODEL,
                                COLOR = item.COLOR,
                                WEIGHT = item.WEIGHT,
                                COST = item.COST,
                                DESCRIPTION = item.DESCRIPTION,
                                COMPANY_NAME = item.COMPANY_NAME,
                                rating = item.CARRATING,
                                imageSource = item.IMGSOURCE
                            });
                        }
                    }
                    Autos.ItemsSource = searchCars;
                }
                
            }

        }

        //public void FilterWin_Open(object sender, RoutedEventArgs e)
        //{
        //    using (Entities2 ent = new Entities2())
        //    {
        //        var AutoList = from auto in ent.CAR
        //                       join eqiupment in ent.EQUIPMENT
        //                       on auto.ID equals eqiupment.ID
        //                       join eqiupmentList in ent.EQUIPMENTLIST
        //                       on auto.ID equals eqiupmentList.ID
        //                       join supplier in ent.SUPPLIER
        //                       on auto.ID equals supplier.ID
        //                       select new
        //                       {
        //                           auto.ID,
        //                           auto.IMGSOURCE,
        //                           auto.BRAND,
        //                           auto.MODEL,
        //                           auto.COLOR,
        //                           auto.WEIGHT,
        //                           auto.COST,
        //                           eqiupmentList.DESCRIPTION,
        //                           supplier.COMPANY_NAME
        //                       };
        //        new FilterItems(AutoList2, Autos).Show();
        //    }
        //}
        
        public void SignInClick(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
        }

        private void OrderCarClick(object sender, RoutedEventArgs e)
        {
            // quantityCount++;

            quantityCount = 1;
            using (Entities2 ent = new Entities2())
            {
                var button = sender as Button;
                var selectedCar = button.DataContext as SingleCar;
                decimal maxId = 0;
                foreach (var item in ent.GETALLORDERINFO())
                {
                    if (item.ID > maxId)
                        maxId = item.ID;
                    if (selectedCar.ID == item.IDCAR && _userId == item.IDCLIENT)
                    {
                        quantityCount = item.QUANTITY + 1;
                        if (quantityCount > 5)
                        {
                            MessageBox.Show("You cant have >5 orders of the same car. Try something else.");
                            quantityCount--;
                        }
                        else
                        {
                            ent.UPDATEQUANTITY(item.ID);
                            MessageBox.Show("Your order has been updated! You've ordered " + selectedCar.BRAND + " " + selectedCar.MODEL + 
                                ", quantity: " + (item.QUANTITY + 1));
                        }
                        
                    }
                }
                //quantityStackPanel
                if (quantityCount == 1)
                {
                    ent.ADDNEWORDER(maxId + 1, _userId, selectedCar.ID,
                        quantityCount, isTestDrive);
                    MessageBox.Show("Order added successfully!");
                }
                
            }
        }

        private void DeclineOrderCarClick(object sender, RoutedEventArgs e)
        {
            quantityCount = 1;
            using (Entities2 ent = new Entities2())
            {
                var button = sender as Button;
                var selectedCar = button.DataContext as SingleCar;
                
                foreach (var item in ent.GETALLORDERINFO())
                {
                    
                    if (selectedCar.ID == item.IDCAR && _userId == item.IDCLIENT)
                    {
                        quantityCount = item.QUANTITY;
                        if (quantityCount == 1)
                        {
                            MessageBox.Show("Your order has been deleted!");
                            ent.DELETEORDER(item.ID);
                        }
                        else
                        {
                            ent.UPDATEQUANTITYDECREMENT(item.ID);
                            MessageBox.Show("Your order has been updated! You've ordered " + selectedCar.BRAND + " " + selectedCar.MODEL +
                                ", quantity: " + (item.QUANTITY - 1));
                        }

                    }
                }
                

            }
        }

        private void OrderTestDriveClick(object sender, RoutedEventArgs e)
        {
            var button = sender as Button;
            var selectedCar = button.DataContext as SingleCar;
            isTestDrive = 1;
            using (Entities2 ent = new Entities2())
            {
                foreach (var item in ent.GETALLORDERINFO())
                {
                    if (item.BRAND == selectedCar.BRAND && item.DESCRIPTION == selectedCar.DESCRIPTION && item.NAME == _userName)
                    {
                        ent.UPDATEISTESTDRIVE(item.ID);
                        MessageBox.Show("Request for Test Drive is sent!");
                    }
                }
            }
        }

        private void DeclineTestDriveClick(object sender, RoutedEventArgs e)
        {
            isTestDrive = 0;
            var button = sender as Button;
            var selectedCar = button.DataContext as SingleCar;
            using (Entities2 ent = new Entities2())
            {
                foreach (var item in ent.GETALLORDERINFO())
                {
                    if (item.BRAND == selectedCar.BRAND && item.DESCRIPTION == selectedCar.DESCRIPTION && item.NAME == _userName)
                    {
                        ent.UPDATEISTESTDRIVETOZERO(item.ID);
                        MessageBox.Show("Request for Decline a Test Drive is sent!");
                    }
                }
            }
        }

        private void RefreshClick(object sender, RoutedEventArgs e)
        {
            using (Entities2 ent = new Entities2())
            {
                cars.Clear();
                foreach (var item in ent.GETALLCARINFO())
                {
                    cars.Add(new SingleCar()
                    {
                        ID = item.ID,
                        BRAND = item.BRAND,
                        MODEL = item.MODEL,
                        COLOR = item.COLOR,
                        WEIGHT = item.WEIGHT,
                        COST = item.COST,
                        DESCRIPTION = item.DESCRIPTION,
                        COMPANY_NAME = item.COMPANY_NAME,
                        rating = item.CARRATING,
                        imageSource = item.IMGSOURCE
                    });
                }
                Autos.ItemsSource = cars;
            }
        }
    }
}
