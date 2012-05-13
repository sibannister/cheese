using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;

namespace ImdbClientInterface   
{
    public class ImdbWebClient
    {
        public static string GetFilmRating(string filmTitle)
        {
            using (var webClient = new WebClient())
            {
                byte[] myDataBuffer = webClient.DownloadData(string.Format(@"http:\\localhost:8080?film={0}", filmTitle));
                return Encoding.ASCII.GetString(myDataBuffer);
            }
        }
    }
}