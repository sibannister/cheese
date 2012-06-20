using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ImdbClientInterface
{
    public interface IFilter
    {
        IEnumerable<Film> Filter(IEnumerable<Film> unfilteredFilms);
    }
}
