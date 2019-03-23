using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Hospital.Management.Web.Json;
using Hospital.Management.Web.Models;

namespace Hospital.Management.Web.Controllers
{
    public class HomeController : Controller
    {

        public ActionResult Index()
        {

            ViewBag.Title = "Home";

            ViewBag.LoginUrl = "/Home/Login";
            ViewBag.LoginText = "Login";

            return View();
        }

        public ActionResult Login()
        {

            ViewBag.Title = "Login";

            ViewBag.LoginUrl = "/Home/Login";
            ViewBag.LoginText = "Login";

            return View();
        }

        public ActionResult About()
        {

            ViewBag.Title = "About";

            ViewBag.LoginUrl = "/Home/Login";
            ViewBag.LoginText = "Login";

            return View();
        }

        public ActionResult Contact()
        {

            ViewBag.Title = "Contact";

            ViewBag.LoginUrl = "/Home/Login";
            ViewBag.LoginText = "Login";

            return View();
        }

        public ActionResult Logout(int? id)
        {
            Entities entity = new Entities();

            hosUser user = entity.hosUsers.Where(u => u.ID == id).FirstOrDefault();

            if (user == null)
                user = entity.hosUsers.Where(u => u.ID == 1).FirstOrDefault();

            user.Online = false;
            user.LastSeen = DateTime.Now;

            return Redirect("/Home/Index");
        }


        [HttpPost]
        public string LogTheUserIn(string username, string password)
        {

            Entities entity = new Entities();

            hosUser user = entity.hosUsers.Where(u => u.Username == username && u.Password == password).FirstOrDefault();

            if (user != null)
            {
                user.Online = true;
                user.LastSeen = DateTime.Now;

                entity.SaveChanges();

                if (user.ID == 1)
                    return "/Admin";
                else if (entity.hosPatients.Where(p => p.UserID == user.ID).FirstOrDefault() != null)
                    return "/Patient/Index/" + user.ID;
                else if (entity.hosDoctors.Where(p => p.UserID == user.ID).FirstOrDefault() != null)
                    return "/Doctor/Index/" + user.ID;
            }

            return "/Home/Login";

        }

        [HttpPost]
        public void SaveUser(JsonPatient user)
        {
            Entities entity = new Entities();

            hosUser u = new hosUser()
            {
                Online = true,
                LastSeen = DateTime.Now,
                Username = user.username,
                Password = user.password
            };

            entity.hosUsers.Add(u);
            int i = entity.SaveChanges();

            hosPatient patient = new hosPatient()
            {
                Age = user.age,
                Email = user.email,
                Name = user.name,
                Phone = user.phone,
                Surname = user.surname,
                UserID = u.ID,
                InsuranceID = 4
            };

            entity.hosPatients.Add(patient);

            entity.SaveChanges();
        }
    }
}
