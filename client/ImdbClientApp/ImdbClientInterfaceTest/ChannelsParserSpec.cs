using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using ImdbClientInterface;
using Machine.Specifications;

namespace ImdbClientInterfaceTest
{
    [Subject(typeof(ChannelsParser))]
    public class ChannelsParserSpec
    {
        public class when_parsing_channels_without_films
        {
            private Establish context = () =>
                                            {
                                                StreamReader streamReader = File.OpenText(@"JSON\Channels.json");
                                                _channelsJson = streamReader.ReadToEnd();
                                            };

            private Because of = () => { _channels = ChannelsParser.Parse(_channelsJson); };

            private It should_return_correct_number_of_channels = () => _channels.Count().ShouldEqual(13);

            private It should_contain_the_expected_channel_names = () => _channels.Contains(new Channel("Film 4", new Film[0]));

            private static string _channelsJson;
            private static Channel[] _channels;
        }
    }
}
