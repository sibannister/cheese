using System;
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

        public string Name { get { return _film.Name; } set { _film.Name = value; } }
        public string Channel { get { return _film.Channel; } set { _film.Channel = value; } }
        public string StartDateTime { get { return _film.StartDateTime.ToString("HH:mm dddd dd-MMM"); } set { _film.StartDateTime = DateTime.Parse(value); } }
        public string EndDateTime { get { return _film.EndDateTime.ToString("HH:mm dddd dd-MMM"); } set { _film.EndDateTime = DateTime.Parse(value); } }
        public double Rating { get { return _film.Rating; } set { _film.Rating = value; } }
        public string Image { get { return _film.Image; } set { _film.Image = value; } }
    }
}
