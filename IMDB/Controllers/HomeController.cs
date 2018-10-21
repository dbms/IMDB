using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IMDB.Models;
using IMDB.BLL;

namespace IMDB.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Admin()
        {
            return View();
        }

        [HttpGet]
        public JsonResult DisplayMoviesPosters()
        {
            CommonClass obj = new CommonClass();
            return Json(obj.DisplayMoviesPosters(), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult SaveActorDetails(ModelActor act)
        {
            CommonClass obj = new CommonClass();
            return Json(obj.saveActorDetails(act), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult SaveProducerDetails(ModelProducer pro)
        {
            CommonClass obj = new CommonClass();
            return Json(obj.saveProducerDetails(pro), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult SaveMovieDetails(ModelMovie mov)
        {
            string returnMessage = string.Empty;

            var uniqueFileName = "";
            bool validExtension = false;

            if (Request.Files["PosterFile"] != null)
            {
                var file = Request.Files["PosterFile"];
                var ext = System.IO.Path.GetExtension(file.FileName);
                List<string> fileExtensions = new List<string> { ".JPG", ".JPE", ".BMP", ".GIF", ".PNG" };

                foreach (var f in fileExtensions)
                {
                    if (f == ext.ToUpper())
                    {
                        validExtension = true;
                        break;
                    }
                }

                if (validExtension)
                {
                    uniqueFileName = Guid.NewGuid().ToString() + ext;

                    var rootPath = Server.MapPath("~/Content/MoviePosters");
                    var filePath = System.IO.Path.Combine(rootPath, uniqueFileName);
                    file.SaveAs(filePath);
                }
                else
                    returnMessage = "Upload a valid Image File";
            }

            CommonClass obj = new CommonClass();
            if (returnMessage == "")
            {
                returnMessage = obj.saveMovieDetails(mov, uniqueFileName);
                return Json(returnMessage, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(returnMessage, JsonRequestBehavior.AllowGet);
        }

        // searching here        
        [HttpGet]
        public JsonResult SearchActorDetails(string Name)
        {
            CommonClass obj = new CommonClass();
            return Json(obj.searchActorDetails(Name), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult SearchProducerDetails(string Name)
        {
            CommonClass obj = new CommonClass();
            return Json(obj.searchProducerDetails(Name), JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public JsonResult SearchMovieDetails(string Name)
        {
            CommonClass obj = new CommonClass();
            return Json(obj.searchMovieDetails(Name), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult BindDdlActors()
        {
            CommonClass obj = new CommonClass();
            return Json(obj.BindDdlActors(), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult BindDDLProducers()
        {
            CommonClass obj = new CommonClass();
            return Json(obj.BindDDLProducers(), JsonRequestBehavior.AllowGet);
        }

    }
}