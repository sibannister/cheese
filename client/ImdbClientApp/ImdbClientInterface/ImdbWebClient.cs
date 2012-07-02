using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using Newtonsoft.Json.Linq;

namespace ImdbClientInterface   
{
    public class ImdbWebClient
    {
        private static readonly string FilmsUrl = "http://glowing-sky-4966.herokuapp.com/films?";
        private static readonly string FilmFormat = "name={0}";
        public static double GetFilmRating(string filmTitle)
        {
            using (var webClient = new WebClient())
            {
                byte[] myDataBuffer = webClient.DownloadData(string.Format(FilmsUrl + FilmFormat, filmTitle));
                string json = Encoding.ASCII.GetString(myDataBuffer);
                if(string.IsNullOrEmpty(json))
                {
                    return double.NaN;
                }
                JObject filmJObject = JObject.Parse(json);
                const double zero = 0.0;
                return filmJObject.GetValue("rating", zero);
            }
        }

        public static string GetFilms()
        {
            using (var webClient = new WebClient())
            {
                byte[] myDataBuffer = webClient.DownloadData(FilmsUrl);
                return Encoding.ASCII.GetString(myDataBuffer);
            }
        }
    }    
}