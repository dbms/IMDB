using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IMDB.Models
{
    public class Models
    { }

    public class ModelActor
    {
        public Int64 UID { get; set; }
        public string Name { get; set; }
        public string Sex { get; set; }
        public string DOB { get; set; }
        public string Bio { get; set; }
        public string Mode { get; set; }
    }

    public class ModelProducer
    {
        public Int64 UID { get; set; }
        public string Name { get; set; }
        public string Sex { get; set; }
        public string DOB { get; set; }
        public string Bio { get; set; }
        public string Mode { get; set; }
    }

    public class ModelMovie
    {
        public Int64 UID { get; set; }
        public string Name { get; set; }
        public string YearOfRelease { get; set; }
        public string Producer { get; set; }
        public string Actors { get; set; }
        public string Plot { get; set; }
        public string PosterFile { get; set; }
        public string Mode { get; set; }

    }
}