using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;

namespace UserClient
{
    public class UserClient
    {
        public static string SubmitUsername(string username)
        {
            using(var webClient = new WebClient())
            {
                byte[] myDataBuffer = webClient.DownloadData(string.Format(@"http:\\localhost:8080?name={0}", username));
                return Encoding.ASCII.GetString(myDataBuffer);    
            }            
        }
    }
}
