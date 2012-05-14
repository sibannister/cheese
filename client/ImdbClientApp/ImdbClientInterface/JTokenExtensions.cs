using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using Newtonsoft.Json.Linq;

namespace ImdbClientInterface
{
    public static class JTokenExtensions
    {
        public static T GetValue<T>(this JToken jToken, string key,
                            T defaultValue = default(T))
        {
            T returnValue = defaultValue;

            if (jToken[key] != null)
            {
                object data = null;
                string sData = jToken[key].ToString();

                Type type = typeof(T);

                if (type == typeof(double))
                    data = double.Parse(sData);
                else if (type == typeof(string))
                    data = sData;

                if (null == data && type.IsValueType)
                    throw new ArgumentException("Cannot parse type \"" +
                        type.FullName + "\" from value \"" + sData + "\"");

                returnValue = (T)Convert.ChangeType(data,
                    type, CultureInfo.InvariantCulture);
            }

            return returnValue;
        }
    }
}
