using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ImdbClientInterface
{
    public class Channel
    {
        public string Name { get; private set; }
        public Film[] Films { get; private set; }

        public Channel(string name, Film[] films)
        {
            Name = name;
            Films = films;
        }

        public bool Equals(Channel other)
        {
            if (ReferenceEquals(null, other)) return false;
            if (ReferenceEquals(this, other)) return true;
            return Equals(other.Name, Name) && Equals(other.Films, Films);
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            if (ReferenceEquals(this, obj)) return true;
            if (obj.GetType() != typeof (Channel)) return false;
            return Equals((Channel) obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                return ((Name != null ? Name.GetHashCode() : 0)*397) ^ (Films != null ? Films.GetHashCode() : 0);
            }
        }
    }
}
