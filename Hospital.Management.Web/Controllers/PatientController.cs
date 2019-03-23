using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using Hospital.Management.Web.Json;
using Hospital.Management.Web.Models;

namespace Hospital.Management.Web.Controllers
{
    public class PatientController : Controller
    {
        private hosUser Login(int id)
        {
            Entities entity = new Entities();

            hosUser user = entity.hosUsers.Where(u => u.ID == id).FirstOrDefault();

            if (user.LastSeen.Value.AddMinutes(10) < DateTime.Now)
            {
                user.Online = false;
                user.LastSeen = DateTime.Now;

                Response.Redirect("/Home/Login");
            }

            user.LastSeen = DateTime.Now;

            return user;
        }

        public ActionResult Index(int id)
        {
            dynamic glossary = new ExpandoObject();

            hosUser user = Login(id);

            glossary.id = id;
            glossary.username = user.Username;

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Info(int id)
        {
            dynamic glossary = new ExpandoObject();

            hosUser user = Login(id);

            glossary.id = id;
            glossary.username = user.Username;

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Doctors(int id)
        {
            dynamic glossary = new ExpandoObject();

            hosUser user = Login(id);

            glossary.id = id;
            glossary.username = user.Username;

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Complaints(int id)
        {
            dynamic glossary = new ExpandoObject();

            hosUser user = Login(id);

            glossary.id = id;
            glossary.username = user.Username;

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Insurance(int id)
        {
            dynamic glossary = new ExpandoObject();

            hosUser user = Login(id);

            glossary.id = id;
            glossary.username = user.Username;

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }


        [HttpGet]
        public JsonResult ById(int id)
        {
            Entities entity = new Entities();

            hosUser user = entity.hosUsers.Where(u => u.ID == id).FirstOrDefault();

            hosPatient patient = entity.hosPatients.Where(p => p.UserID == id).FirstOrDefault();

            hosInsurance insurance = patient.hosInsurance;

            List<hosComplaint> listComplaints = patient.hosComplaints.ToList();

            JsonPatient json = new JsonPatient()
            {
                age = patient.Age.Value,
                complaints = new List<JsonComplaint>(),
                email = patient.Email,
                id = patient.ID,
                index = 0,
                name = patient.Name,
                phone = patient.Phone,
                surname = patient.Surname,
                password = user.Password,
                username = user.Username
            };

            if (insurance != null)
            {
                json.insurance = new JsonInsurance()
                {
                    discount = int.Parse(insurance.Discount.Value.ToString()),
                    id = insurance.ID,
                    index = 0,
                    name = insurance.Name
                };
            }

            int index, index2;

            JsonComplaint complaint;
            JsonDoctor doctor;
            List<JsonBooking> listBookings;
            List<JsonDiagnosis> listDiagnosis;
            List<JsonTransaction> listTransactions;
            List<JsonPrescription> listPrescriptions;
            List<JsonExamination> listExaminations;

            index = 0;

            foreach (hosComplaint c in listComplaints)
            {
                index++;

                complaint = new JsonComplaint()
                {
                    index = index,
                    id = c.ID,
                    title = c.Title,
                    text = c.Text
                };

                doctor = new JsonDoctor()
                {
                    age = c.hosDoctor.Age.Value,
                    email = c.hosDoctor.Email,
                    id = c.hosDoctor.ID,
                    index = 0,
                    name = c.hosDoctor.Name,
                    phone = c.hosDoctor.Phone,
                    surname = c.hosDoctor.Surname
                };

                listDiagnosis = new List<JsonDiagnosis>();

                index2 = 0;

                foreach (hosDiagnosi d in c.hosDiagnosis)
                {
                    index2++;

                    listDiagnosis.Add
                    (
                        new JsonDiagnosis()
                        {
                            comment = d.Comment,
                            disease = new JsonDisease()
                            {
                                id = d.hosDisease.ID,
                                name = d.hosDisease.Name,
                                index = index2
                            },
                            id = d.ID,
                            index = index2
                        }
                    );
                }

                listBookings = new List<JsonBooking>();

                index2 = 0;

                foreach (hosBooking b in c.hosBookings)
                {
                    index2++;

                    listBookings.Add
                    (
                        new JsonBooking()
                        {
                            endDate = b.EndDate.Value.ToString("dd-MM-yyyy"),
                            id = b.ID,
                            index = index2,
                            room = new JsonRoom()
                            {
                                endDate = b.EndDate.Value.ToString("dd-MM-yyyy"),
                                floor = b.hosRoom.Floor.Value,
                                id = b.hosRoom.ID,
                                index = 0,
                                number = b.hosRoom.Number.Value.ToString(),
                                startDate = b.StartDate.Value.ToString("dd-MM-yyyy"),
                            },
                            startDate = b.StartDate.Value.ToString("dd-MM-yyyy"),
                            status = b.Status.Value
                        }
                    );
                }

                listTransactions = new List<JsonTransaction>();

                index2 = 0;

                foreach (hosTransaction t in c.hosTransactions)
                {
                    index2++;

                    listTransactions.Add
                    (
                        new JsonTransaction()
                        {
                            amount = t.Amount.Value,
                            date = (t.Date.HasValue) ? t.Date.Value.ToString("dd-MM-yyyy") : "",
                            id = t.ID,
                            index = index2,
                            provisionDate = t.ProvisionDate.Value.ToString("dd-MM-yyyy"),
                            status = t.Status.Value
                        }
                    );
                }

                listPrescriptions = new List<JsonPrescription>();

                index2 = 0;

                foreach (hosPrescription p in c.hosPrescriptions)
                {
                    index2++;

                    listPrescriptions.Add
                    (
                        new JsonPrescription()
                        {
                            comment = p.Comment,
                            id = p.ID,
                            index = index2,
                            medication = new JsonMedication()
                            {
                                id = p.hosMedication.ID,
                                index = index2,
                                name = p.hosMedication.Name
                            }
                        }
                    );
                }

                listExaminations = new List<JsonExamination>();

                index2 = 0;

                foreach (hosComplaintExamination e in c.hosComplaintExaminations)
                {
                    index2++;

                    listExaminations.Add
                    (
                        new JsonExamination()
                        {
                            fee = e.hosExamination.Fee.Value,
                            id = e.hosExamination.ID,
                            id2 = e.ID,
                            index = index2,
                            name = e.hosExamination.Name,
                            needsRoom = e.hosExamination.NeedsRoom.Value
                        }
                    );
                }

                complaint.doctor = doctor;
                complaint.diagnosis = listDiagnosis;
                complaint.bookings = listBookings;
                complaint.transactions = listTransactions;
                complaint.prescriptions = listPrescriptions;
                complaint.examinations = listExaminations;

                json.complaints.Add(complaint);

            }

            return Json(json, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public void SaveInfo(JsonPatient json)
        {
            Entities entity = new Entities();

            hosPatient patient = entity.hosPatients.Where(p => p.ID == json.id).FirstOrDefault();

            patient.Name = json.name;
            patient.Surname = json.surname;
            patient.Age = json.age;
            patient.Email = json.email;
            patient.Phone = json.phone;
            patient.InsuranceID = json.insurance.id;

            hosUser user = entity.hosUsers.Where(u => u.ID == patient.UserID).FirstOrDefault();

            user.Username = json.username;
            user.Password = json.password;

            entity.SaveChanges();
        }

        [HttpGet]
        public JsonResult DoctorsOfPatient(int id)
        {
            Entities entity = new Entities();

            hosPatient patient = entity.hosPatients.Where(p => p.UserID == id).FirstOrDefault();

            List<hosComplaint> listComplaints = patient.hosComplaints.ToList();

            List<JsonDoctor> json = new List<JsonDoctor>();

            int index = 0;

            foreach (hosComplaint complaint in listComplaints)
            {
                index++;

                json.Add
                (
                    new JsonDoctor()
                    {
                        age = complaint.hosDoctor.Age.Value,
                        email = complaint.hosDoctor.Email,
                        id = complaint.hosDoctor.ID,
                        index = index,
                        name = complaint.hosDoctor.Name,
                        phone = complaint.hosDoctor.Phone,
                        surname = complaint.hosDoctor.Surname
                    }
                );
            }

            return Json(json, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult ComplaintsOfPatient(int id)
        {
            Entities entity = new Entities();

            hosPatient patient = entity.hosPatients.Where(p => p.UserID == id).FirstOrDefault();

            hosInsurance insurance = patient.hosInsurance;

            List<hosComplaint> listComplaints = patient.hosComplaints.ToList();

            JsonPatient json = new JsonPatient()
            {
                age = patient.Age.Value,
                complaints = new List<JsonComplaint>(),
                email = patient.Email,
                id = patient.ID,
                index = 0,
                insurance = new JsonInsurance()
                {
                    discount = int.Parse(insurance.Discount.Value.ToString()),
                    id = insurance.ID,
                    index = 0,
                    name = insurance.Name
                },
                name = patient.Name,
                phone = patient.Phone,
                surname = patient.Surname,
            };

            int index, index2;

            JsonComplaint complaint;
            JsonDoctor doctor;
            List<JsonBooking> listBookings;
            List<JsonDiagnosis> listDiagnosis;
            List<JsonTransaction> listTransactions;
            List<JsonPrescription> listPrescriptions;
            List<JsonExamination> listExaminations;

            index = 0;

            foreach (hosComplaint c in listComplaints)
            {
                index++;

                complaint = new JsonComplaint()
                {
                    index = index,
                    id = c.ID,
                    title = c.Title,
                    text = c.Text,
                    status = c.Status.Value
                };

                doctor = new JsonDoctor()
                {
                    age = c.hosDoctor.Age.Value,
                    email = c.hosDoctor.Email,
                    id = c.hosDoctor.ID,
                    index = 0,
                    name = c.hosDoctor.Name,
                    phone = c.hosDoctor.Phone,
                    surname = c.hosDoctor.Surname
                };

                listDiagnosis = new List<JsonDiagnosis>();

                index2 = 0;

                foreach (hosDiagnosi d in c.hosDiagnosis)
                {
                    index2++;

                    listDiagnosis.Add
                    (
                        new JsonDiagnosis()
                        {
                            comment = d.Comment,
                            disease = new JsonDisease()
                            {
                                id = d.hosDisease.ID,
                                name = d.hosDisease.Name,
                                index = index2
                            },
                            id = d.ID,
                            index = index2
                        }
                    );
                }

                listBookings = new List<JsonBooking>();

                index2 = 0;

                foreach (hosBooking b in c.hosBookings)
                {
                    index2++;

                    listBookings.Add
                    (
                        new JsonBooking()
                        {
                            endDate = b.EndDate.Value.ToString("dd-MM-yyyy"),
                            id = b.ID,
                            index = index2,
                            room = new JsonRoom()
                            {
                                endDate = b.EndDate.Value.ToString("dd-MM-yyyy"),
                                floor = b.hosRoom.Floor.Value,
                                id = b.hosRoom.ID,
                                index = 0,
                                number = b.hosRoom.Number.Value.ToString(),
                                startDate = b.StartDate.Value.ToString("dd-MM-yyyy"),
                            },
                            startDate = b.StartDate.Value.ToString("dd-MM-yyyy"),
                            status = b.Status.Value
                        }
                    );
                }

                listTransactions = new List<JsonTransaction>();

                index2 = 0;

                foreach (hosTransaction t in c.hosTransactions)
                {
                    index2++;

                    listTransactions.Add
                    (
                        new JsonTransaction()
                        {
                            amount = t.Amount.Value,
                            date = (t.Date.HasValue) ? t.Date.Value.ToString("dd-MM-yyyy") : "",
                            id = t.ID,
                            index = index2,
                            provisionDate = t.ProvisionDate.Value.ToString("dd-MM-yyyy"),
                            status = t.Status.Value
                        }
                    );
                }

                listPrescriptions = new List<JsonPrescription>();

                index2 = 0;

                foreach (hosPrescription p in c.hosPrescriptions)
                {
                    index2++;

                    listPrescriptions.Add
                    (
                        new JsonPrescription()
                        {
                            comment = p.Comment,
                            id = p.ID,
                            index = index2,
                            medication = new JsonMedication()
                            {
                                id = p.hosMedication.ID,
                                index = index2,
                                name = p.hosMedication.Name
                            }
                        }
                    );
                }

                listExaminations = new List<JsonExamination>();

                index2 = 0;

                foreach (hosComplaintExamination e in c.hosComplaintExaminations)
                {
                    index2++;

                    listExaminations.Add
                    (
                        new JsonExamination()
                        {
                            fee = e.hosExamination.Fee.Value,
                            id = e.hosExamination.ID,
                            id2 = e.ID,
                            index = index2,
                            name = e.hosExamination.Name,
                            needsRoom = e.hosExamination.NeedsRoom.Value,
                            date = e.Date.Value.ToString("dd-MM-yyyy"),
                            status = e.Status.Value
                        }
                    );
                }

                complaint.doctor = doctor;
                complaint.diagnosis = listDiagnosis;
                complaint.bookings = listBookings;
                complaint.transactions = listTransactions;
                complaint.prescriptions = listPrescriptions;
                complaint.examinations = listExaminations;

                json.complaints.Add(complaint);

            }

            return Json(json, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public void SaveComplaints(JsonPatient json)
        {
            Entities entity = new Entities();

            hosPatient patient = entity.hosPatients.Where(p => p.ID == json.id).FirstOrDefault();

            bool itIsNew = patient == null;

            if (itIsNew)
                patient = new hosPatient();

            patient.Name = json.name;
            patient.Surname = json.surname;
            patient.Age = json.age;
            patient.Email = json.email;
            patient.Phone = json.phone;
            patient.InsuranceID = json.insurance.id;

            hosComplaint complaint;
            hosBooking booking;
            hosTransaction transaction;
            hosPrescription prescription;
            hosDiagnosi diagnosis;
            hosComplaintExamination examination;

            foreach (JsonComplaint c in json.complaints)
            {
                complaint = entity.hosComplaints.Where(com => com.ID == c.id).FirstOrDefault();

                complaint.Title = c.title;
                complaint.Text = c.text;
                complaint.hosDoctor = entity.hosDoctors.Where(d => d.ID == c.doctor.id).FirstOrDefault();

                if (c.bookings != null)
                {

                    int roomNumber;

                    foreach (JsonBooking b in c.bookings)
                    {
                        booking = entity.hosBookings.Where(book => book.ID == b.id).FirstOrDefault();

                        roomNumber = int.Parse(b.room.number);

                        booking.EndDate = DateTime.ParseExact(b.endDate, "dd-MM-yyyy", null);
                        booking.RoomID = entity.hosRooms.Where(r => r.Number.Value == roomNumber).FirstOrDefault().ID;
                        booking.StartDate = DateTime.ParseExact(b.startDate, "dd-MM-yyyy", null);
                        booking.Status = b.status;

                        entity.SaveChanges();
                    }

                }

                if (c.transactions != null)
                {

                    foreach (JsonTransaction t in c.transactions)
                    {
                        transaction = entity.hosTransactions.Where(trans => trans.ID == t.id).FirstOrDefault();

                        transaction.Amount = t.amount;
                        transaction.Status = t.status;

                        entity.SaveChanges();
                    }

                }

                if (c.prescriptions != null)
                {

                    foreach (JsonPrescription p in c.prescriptions)
                    {
                        prescription = entity.hosPrescriptions.Where(pre => pre.ID == p.id).FirstOrDefault();

                        prescription.Comment = p.comment;
                        prescription.hosMedication = entity.hosMedications.Where(m => m.ID == p.medication.id).FirstOrDefault();

                        entity.SaveChanges();
                    }

                }

                if (c.diagnosis != null)
                {

                    foreach (JsonDiagnosis d in c.diagnosis)
                    {
                        diagnosis = entity.hosDiagnosis.Where(dia => dia.ID == d.id).FirstOrDefault();

                        diagnosis.Comment = d.comment;
                        diagnosis.hosDisease = entity.hosDiseases.Where(dis => dis.ID == d.disease.id).FirstOrDefault();

                        entity.SaveChanges();
                    }

                }

                if (c.examinations != null)
                {

                    foreach (JsonExamination e in c.examinations)
                    {
                        examination = entity.hosComplaintExaminations.Where(exam => exam.ID == e.id2).FirstOrDefault();

                        examination.ExaminationID = e.id;

                        entity.SaveChanges();
                    }

                }

                entity.SaveChanges();

            }

            if (itIsNew)
                entity.hosPatients.Add(patient);

            entity.SaveChanges();
        }

        [HttpPost]
        public void SaveComplaint(int id, JsonComplaint json)
        {
            Entities entity = new Entities();

            hosComplaint complaint = new hosComplaint();

            complaint.Title = json.title;
            complaint.Text = json.text;
            complaint.PatientID = entity.hosPatients.Where(p => p.UserID == id).FirstOrDefault().ID;
            complaint.Status = 0;

            complaint.hosDoctor = entity.hosDoctors.Where(d => d.ID == json.doctor.id).FirstOrDefault();

            entity.hosComplaints.Add(complaint);
            entity.SaveChanges();
        }

        [HttpPost]
        public void TakeExamination(int id, int examinationId)
        {
            Entities entity = new Entities();

            hosComplaintExamination examination = entity.hosComplaintExaminations.Where(e => e.ID == examinationId).FirstOrDefault();

            examination.Status = 1;

            entity.SaveChanges();
        }



        [HttpGet]
        public JsonResult InsuranceOfPatient(int id)
        {
            Entities entity = new Entities();

            hosPatient patient = entity.hosPatients.Where(p => p.ID == id).FirstOrDefault();

            JsonInsurance json = new JsonInsurance()
            {
                discount = int.Parse(patient.hosInsurance.Discount.Value.ToString()),
                id = patient.hosInsurance.ID,
                index = 1,
                name = patient.hosInsurance.Name
            };

            return Json(json, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void SaveInsurance(int id, JsonInsurance json)
        {
            Entities entity = new Entities();

            hosPatient patient = entity.hosPatients.Where(p => p.ID == id).FirstOrDefault();

            bool itIsNew = patient.hosInsurance == null;

            if (itIsNew)
                patient.hosInsurance = new hosInsurance();

            patient.hosInsurance.Discount = json.discount;
            patient.hosInsurance.Name = json.name;

            entity.SaveChanges();
        }


        [HttpGet]
        public JsonResult AllInsurances()
        {
            Entities entity = new Entities();

            List<hosInsurance> listInsurances = entity.hosInsurances.ToList();

            JsonInsurance insurance;
            List<JsonInsurance> json = new List<JsonInsurance>();

            int index = 0;

            foreach (hosInsurance i in listInsurances)
            {
                index++;

                insurance = new JsonInsurance()
                {
                    id = i.ID,
                    index = index,
                    name = i.Name,
                    discount = int.Parse(i.Discount.Value.ToString())
                };

                json.Add(insurance);

            }

            return Json(json, JsonRequestBehavior.AllowGet);
        }

    }
}
