using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ImdbClientInterface
{
    public class RatingFilter : IFilter
    {
        private readonly double _rating;

        public RatingFilter(double rating)
        {
            _rating = rating;
            ValidateRating();
        }

        private void ValidateRating()
        {
            if(_rating < 0 || _rating > 10)
            {
                throw new ArgumentOutOfRangeException(string.Format("Rating to filter by must be between 0 and 10. Rating set is: {0}", _rating));
            }
        }

        public IEnumerable<Film> Filter(IEnumerable<Film> unfilteredFilms)
        {
            return unfilteredFilms.Where(x => x.Rating >= _rating);
        }
    }
}
