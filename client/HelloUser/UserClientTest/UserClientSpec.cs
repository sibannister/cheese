using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Machine.Specifications;
using Machine.Specifications.Annotations;

namespace UserClientTest
{    
    public class UserClientSpec
    {
        public class when_passing_username_to_end_point
        {
            private static string _result;
            private const string Username = "Simon";
            private Because of = () => _result = UserClient.UserClient.SubmitUsername(Username);
            private It should_reply_with_my_username = () => _result.ShouldEqual(string.Format("Hello {0}", Username));
        }
    }
}
