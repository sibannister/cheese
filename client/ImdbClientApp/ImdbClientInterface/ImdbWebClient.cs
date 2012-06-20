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
        public static double GetFilmRating(string filmTitle)
        {
            using (var webClient = new WebClient())
            {
                byte[] myDataBuffer = webClient.DownloadData(string.Format(@"http://localhost:8080/films?name={0}", filmTitle));
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
                byte[] myDataBuffer = webClient.DownloadData(@"http://localhost:8080/films?");
                return Encoding.ASCII.GetString(myDataBuffer);
            }
        }
    }    
}