using System;
using System.Collections.Generic;
using System.ComponentModel;
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
    /// Логика взаимодействия для FilterItems.xaml
    /// </summary>
    public partial class FilterItems : Window
    {
        IEnumerable<SingleCar> FilteredAutoList;
        ListBox FilteredAuto = new ListBox();
        int fromCost = 0, toCost = 0;
        string chosenBodytype;


        public FilterItems(IEnumerable<SingleCar> FilteredAutoList2, ListBox Autos)
        {
            InitializeComponent();

            FilteredAutoList = FilteredAutoList2;
            FilteredAuto = Autos;
        }

        public void FilterList(object sender, RoutedEventArgs e)
        {
            if ((bool)radiobtnCost.IsChecked)
            {
                if (costFrom.Text != "" && costTo.Text != "")
                {
                    int i;
                    if (int.TryParse(costFrom.Text, out i) && int.TryParse(costTo.Text, out i))
                    {
                        fromCost = Convert.ToInt32(costFrom.Text);
                        toCost = Convert.ToInt32(costTo.Text);

                        //FilteredAutoList = (BindingList<Auto>)FilteredAutoList.Where(p => p.Cost >= fromCost && p.Cost <= toCost);
                        var SortedList = from auto in FilteredAutoList
                                         where auto.COST >= fromCost && auto.COST <= toCost
                                         select auto;

                        FilteredAuto.ItemsSource = SortedList;
                    }
                    else
                    {
                        costFrom.Text = "";
                        costTo.Text = "";
                        MessageBox.Show("Plaese enter a valid Cost Interval");
                    }
                }
                else
                {
                    costFrom.Text = "";
                    costTo.Text = "";

                    MessageBox.Show("Enter from and to Cost interval");
                }
            }

            if ((bool)radiobtnBodytype.IsChecked)
            {
                if ((bool)bodytype1.IsChecked)
                    chosenBodytype = "Yellow";
                if ((bool)bodytype2.IsChecked)
                    chosenBodytype = "Green";
                if ((bool)bodytype3.IsChecked)
                    chosenBodytype = "Blue";

                var SortedList2 = from auto in FilteredAutoList
                                  where auto.COLOR == chosenBodytype
                                  select auto;

                FilteredAuto.ItemsSource = SortedList2;

            }

            if ((bool)radiobtnRating.IsChecked)
            {
                if ((bool)rating1.IsChecked)
                {
                    var SortedList3 = from auto in FilteredAutoList
                                      where auto.WEIGHT < 1500
                                      select auto;
                    FilteredAuto.ItemsSource = SortedList3;
                }
                if ((bool)rating2.IsChecked)
                {
                    var SortedList3 = from auto in FilteredAutoList
                                      where auto.WEIGHT > 1500
                                      select auto;
                    FilteredAuto.ItemsSource = SortedList3;
                }      
            }
        }

        public void ResetFilterList(object sender, RoutedEventArgs e)
        {
            FilteredAuto.ItemsSource = FilteredAutoList;
        }
    }
}
