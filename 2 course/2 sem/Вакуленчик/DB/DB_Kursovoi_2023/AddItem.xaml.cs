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
    /// Логика взаимодействия для AddItem.xaml
    /// </summary>
    public partial class AddItem : Window
    {
        string _addType;
        SingleOrder _order;
        SingleClient _client;
        SingleCar _car;
        SingleSupplier _supplier;
        decimal idCar;

        // for orders
        List<string> valuesCar = new List<string>();
        List<string> valuesClient = new List<string>();
        List<int> valuesQuantity = new List<int>() { 1, 2, 3, 4, 5};
        List<int> valuesIsTestDrive = new List<int>() { 0, 1 };

        // for orders
        ComboBox comboBox = new ComboBox();
        ComboBox comboBoxClient = new ComboBox();
        ComboBox comboBoxQuantity = new ComboBox();
        ComboBox comboBoxIsTestDrive = new ComboBox();

        // for clients
        TextBox nameTxtBx = new TextBox();
        TextBox surnameTxtBx = new TextBox();
        TextBox ageTxtBx = new TextBox();
        TextBox emailTxtBx = new TextBox();
        TextBox loginTxtBx = new TextBox();
        TextBox passwordTxtBx = new TextBox();

        List<string> valuesClientName = new List<string>();
        List<string> valuesClientSurname = new List<string>();

        // for cars
        TextBox brandTxtBx = new TextBox();
        TextBox modelTxtBx = new TextBox();
        TextBox colorTxtBx = new TextBox();
        TextBox weightTxtBx = new TextBox();
        TextBox costTxtBx = new TextBox();
        TextBox imgSourceTxtBx = new TextBox();

        ComboBox ratingcomboBox = new ComboBox();
        ComboBox descriptioncomboBox = new ComboBox();
        ComboBox companyNamecomboBox = new ComboBox();
        List<int> valuesRating = new List<int>();
        List<string> valuesDescription = new List<string>();
        List<string> valuesCompanyName = new List<string>();

        public AddItem(string addingType, object singleorder)
        {
            InitializeComponent();
            _addType = addingType;
            

            if (_addType == "ORDER")
            {
                _order = singleorder as SingleOrder;
                using (Entities2 ent = new Entities2())
                {
                    foreach (var item in ent.GETALLCARINFO())
                    {
                        valuesCar.Add(item.MODEL + ", " + item.DESCRIPTION); 
                    }

                    foreach (var item in ent.GETCLIENTS())
                    {
                        valuesClient.Add(item.NAME + ", " + item.SURNAME);
                    }

                    
                    HeaderTxtBck.Text = "Add new";
                    if (_order != null)
                        HeaderTxtBck.Text = "Update";

                    TextBlock CarTextBlock = new TextBlock();
                    CarTextBlock.Text = "Car";
                    if (_order != null)
                    {
                        CarTextBlock.Text = "Car: " + _order.brand + ", " + _order.value;
                    }
                    CarTextBlock.Margin = new Thickness(0, 15, 0, 0);
                    CarTextBlock.FontSize = 14;

                    TextBlock ClientTextBlock = new TextBlock();
                    ClientTextBlock.Text = "Client";
                    if (_order != null)
                    {
                        ClientTextBlock.Text = "Client: " + _order.name + " " + _order.surname;
                    }
                    ClientTextBlock.Margin = new Thickness(0, 10, 0, 0);
                    CarTextBlock.FontSize = 14;

                    TextBlock QuantityTextBlock = new TextBlock();
                    QuantityTextBlock.Text = "Quantity";
                    if (_order != null)
                    {
                        QuantityTextBlock.Text = "Quantity: " + _order.quantity;
                    }
                    QuantityTextBlock.Margin = new Thickness(0, 10, 0, 0);
                    CarTextBlock.FontSize = 14;

                    TextBlock IsTestDriveTextBlock = new TextBlock();
                    IsTestDriveTextBlock.Text = "Is it ordered for test drive?";
                    if (_order != null)
                    {
                        IsTestDriveTextBlock.Text = "Is it ordered for test drive?: " + _order.IsTestDrive;
                    }
                    IsTestDriveTextBlock.Margin = new Thickness(0, 10, 0, 0);
                    CarTextBlock.FontSize = 14;

                    
                    comboBox.ItemsSource = valuesCar;
                    comboBox.SelectedIndex = 0;

                    comboBoxClient.ItemsSource = valuesClient;
                    comboBoxClient.SelectedIndex = 0;

                    comboBoxQuantity.ItemsSource = valuesQuantity;
                    comboBoxQuantity.SelectedIndex = 0;

                    comboBoxIsTestDrive.ItemsSource = valuesIsTestDrive;
                    comboBoxIsTestDrive.SelectedIndex = 0;

                    Button button = new Button();
                    button.Content = "Add new Order";
                    if (_order != null)
                    {
                        button.Content = "Update Order";
                    }
                    button.FontSize = 12;
                    button.Margin = new Thickness(0, 15, 0, 0);
                    if (_order == null)
                        button.Click += AddItemClick;
                    else if (_order != null)
                    {
                        button.Click += UpdateItemClick;
                    }
                    else
                        button.Click += ErrorItemCLick;


                    mainStackPanel.Children.Add(CarTextBlock);
                    mainStackPanel.Children.Add(comboBox);

                    mainStackPanel.Children.Add(ClientTextBlock);
                    mainStackPanel.Children.Add(comboBoxClient);

                    mainStackPanel.Children.Add(QuantityTextBlock);
                    mainStackPanel.Children.Add(comboBoxQuantity);

                    mainStackPanel.Children.Add(IsTestDriveTextBlock);
                    mainStackPanel.Children.Add(comboBoxIsTestDrive);

                    mainStackPanel.Children.Add(button);
                }
                
            }

            if (_addType == "CLIENT")
            {
                this.Height = 390;
                _client = singleorder as SingleClient;
                using (Entities2 ent = new Entities2())
                {
                    foreach (var item in ent.GETCLIENTS())
                    {
                        valuesClientName.Add(item.NAME);
                    }
                    foreach (var item in ent.GETCLIENTS())
                    {
                        valuesClientSurname.Add(item.SURNAME);
                    }


                    HeaderTxtBck.Text = "Add new";
                    if (_client != null)
                        HeaderTxtBck.Text = "Update";

                    TextBlock CarTextBlock = new TextBlock();
                    CarTextBlock.Text = "Name";
                    if (_client != null)
                    {
                        CarTextBlock.Text = "Name: " + _client.name;
                        nameTxtBx.Text = _client.name;
                    }
                    CarTextBlock.Margin = new Thickness(0, 15, 0, 0);
                    CarTextBlock.FontSize = 14;

                    TextBlock ClientTextBlock = new TextBlock();
                    ClientTextBlock.Text = "Surname";
                    if (_client != null)
                    {
                        ClientTextBlock.Text = "Surname: " + _client.surname;
                        surnameTxtBx.Text = _client.surname;
                    }
                    ClientTextBlock.Margin = new Thickness(0, 10, 0, 0);
                    CarTextBlock.FontSize = 14;

                    TextBlock QuantityTextBlock = new TextBlock();
                    QuantityTextBlock.Text = "Age";
                    if (_client != null)
                    {
                        QuantityTextBlock.Text = "Age: " + _client.age;
                        ageTxtBx.Text = _client.age.ToString();
                    }
                    QuantityTextBlock.Margin = new Thickness(0, 10, 0, 0);
                    CarTextBlock.FontSize = 14;

                    TextBlock IsTestDriveTextBlock = new TextBlock();
                    IsTestDriveTextBlock.Text = "Email";
                    if (_client != null)
                    {
                        IsTestDriveTextBlock.Text = "Email: " + _client.email;
                        emailTxtBx.Text = _client.email;
                    }
                    IsTestDriveTextBlock.Margin = new Thickness(0, 10, 0, 0);
                    CarTextBlock.FontSize = 14;

                    TextBlock loginTxtBck = new TextBlock();
                    loginTxtBck.Text = "Login";
                    if (_client != null)
                    {
                        loginTxtBck.Text = "Login: " + _client.login;
                        loginTxtBx.Text = _client.login;
                    }
                    loginTxtBck.Margin = new Thickness(0, 10, 0, 0);
                    loginTxtBck.FontSize = 14;

                    TextBlock passwordTxtBck = new TextBlock();
                    passwordTxtBck.Text = "Password";
                    if (_client != null)
                    {
                        passwordTxtBck.Text = "Password: " + _client.password;
                        passwordTxtBx.Text = _client.password;
                    }
                    passwordTxtBck.Margin = new Thickness(0, 10, 0, 0);
                    passwordTxtBck.FontSize = 14;

                    Button button = new Button();
                    button.Content = "Add new Client";
                    if (_client != null)
                    {
                        button.Content = "Update Client";
                    }
                    button.FontSize = 12;
                    button.Margin = new Thickness(0, 15, 0, 0);
                    if (_client == null)
                        button.Click += AddItemClick;
                    else if (_client != null)
                    {
                        button.Click += UpdateItemClick;
                    }
                    else
                        button.Click += ErrorItemCLick;


                    mainStackPanel.Children.Add(CarTextBlock);
                    mainStackPanel.Children.Add(nameTxtBx);

                    mainStackPanel.Children.Add(ClientTextBlock);
                    mainStackPanel.Children.Add(surnameTxtBx);

                    mainStackPanel.Children.Add(QuantityTextBlock);
                    mainStackPanel.Children.Add(ageTxtBx);

                    mainStackPanel.Children.Add(IsTestDriveTextBlock);
                    mainStackPanel.Children.Add(emailTxtBx);

                    mainStackPanel.Children.Add(loginTxtBck);
                    mainStackPanel.Children.Add(loginTxtBx);

                    mainStackPanel.Children.Add(passwordTxtBck);
                    mainStackPanel.Children.Add(passwordTxtBx);

                    mainStackPanel.Children.Add(button);
                }

            }

            if (_addType == "CAR")
            {
                this.Height = 540;
                _car = singleorder as SingleCar;
                using (Entities2 ent = new Entities2())
                {
                    foreach (var item in ent.GETALLCARINFO())
                    {
                        //if (!valuesDescription.Contains(item.DESCRIPTION))
                            //valuesDescription.Add(item.DESCRIPTION);
                    }
                    valuesDescription.Add("Seats");
                    valuesDescription.Add("Roof");
                    valuesDescription.Add("Camera");
                    valuesDescription.Add("Radio");
                    foreach (var item in ent.GETALLSUPPLIERINFO())
                    {
                        valuesCompanyName.Add(item.COMPANY_NAME);
                    }
                    valuesRating.Add(1);
                    valuesRating.Add(2);
                    valuesRating.Add(3);
                    valuesRating.Add(4);
                    valuesRating.Add(5);


                    HeaderTxtBck.Text = "Add new Car";
                    if (_car != null)
                        HeaderTxtBck.Text = "Update";

                    TextBlock CarTextBlock = new TextBlock();
                    CarTextBlock.Text = "Brand";
                    if (_car != null)
                    {
                        CarTextBlock.Text = "Brand: " + _car.BRAND;
                        brandTxtBx.Text = _car.BRAND;
                    }
                    CarTextBlock.Margin = new Thickness(0, 15, 0, 0);
                    CarTextBlock.FontSize = 14;

                    TextBlock ClientTextBlock = new TextBlock();
                    ClientTextBlock.Text = "Model";
                    if (_car != null)
                    {
                        ClientTextBlock.Text = "Model: " + _car.MODEL;
                        modelTxtBx.Text = _car.MODEL;
                    }
                    ClientTextBlock.Margin = new Thickness(0, 10, 0, 0);
                    ClientTextBlock.FontSize = 14;

                    TextBlock QuantityTextBlock = new TextBlock();
                    QuantityTextBlock.Text = "Color";
                    if (_car != null)
                    {
                        QuantityTextBlock.Text = "Color: " + _car.COLOR;
                        colorTxtBx.Text = _car.COLOR;
                    }
                    QuantityTextBlock.Margin = new Thickness(0, 10, 0, 0);
                    CarTextBlock.FontSize = 14;

                    TextBlock IsTestDriveTextBlock = new TextBlock();
                    IsTestDriveTextBlock.Text = "Weight";
                    if (_car != null)
                    {
                        IsTestDriveTextBlock.Text = "Weight: " + _car.WEIGHT;
                        weightTxtBx.Text = _car.WEIGHT.ToString();
                    }
                    IsTestDriveTextBlock.Margin = new Thickness(0, 10, 0, 0);
                    CarTextBlock.FontSize = 14;

                    TextBlock loginTxtBck = new TextBlock();
                    loginTxtBck.Text = "Cost";
                    if (_car != null)
                    {
                        loginTxtBck.Text = "Cost: " + _car.COST;
                        costTxtBx.Text = _car.COST.ToString();
                    }
                    loginTxtBck.Margin = new Thickness(0, 10, 0, 0);
                    loginTxtBck.FontSize = 14;

                    TextBlock ratingTxtBck = new TextBlock();
                    ratingTxtBck.Text = "Rating";
                    if (_car != null)
                    {
                        ratingTxtBck.Text = "Rating: " + _car.rating;
                    }

                    // добавить лейблы для рейтинга компаний и дискрипт
                    ratingTxtBck.Margin = new Thickness(0, 10, 0, 0);
                    ratingTxtBck.FontSize = 14;

                    TextBlock description123 = new TextBlock();
                    description123.Text = "Equipment";
                    if (_car != null)
                    {
                        description123.Text = "Equipment: " + _car.DESCRIPTION;
                    }
                    description123.Margin = new Thickness(0, 10, 0, 0);
                    description123.FontSize = 14;

                    TextBlock supplier123 = new TextBlock();
                    supplier123.Text = "Supplier";
                    if (_car != null)
                    {
                        supplier123.Text = "Supplier: " + _car.COMPANY_NAME;
                    }
                    supplier123.Margin = new Thickness(0, 10, 0, 0);
                    supplier123.FontSize = 14;

                    TextBlock imgsourceTxtBck = new TextBlock();
                    imgsourceTxtBck.Text = "Image Source";
                    if (_car != null)
                    {
                        imgsourceTxtBck.Text = "Image Source: " + _car.imageSource;
                        imgSourceTxtBx.Text = _car.imageSource;
                    }
                    imgsourceTxtBck.Margin = new Thickness(0, 10, 0, 0);
                    imgsourceTxtBck.FontSize = 14;


                    ratingcomboBox.ItemsSource = valuesRating;
                    ratingcomboBox.SelectedIndex = 2;
                    descriptioncomboBox.ItemsSource = valuesDescription;
                    descriptioncomboBox.SelectedIndex = 0;
                    companyNamecomboBox.ItemsSource = valuesCompanyName;
                    companyNamecomboBox.SelectedIndex = 0;


                    Button button = new Button();
                    button.Content = "Add new Car";
                    if (_car != null)
                    {
                        button.Content = "Update Car";
                    }
                    button.FontSize = 12;
                    button.Margin = new Thickness(0, 15, 0, 0);
                    if (_car == null)
                        button.Click += AddItemClick;
                    else if (_car != null)
                    {
                        button.Click += UpdateItemClick;
                    }
                    else
                        button.Click += ErrorItemCLick;


                    mainStackPanel.Children.Add(CarTextBlock);
                    mainStackPanel.Children.Add(brandTxtBx);

                    mainStackPanel.Children.Add(ClientTextBlock);
                    mainStackPanel.Children.Add(modelTxtBx);

                    mainStackPanel.Children.Add(QuantityTextBlock);
                    mainStackPanel.Children.Add(colorTxtBx);

                    mainStackPanel.Children.Add(IsTestDriveTextBlock);
                    mainStackPanel.Children.Add(weightTxtBx);

                    mainStackPanel.Children.Add(loginTxtBck);
                    mainStackPanel.Children.Add(costTxtBx);

                    if (_car == null)
                    {
                        mainStackPanel.Children.Add(imgsourceTxtBck);
                        mainStackPanel.Children.Add(imgSourceTxtBx);
                    }
                        

                    mainStackPanel.Children.Add(ratingTxtBck);
                    mainStackPanel.Children.Add(ratingcomboBox);

                    mainStackPanel.Children.Add(description123);
                    mainStackPanel.Children.Add(descriptioncomboBox);

                    mainStackPanel.Children.Add(supplier123);
                    mainStackPanel.Children.Add(companyNamecomboBox);

                    mainStackPanel.Children.Add(button);
                }

            }

        }


        private void AddItemClick(object sender, RoutedEventArgs e)
        {
            using (Entities2 entities1 = new Entities2())
            {
                if (_addType == "ORDER")
                {
                    decimal maxId = 0;
                    foreach (var item in entities1.GETALLORDERINFO())
                    {
                        if (item.ID > maxId)
                            maxId = item.ID;
                    }

                    bool isHere = false;
                    foreach (var item in entities1.GETALLCARINFO())
                    {
                        if (comboBox.SelectedItem.ToString() == item.MODEL + ", " + item.DESCRIPTION)
                        {
                            idCar = item.ID;
                            isHere = true;
                        }
                    }
                    if (!isHere)
                        idCar = 0;

                    decimal inserted_id = maxId + 1;
                    decimal idClient = comboBoxClient.SelectedIndex + 1;
                    //decimal idCar = comboBox.SelectedIndex + 1;
                    decimal quantity = comboBoxQuantity.SelectedIndex + 1;
                    decimal istestdrive = comboBoxIsTestDrive.SelectedIndex;
                    entities1.ADDNEWORDER(inserted_id, idClient, idCar,
                        quantity, istestdrive);
                    MessageBox.Show("Order added successfully!");
                }

                if (_addType == "CLIENT")
                {
                    decimal maxId = 0;
                    bool IsHere = false;
                    foreach (var item in entities1.GETCLIENTS())
                    {
                        if (item.ID > maxId)
                            maxId = item.ID;
                    }
                    if (loginTxtBx.Text != "" && passwordTxtBx.Text != "" && nameTxtBx.Text != "" && surnameTxtBx.Text != "" && emailTxtBx.Text != "")
                    {
                        decimal val;
                        if (decimal.TryParse(ageTxtBx.Text, out val))
                        {
                            if (Convert.ToDecimal(ageTxtBx.Text) > 18 && Convert.ToDecimal(ageTxtBx.Text) < 100)
                            {
                                foreach (var item in entities1.GETCLIENTS())
                                {
                                    if (item.LOGIN == loginTxtBx.Text || (item.NAME == nameTxtBx.Text && item.SURNAME == surnameTxtBx.Text))
                                        IsHere = true;
                                }
                                if (!IsHere)
                                {
                                    entities1.INSERTUSER(loginTxtBx.Text, passwordTxtBx.Text, nameTxtBx.Text, surnameTxtBx.Text,
                                    Convert.ToDecimal(ageTxtBx.Text), emailTxtBx.Text);
                                    MessageBox.Show("CLient has been successfully added!");
                                }
                                else
                                    MessageBox.Show("This Client is already signed in or this login is taken");
                                
                            }
                            else
                                MessageBox.Show("Client can only have 17 < age < 101");
                        }
                        else
                            MessageBox.Show("Please, type decimal type of Age");
                        
                    }
                    else
                        MessageBox.Show("Please, dont leave null rows!");

                   
                }

                if (_addType == "CAR")
                {
                    
                    using (Entities2 ent = new Entities2())
                    {
                        bool isHere = false;
                        if (brandTxtBx.Text != "" && modelTxtBx.Text != "" && colorTxtBx.Text != "" && Convert.ToDecimal(weightTxtBx.Text) > 0 &&
                            Convert.ToDecimal(costTxtBx.Text) > 0 && imgSourceTxtBx.Text != "")
                        {
                            if (imgSourceTxtBx.Text.Contains("/Assets/auto"))
                            {
                                foreach (var item in entities1.GETALLCARINFO())
                                {
                                    if (brandTxtBx.Text == item.BRAND && modelTxtBx.Text == item.MODEL && descriptioncomboBox.Text == item.DESCRIPTION
                                        && companyNamecomboBox.Text == item.COMPANY_NAME)
                                    {
                                        isHere = true;
                                    }
                                }
                                if (isHere)
                                    MessageBox.Show("This car already exists! Try a new one! (with unique BRAND, MODEL, DESCR. and COMP_NAME)");
                                else
                                {
                                    decimal maxId = 0;
                                    foreach (var item in entities1.GETALLCARINFO())
                                    {
                                        if (item.ID > maxId)
                                            maxId = item.ID;
                                    }
                                    ent.INSERTCAR(brandTxtBx.Text, modelTxtBx.Text, colorTxtBx.Text, Convert.ToDecimal(weightTxtBx.Text), Convert.ToDecimal(costTxtBx.Text),
                                        imgSourceTxtBx.Text, companyNamecomboBox.SelectedIndex + 1,
                                        Convert.ToDecimal(ratingcomboBox.SelectedItem.ToString()));
                                    ent.INSERTEQUIPMENT(descriptioncomboBox.SelectedIndex + 1, maxId + 1);
                                    MessageBox.Show("Car has been added successfully!");
                                }
                            }
                            else
                                MessageBox.Show("Please type Image Source like /Assets/autox.jpg, where x is 1..7..");
                        }
                        else
                            MessageBox.Show("You cant leave null rows! Please, enter all of 'em");
                        
                        
                    }

                }
            }
        }

        private void UpdateItemClick(object sender, RoutedEventArgs e)
        {
            using (Entities2 entities1 = new Entities2())
            {
                if (_addType == "ORDER")
                {
                    bool isHere = false;
                    foreach (var item in entities1.GETALLCARINFO())
                    {
                        if (comboBox.SelectedItem.ToString() == item.MODEL + ", " + item.DESCRIPTION)
                        {
                            idCar = item.ID;
                            isHere = true;
                        }
                    }
                    if (!isHere)
                        idCar = 0;
                    decimal inserted_id = _order.id;
                    decimal idClient = comboBoxClient.SelectedIndex + 1;
                    decimal quantity = comboBoxQuantity.SelectedIndex + 1;
                    decimal istestdrive = comboBoxIsTestDrive.SelectedIndex;

                    entities1.UPDATEORDER(inserted_id, idClient, idCar,
                        quantity, istestdrive);
                    MessageBox.Show("Order updated successfully!");
                }
                if (_addType == "CLIENT")
                {
                    entities1.UPDATECLIENT(_client.id, loginTxtBx.Text, passwordTxtBx.Text,
                        nameTxtBx.Text, surnameTxtBx.Text, Convert.ToDecimal(ageTxtBx.Text), emailTxtBx.Text);
                    MessageBox.Show("Client updated successfully!");
                }
                if (_addType == "CAR")
                {
                    entities1.UPDATECAR(_car.ID, brandTxtBx.Text, modelTxtBx.Text, colorTxtBx.Text, Convert.ToDecimal(weightTxtBx.Text), Convert.ToDecimal(costTxtBx.Text),
                        descriptioncomboBox.SelectedIndex + 1,
                        companyNamecomboBox.SelectedIndex + 1,
                        Convert.ToDecimal(ratingcomboBox.SelectedItem.ToString()));
                    MessageBox.Show("Car has been updated!");
                }
            }

        }


        private void ErrorItemCLick(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Something went wrong:/ Try reloading the app!");
        }



    }
}
