using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ImdbClientInterface;

namespace ImdbClientAppMVVM.ViewModel
{
    public class FilmViewModel : ViewModel
    {
        private readonly Film _film;

        public FilmViewModel(Film film)
        {
            _film = film;
        }

        public string Name { get { return _film.Name; } }
        public string Channel { get { return _film.Channel; } }
        public DateTime StartTime { get { return _film.StartDateTime; } }
        public double Rating { get { return _film.Rating; } }
    }
}
