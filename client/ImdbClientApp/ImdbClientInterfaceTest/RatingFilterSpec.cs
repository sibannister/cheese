using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using ImdbClientInterface;
using Machine.Specifications;
using Machine.Specifications.Annotations;

namespace ImdbClientInterfaceTest
{
    [Subject(typeof(RatingFilter))]
    [UsedImplicitly]
    public class RatingFilterSpec
    {
        public class when_filtering_by_rating
        {
            Establish context = ()=>
                                    {
                                        StreamReader streamReader = File.OpenText(@"JSON\Films.json");
                                        _filmsJson = streamReader.ReadToEnd();
                                        _films = FilmsParser.Parse(_filmsJson);
                                        _rating = 8.0;
                                        _ratingFilter = new RatingFilter(_rating);
                                    };

            private Because of = () => _filteredFilms = _ratingFilter.Filter(_films);

            private It should_not_contain_any_below_rating = () => _filteredFilms.Any(x => x.Rating < _rating).ShouldBeFalse();

            private It should_contain_films_above_rating = () => _filteredFilms.Any(x => x.Rating > _rating).ShouldBeTrue();

            private It should_contain_films_equal_to_rating = () => _filteredFilms.Any(x => x.Rating == _rating).ShouldBeTrue();

            private static string _filmsJson;
            private static Film[] _films;
            private static RatingFilter _ratingFilter;
            private static IEnumerable<Film> _filteredFilms;
            private static double _rating;
        }
    }
}
