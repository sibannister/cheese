using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json.Linq;

namespace ImdbClientInterface
{
    public class ChannelsParser
    {
        public const string NameKey = "name";
        public const string FilmsKey = "films";
        public static Channel[] Parse(string channelsJson)
        {
            JArray array = JArray.Parse(channelsJson);
            JEnumerable<JToken> channelsJTokens = array.Children();
            var channels = new List<Channel>();
            foreach (var channelJson in channelsJTokens)
            {
                string name = GetName(channelJson);
                Film[] films = GetFilms(channelJson);
                channels.Add(new Channel(name, films));
            }
            return channels.ToArray();
        }

        private static string GetName(JToken channelsJson)
        {
            string name = null;
            return channelsJson.GetValue(NameKey, name);
        }

        private static Film[] GetFilms(JToken channelsJson)
        {
            Film[] films = new Film[0];
            return channelsJson.GetValue(FilmsKey, films);
        }
    }
}
