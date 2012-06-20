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

        public MainViewModel()
        {
            var filmsJson = ImdbWebClient.GetFilms();

            IEnumerable<FilmViewModel> filmViewModels = FilmsParser.Parse(filmsJson).Select(x => new FilmViewModel(x));
            Films = new ObservableCollection<FilmViewModel>(filmViewModels);
        }

        public ObservableCollection<FilmViewModel> Films { get; private set; }
        public FilmViewModel SelectedFilm { get { return _selectedFilm; } set { _selectedFilm = value; OnPropertyChanged("SelectedFilm"); } }
    }
}
