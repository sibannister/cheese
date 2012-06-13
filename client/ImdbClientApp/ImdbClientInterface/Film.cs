using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ImdbClientInterface
{
    public class Film
    {
        public string Name { get; private set; }
        public double Rating { get; private set; }
        public string Channel { get; private set; }
        public DateTime StartDateTime { get; private set; }

        public Film(string name, double rating, string channel, DateTime startDateTime)
        {
            Name = name;
            Rating = rating;
            Channel = channel;
            StartDateTime = startDateTime;
        }

        public bool Equals(Film other)
        {
            if (ReferenceEquals(null, other)) return false;
            if (ReferenceEquals(this, other)) return true;
            return Equals(other.Name, Name) && Equals(other.Channel, Channel) && other.Rating.Equals(Rating) && other.StartDateTime.Equals(StartDateTime);
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            if (ReferenceEquals(this, obj)) return true;
            if (obj.GetType() != typeof (Film)) return false;
            return Equals((Film) obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                int result = Name.GetHashCode();
                result = (result*397) ^ Channel.GetHashCode();
                result = (result*397) ^ Rating.GetHashCode();
                result = (result*397) ^ StartDateTime.GetHashCode();
                return result;
            }
        }
    }
}
