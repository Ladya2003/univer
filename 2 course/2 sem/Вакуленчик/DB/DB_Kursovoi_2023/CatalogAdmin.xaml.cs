using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using Oracle.ManagedDataAccess.Client;

namespace DB_Kursovoi_2023
{
    /// <summary>
    /// Логика взаимодействия для CatalogUser.xaml
    /// </summary>
    public partial class CatalogAdmin : Window
    {
        private BindingList<SingleOrder> orders = new BindingList<SingleOrder>();
        private BindingList<SingleClient> clients = new BindingList<SingleClient>();
        private BindingList<SingleCar> cars = new BindingList<SingleCar>();
        private BindingList<SingleSupplier> suppliers = new BindingList<SingleSupplier>();
        public CatalogAdmin()
        {
            InitializeComponent();

            LoadOrders();
            LoadClient();
            LoadCar();
            LoadSupplier();            
        }

        private void AddItemClick(object sender, RoutedEventArgs e)
        {
            string selectedTabHeader = (allTabCtrl.SelectedItem as TabItem)?.Header.ToString();

            if (selectedTabHeader == "ORDER")
            {
                AddItem newWindow = new AddItem("ORDER", null);
                newWindow.ShowDialog();

                LoadOrders();
            }
            else if (selectedTabHeader == "CLIENT")
            {
                AddItem newWindow = new AddItem("CLIENT", null);
                newWindow.ShowDialog();

                LoadClient();
            }
            else if (selectedTabHeader == "CAR")
            {
                AddItem newWindow = new AddItem("CAR", null);
                newWindow.ShowDialog();

                LoadCar();
            }
            else if (selectedTabHeader == "SUPPLIER")
            {
                MessageBox.Show("Unfortunaly, this are all suppliers that work with us, so you cant ADD/DELETE/EDIT them");
            }
        }

        private void DelereItemClick(object sender, RoutedEventArgs e)
        {
            string selectedTabHeader = (allTabCtrl.SelectedItem as TabItem)?.Header.ToString();

            if (selectedTabHeader == "ORDER")
            {
                var selectedRow = tableOrder.SelectedItem as SingleOrder;

                if (selectedRow == null)
                    MessageBox.Show("Please, choose any row to delete it");
                else
                {
                    orders.Remove(selectedRow);
                    using (Entities2 ent = new Entities2())
                    {
                        ent.DELETEORDER(selectedRow.id);
                    }
                }
            }
            else if (selectedTabHeader == "CLIENT")
            {
                var selectedRow = tableClient.SelectedItem as SingleClient;

                if (selectedRow == null)
                    MessageBox.Show("Please, choose any row to delete it");
                else
                {
                    clients.Remove(selectedRow);
                    using (Entities2 ent = new Entities2())
                    {
                        ent.DELETECLIENT(selectedRow.id);
                    }
                }
            }
            else if (selectedTabHeader == "CAR")
            {
                var selectedRow = tableCar.SelectedItem as SingleCar;

                if (selectedRow == null)
                    MessageBox.Show("Please, choose any row to delete it");
                else
                {
                    cars.Remove(selectedRow);
                    using (Entities2 ent = new Entities2())
                    {
                        ent.DELETECAR(selectedRow.ID);
                    }
                }
            }
            else if (allTabCtrl.SelectedItem.ToString() == "SUPPLIER")
            {
                MessageBox.Show("Unfortunaly, this are all suppliers that work with us, so you cant ADD/DELETE/EDIT them");
            }
        }

        private void EditItemClick(object sender, RoutedEventArgs e)
        {
            string selectedTabHeader = (allTabCtrl.SelectedItem as TabItem)?.Header.ToString();

            if (selectedTabHeader == "ORDER")
            {
                var selectedRow = tableOrder.SelectedItem;
                //var selectedRow = tableOrder.SelectedItem as SingleOrder;

                if (selectedRow == null)
                    MessageBox.Show("Please, choose any row to edit");
                else
                {
                    AddItem newWindow = new AddItem("ORDER", selectedRow);
                    newWindow.ShowDialog();

                    LoadOrders();
                }
            }
            else if (selectedTabHeader == "CLIENT")
            {
                var selectedRow = tableClient.SelectedItem;
                //var selectedRow = tableOrder.SelectedItem as SingleOrder;

                if (selectedRow == null)
                    MessageBox.Show("Please, choose any row to edit");
                else
                {
                    AddItem newWindow = new AddItem("CLIENT", selectedRow);
                    newWindow.ShowDialog();

                    LoadClient();
                }
            }
            else if (selectedTabHeader == "CAR")
            {
                var selectedRow = tableCar.SelectedItem;
                //var selectedRow = tableOrder.SelectedItem as SingleOrder;

                if (selectedRow == null)
                    MessageBox.Show("Please, choose any row to edit");
                else
                {
                    AddItem newWindow = new AddItem("CAR", selectedRow);
                    newWindow.ShowDialog();

                    LoadCar();
                }
            }
            else if (allTabCtrl.SelectedItem.ToString() == "SUPPLIER")
            {
                MessageBox.Show("Unfortunaly, this are all suppliers that work with us, so you cant ADD/DELETE/EDIT them");
            }
        }


        private void LoadOrders()
        {
            using (Entities2 ent = new Entities2())
            {
                orders.Clear();
                foreach (var item in ent.GETALLORDERINFO())
                {
                    orders.Add(new SingleOrder()
                    {
                        id = item.ID,
                        brand = item.BRAND,
                        model = item.MODEL,
                        weight = item.WEIGHT,
                        cost = item.COST,
                        value = item.DESCRIPTION,
                        name = item.NAME,
                        surname = item.SURNAME,
                        quantity = item.QUANTITY,
                        IsTestDrive = item.ISTESTDRIVE
                    });
                }
                tableOrder.ItemsSource = orders;
            }
        }

        private void LoadClient()
        {
            using (Entities2 ent = new Entities2())
            {
                clients.Clear();
                foreach (var item in ent.GETCLIENTS())
                {
                    clients.Add(new SingleClient()
                    {
                        id = item.ID,
                        name = item.NAME,
                        surname = item.SURNAME,
                        age = item.AGE,
                        email = item.EMAIL,
                        login = item.LOGIN,
                        password = item.PASSWORD
                    });
                }
                tableClient.ItemsSource = clients;
            }
        }

        private void LoadCar()
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
                tableCar.ItemsSource = cars;
            }
        }

        private void LoadSupplier()
        {
            using (Entities2 ent = new Entities2())
            {
                suppliers.Clear();
                foreach (var item in ent.GETALLSUPPLIERINFO())
                {
                    suppliers.Add(new SingleSupplier()
                    {
                        id = item.ID,
                        company_name = item.COMPANY_NAME,
                        email = item.EMAIL
                    });
                }
                tableSupplier.ItemsSource = suppliers;
            }
        }

        private void SigninClick(object sender, RoutedEventArgs e)
        {
            MainWindow wind = new MainWindow();
            wind.Show();
        }

        private void RefreshClick(object sender, RoutedEventArgs e)
        {
            LoadOrders();
            LoadClient();
            LoadCar();
            LoadSupplier();
        }

    }
}
