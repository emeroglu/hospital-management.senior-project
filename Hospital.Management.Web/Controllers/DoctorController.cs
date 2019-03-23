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
    public class DoctorController : Controller
    {

        private hosUser Login(int id)
        {
            Entities entity = new Entities();

            hosUser user = entity.hosUsers.Where(u => u.ID == id).FirstOrDefault();

            if (user.LastSeen.Value.AddMinutes(10) < DateTime.Now)
            {
                user.Online = false;
                user.LastSeen = DateTime.Now;

                Redirect("/Home/Login");
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

        public ActionResult Patients(int id)
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


        [HttpGet]
        public JsonResult ById(int id)
        {
            Entities entity = new Entities();

            hosUser user = entity.hosUsers.Where(u => u.ID == id).FirstOrDefault();

            hosDoctor doctor = entity.hosDoctors.Where(d => d.UserID == id).FirstOrDefault();

            JsonDoctor json = new JsonDoctor()
            {
                password = user.Password,
                username = user.Username,
                age = doctor.Age.Value,
                email = doctor.Email,
                id = doctor.ID,
                index = 0,
                name = doctor.Name,
                phone = doctor.Phone,
                surname = doctor.Surname
            };

            return Json(json, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public void SaveInfo(JsonDoctor json)
        {
            Entities entity = new Entities();

            hosDoctor doctor = entity.hosDoctors.Where(d => d.ID == json.id).FirstOrDefault();

            doctor.Age = json.age;
            doctor.Email = json.email;
            doctor.Name = json.name;
            doctor.Phone = json.phone;
            doctor.Surname = json.surname;

            hosUser user = entity.hosUsers.Where(u => u.ID == doctor.UserID).FirstOrDefault();

            user.Username = json.username;
            user.Password = json.password;

            entity.SaveChanges();
        }

        [HttpGet]
        public JsonResult PatientsOfDoctor(int id)
        {
            Entities entity = new Entities();

            List<hosPatient> listPatients = entity.hosPatients.Where(p => p.hosComplaints.Where(c => c.hosDoctor.UserID == id).FirstOrDefault() != null).ToList();

            List<JsonPatient> json = new List<JsonPatient>();

            int index = 0;

            foreach (hosPatient p in listPatients)
            {
                index++;

                json.Add
                (
                    new JsonPatient()
                    {
                        age = p.Age.Value,
                        email = p.Email,
                        id = p.ID,
                        index = index,
                        insurance = new JsonInsurance()
                        {
                            discount = int.Parse(p.hosInsurance.Discount.Value.ToString()),
                            id = p.hosInsurance.ID,
                            index = index,
                            name = p.hosInsurance.Name
                        },
                        name = p.Name,
                        phone = p.Phone,
                        surname = p.Surname
                    }
                );
            }

            return Json(json, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult ComplaintsOfDoctor(int id)
        {
            Entities entity = new Entities();

            hosDoctor doctor = entity.hosDoctors.Where(d => d.UserID == id).FirstOrDefault();

            List<hosComplaint> listComplaints = doctor.hosComplaints.ToList();

            JsonDoctor json = new JsonDoctor()
            {
                age = doctor.Age.Value,
                complaints = new List<JsonComplaint>(),
                email = doctor.Email,
                id = doctor.ID,
                index = 0,
                name = doctor.Name,
                phone = doctor.Phone,
                surname = doctor.Surname,
            };

            int index, index2;

            JsonPatient patient;
            JsonComplaint complaint;
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

                patient = new JsonPatient()
                {
                    age = c.hosPatient.Age.Value,
                    email = c.hosPatient.Email,
                    id = c.hosPatient.ID,
                    index = index,
                    insurance = new JsonInsurance()
                    {
                        discount = int.Parse(c.hosPatient.hosInsurance.Discount.Value.ToString()),
                        id = c.hosPatient.hosInsurance.ID,
                        index = index,
                        name = c.hosPatient.hosInsurance.Name
                    },
                    name = c.hosPatient.Name,
                    phone = c.hosPatient.Phone,
                    surname = c.hosPatient.Surname
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
                            status = e.Status.Value
                        }
                    );
                }

                complaint.patient = patient;
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
        public void SaveExamination(int id, int? complaintId, int examId)
        {
            Entities entity = new Entities();

            hosExamination e = entity.hosExaminations.Where(ex => ex.ID == examId).FirstOrDefault();

            hosComplaint complaint = entity.hosComplaints.Where(c => c.ID == id).FirstOrDefault();

            hosComplaintExamination exam = new hosComplaintExamination()
            {
                ComplaintID = id,
                ExaminationID = examId,
                Date = DateTime.Now.AddDays(complaintId.Value),
                Status = 0
            };

            entity.hosComplaintExaminations.Add(exam);

            hosTransaction trans = new hosTransaction()
            {
                Amount = e.Fee * (100 - complaint.hosPatient.hosInsurance.Discount) / 100, // Amount = Examination Fee - Patient's Insurance Discount
                ComplaintID = id,
                Date = null,
                ProvisionDate = DateTime.Now,
                Status = 0
            };

            if (exam.hosExamination.NeedsRoom == 1)
            {
                hosRoom room = entity.hosRooms.Where(r => r.Status == 0).FirstOrDefault();

                room.Status = 1;

                hosBooking booking = new hosBooking()
                {
                    ComplaintID = id,
                    EndDate = DateTime.Now.AddDays(complaintId.Value),
                    RoomID = room.ID,
                    StartDate = DateTime.Now,
                    Status = 0
                };

                entity.hosBookings.Add(booking);

                trans.Amount += 100;
            }

            entity.hosTransactions.Add(trans);

            complaint.Status = 1;

            entity.SaveChanges();
        }

        [HttpPost]
        public void SaveDiagnosis(int id, JsonDiagnosis json)
        {
            Entities entity = new Entities();

            hosComplaint complaint = entity.hosComplaints.Where(c => c.ID == id).FirstOrDefault();

            complaint.hosDiagnosis.Add
            (
                new hosDiagnosi()
                {
                    Comment = json.comment,
                    ComplaintID = id,
                    DiseaseID = json.disease.id
                }
            );

            entity.SaveChanges();
        }

        [HttpPost]
        public void SavePrescription(int id, JsonPrescription json)
        {
            Entities entity = new Entities();

            hosComplaint complaint = entity.hosComplaints.Where(c => c.ID == id).FirstOrDefault();

            complaint.hosPrescriptions.Add
            (
                new hosPrescription()
                {
                    Comment = json.comment,
                    ComplaintID = id,
                    MedicationID = json.medication.id
                }
            );

            entity.SaveChanges();
        }
    }
}
