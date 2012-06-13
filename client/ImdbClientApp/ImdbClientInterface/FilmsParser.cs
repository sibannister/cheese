using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json.Linq;

namespace ImdbClientInterface
{
    public class FilmsParser
    {
        private const string NameKey = "name";
        private const string RatingKey = "rating";
        private const string ChannelKey = "channel";
        private const string StartDateTimeKey = "start";

        public static Film[] Parse(string filmsJson)
        {
            JArray array = JArray.Parse(filmsJson);
            JEnumerable<JToken> filmsJToken = array.Children();
            var filmList = new List<Film>();
            foreach (var film in filmsJToken)
            {
                string name = GetName(film);
                double rating = GetRating(film);
                string channel = GetChannel(film);
                DateTime startDateTime = GetStartDateTime(film);
                filmList.Add(new Film(name, rating, channel, startDateTime));
            }
            return filmList.ToArray();
        }

        private static double GetRating(JToken filmJson)
        {
            double rating = 0;
            return filmJson.GetValue(RatingKey, rating);
        }

        private static string GetName(JToken filmJson)
        {
            string name = null;
            return filmJson.GetValue(NameKey, name);
        }
        
        private static string GetChannel(JToken filmJson)
        {
            string channel = null;
            return filmJson.GetValue(NameKey, channel);
        }

        private static DateTime GetStartDateTime(JToken filmJson)
        {
            string startDateTime = "1900/1/1";
            string startJson = filmJson.GetValue(StartDateTimeKey, startDateTime);
            return DateTime.Parse(startJson);
        }
    }
}
