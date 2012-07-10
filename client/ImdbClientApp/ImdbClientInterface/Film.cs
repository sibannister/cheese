using System;

namespace ImdbClientInterface
{
    public class Film
    {
        public string Name { get; set; }
        public double Rating { get; set; }
        public string Channel { get; set; }
        public DateTime StartDateTime { get; set; }
        public DateTime EndDateTime { get; set; }
        public string Image { get; set; }

        public Film(string name, double rating, string channel, DateTime startDateTime, DateTime endDateTime, string image)
        {
            Name = name;
            Rating = rating;
            Channel = channel;
            StartDateTime = startDateTime;
            EndDateTime = endDateTime;
            Image = image;
        }

        public bool Equals(Film other)
        {
            if (ReferenceEquals(null, other)) return false;
            if (ReferenceEquals(this, other)) return true;
            return Equals(other.Name, Name) && Equals(other.Channel, Channel) && other.Rating.Equals(Rating) && other.StartDateTime.Equals(StartDateTime) && other.EndDateTime.Equals(EndDateTime) && other.Image.Equals(Image);
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
                result = (result * 397) ^ EndDateTime.GetHashCode();
                result = (result*397) ^ Image.GetHashCode();
                return result;
            }
        }
    }
}
