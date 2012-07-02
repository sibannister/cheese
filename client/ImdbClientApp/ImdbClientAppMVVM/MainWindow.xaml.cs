using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
using ImdbClientAppMVVM.ViewModel;

namespace ImdbClientAppMVVM
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            DataContext = new MainViewModel(0.0);
            InitializeComponent();
        }
        // OnClosing - Dispose.
        private void RatingFilterApplied(object sender, TextChangedEventArgs e)
        {
            var ratingTxtBox = sender as TextBox;
            string rating = ratingTxtBox.Text;
            double ratingFilter = 0;
            double.TryParse(rating, out ratingFilter);
            DataContext = new MainViewModel(ratingFilter);
        }
    }
}
