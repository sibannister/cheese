using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace ImdbClientApp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, RoutedEventArgs e)
        {
            string message = string.Format("Film title: {0} cannot be found", filmTitleTxtBox.Text);
            double filmRating = ImdbClientInterface.ImdbWebClient.GetFilmRating(filmTitleTxtBox.Text);
            if(!double.IsNaN(filmRating))
            {
                message = filmRating.ToString(CultureInfo.InvariantCulture);
            }
            MessageBox.Show(message);
        }
    }
}
