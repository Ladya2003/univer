using System;
using System.Collections.Generic;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace DB_Kursovoi_2023
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public List list = new List();
        public MainWindow()
        {
            InitializeComponent();            
        }

        private void SignInClick(object sender, RoutedEventArgs ee)
        {
            if (loginInput.Text == null || passwordInput.Text.Length == 0)
                MessageBox.Show("Введите ваш логин и пароль!");
            else
            {
                using (Entities2 ent = new Entities2())
                {
                    var adminPassword = "1";
                    foreach (var item in ent.GETCLIENTS())
                    {
                        if (item.LOGIN == "admin")
                        {
                            adminPassword = item.PASSWORD;
                        }
                    }
                    if (loginInput.Text.ToLower() == "admin" && passwordInput.Text.ToLower() == adminPassword)
                    {
                        CatalogAdmin admin = new CatalogAdmin();
                        admin.Show();
                        Close();
                    }
                    else
                    {
                        bool Ishere = false;
                        foreach (var item2 in ent.GETCLIENTS())
                        {
                            if (loginInput.Text.ToLower() == item2.LOGIN && passwordInput.Text.ToLower() == item2.PASSWORD)
                            {
                                CatalogUser user = new CatalogUser(item2.ID, item2.NAME, item2.SURNAME);
                                user.Show();
                                Close();
                                Ishere = true;
                            }
                        }
                        if (!Ishere)
                            MessageBox.Show("Такой учетной записи нет. Зарегистрируйтесь или введите корректные данные!");
                    }
                }
            }
            
        }

        private void SignUpClick(object sender, RoutedEventArgs ee)
        {
            Signup signup = new Signup();
            signup.Show();
            Close();
        }

    }
}
