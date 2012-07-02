using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using ImdbClientInterface;

namespace ImdbClientAppMVVM.ViewModel
{
    public class MainViewModel : ViewModel
    {
        private FilmViewModel _selectedFilm;
        private static IEnumerable<FilmViewModel> FilmViewModels { get; set; } 

        public MainViewModel(double rating)
        {
            if(FilmViewModels == null)
            {
                var filmsJson = ImdbWebClient.GetFilms();
                FilmViewModels = FilmsParser.Parse(filmsJson).Select(x => new FilmViewModel(x));
            }
            Films = new ObservableCollection<FilmViewModel>(FilmViewModels.Where(x => x.Rating >= rating));
        }

        public ObservableCollection<FilmViewModel> Films { get; set; }
        public FilmViewModel SelectedFilm { get { return _selectedFilm; } set { _selectedFilm = value; OnPropertyChanged("SelectedFilm"); } }
    }
}
