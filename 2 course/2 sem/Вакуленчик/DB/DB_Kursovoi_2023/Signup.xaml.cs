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
using System.Windows.Shapes;

namespace DB_Kursovoi_2023
{
    /// <summary>
    /// Логика взаимодействия для Signup.xaml
    /// </summary>
    public partial class Signup : Window
    {
        public Signup()
        {
            InitializeComponent();
        }

        private void SignInClick(object sender, RoutedEventArgs ee)
        {
            if (loginInput.Text == "" || passwordInput.Text.Length == 0 || emailInput.Text == "" || nameInput.Text == "" || surnameInput.Text == ""
                || ageInput.Text.Length == 0)
                MessageBox.Show("Type data in every input!");
            else
            {
                decimal val;
                bool IsHere = false;
                if (decimal.TryParse(ageInput.Text, out val))
                {
                    if (Convert.ToDecimal(ageInput.Text) > 18 && Convert.ToDecimal(ageInput.Text) < 100)
                    {
                        using (Entities2 ent = new Entities2())
                        {
                            foreach (var item in ent.GETCLIENTS())
                            {
                                if (item.LOGIN == loginInput.Text || (item.NAME == nameInput.Text && item.SURNAME == surnameInput.Text))
                                    IsHere = true;
                            }
                            if (!IsHere)
                            {
                                ent.INSERTUSER(loginInput.Text, passwordInput.Text, nameInput.Text, surnameInput.Text,
                                    Convert.ToDecimal(ageInput.Text), emailInput.Text);
                                MessageBox.Show("CLient has been successfully added!");
                            }
                            else
                                MessageBox.Show("This Client is already signed in or this login is taken");

                        }

                    }
                    else
                        MessageBox.Show("Client can only have 17 < age < 101");
                }
                else
                    MessageBox.Show("Please, type decimal type of Age");

            

            }
        }
        
        private void GoBackFunc(object sender, RoutedEventArgs e)
        {
            MainWindow window = new MainWindow();
            window.Show();
            Close();
        }
    }
}
