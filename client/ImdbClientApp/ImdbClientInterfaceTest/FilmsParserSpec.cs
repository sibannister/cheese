using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using ImdbClientInterface;
using Machine.Specifications;

namespace ImdbClientInterfaceTest
{
    [Subject(typeof(FilmsParser))]
    public class FilmsParserSpec
    {
        public class when_parsing_channels_without_films
        {
            private Establish context = () =>
            {
                StreamReader streamReader = File.OpenText(@"JSON\Films.json");
                _filmsJson = streamReader.ReadToEnd();
            };

            private Because of = () => { _films = FilmsParser.Parse(_filmsJson); };

            private It should_return_correct_number_of_channels = () => _films.Count().ShouldEqual(16);

            private It should_contain_the_expected_channel_names = () => _films.ShouldContain(new Film("The Godfather", 7.3, "ITV 1", DateTime.Parse("2012-06-14 21:13")));

            private static string _filmsJson;
            private static Film[] _films;
        }

    }
}
