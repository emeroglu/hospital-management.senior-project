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
    public class AdminController : Controller
    {

        public ActionResult Index()
        {
            dynamic glossary = new ExpandoObject();

            glossary.username = "admin";

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Doctors()
        {
            dynamic glossary = new ExpandoObject();

            glossary.username = "admin";

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Patient(int id)
        {
            dynamic glossary = new ExpandoObject();

            glossary.username = "admin";

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Patients()
        {
            dynamic glossary = new ExpandoObject();

            glossary.username = "admin";

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Rooms()
        {
            dynamic glossary = new ExpandoObject();

            glossary.username = "admin";

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Insurances()
        {
            dynamic glossary = new ExpandoObject();

            glossary.username = "admin";

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Transactions()
        {
            dynamic glossary = new ExpandoObject();

            glossary.username = "admin";

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }

        public ActionResult Examinations()
        {
            dynamic glossary = new ExpandoObject();

            glossary.username = "admin";

            ViewBag.Glossary = new JavaScriptSerializer().Serialize(glossary);

            return View();
        }


        [HttpGet]
        public JsonResult AllDoctors()
        {
            Entities entity = new Entities();

            List<hosDoctor> listDoctors = entity.hosDoctors.ToList();

            JsonDoctor doctor;
            List<JsonDoctor> json = new List<JsonDoctor>();

            int index = 0;

            foreach (hosDoctor d in listDoctors)
            {
                index++;

                doctor = new JsonDoctor()
                {
                    id = d.ID,
                    age = d.Age.Value,
                    email = d.Email,
                    index = index,
                    name = d.Name,
                    phone = d.Phone,
                    surname = d.Surname,
                    username = d.hosUser.Username,
                    password = d.hosUser.Password
                };

                json.Add(doctor);

            }

            return Json(json, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void SaveDoctor(JsonDoctor json)
        {
            Entities entity = new Entities();

            hosDoctor doctor = entity.hosDoctors.Where(d => d.ID == json.id).FirstOrDefault();

            bool itIsNew = doctor == null;

            if (itIsNew)
            {
                doctor = new hosDoctor();

                hosUser user = new hosUser()
                {
                    LastSeen = DateTime.Now,
                    Online = false,
                    Password = json.password,
                    Username = json.username
                };

                entity.hosUsers.Add(user);
                entity.SaveChanges();

                doctor.UserID = user.ID;
            }

            doctor.Name = json.name;
            doctor.Surname = json.surname;
            doctor.Age = json.age;
            doctor.Email = json.email;
            doctor.Phone = json.phone;

            doctor.hosUser.Username = json.username;
            doctor.hosUser.Password = json.password;

            if (itIsNew)
                entity.hosDoctors.Add(doctor);

            entity.SaveChanges();
        }

        [HttpPost]
        public void DeleteDoctor(int id)
        {
            Entities entity = new Entities();

            hosUser user = entity.hosUsers.Where(u => u.ID == id).FirstOrDefault();

            hosDoctor doctor = entity.hosDoctors.Where(d => d.UserID == id).FirstOrDefault();

            List<hosComplaint> listComplaints = doctor.hosComplaints.ToList();

            foreach (hosComplaint complaint in listComplaints)
            {
                entity.hosBookings.RemoveRange(complaint.hosBookings);
                entity.hosComplaintExaminations.RemoveRange(complaint.hosComplaintExaminations);
                entity.hosDiagnosis.RemoveRange(complaint.hosDiagnosis);
                entity.hosPrescriptions.RemoveRange(complaint.hosPrescriptions);
                entity.hosTransactions.RemoveRange(complaint.hosTransactions);

                entity.hosComplaints.Remove(complaint);
            }

            entity.hosDoctors.Remove(doctor);
            entity.hosUsers.Remove(user);
            entity.SaveChanges();
        }


        [HttpGet]
        public JsonResult PatientById(int id)
        {
            Entities entity = new Entities();

            hosPatient patient = entity.hosPatients.Where(p => p.ID == id).FirstOrDefault();

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

        [HttpGet]
        public JsonResult AllPatients()
        {
            Entities entity = new Entities();

            List<hosPatient> listPatients = entity.hosPatients.ToList();

            JsonPatient patient;
            List<JsonPatient> json = new List<JsonPatient>();

            int index = 0;

            foreach (hosPatient d in listPatients)
            {
                index++;

                patient = new JsonPatient()
                {
                    id = d.ID,
                    age = d.Age.Value,
                    email = d.Email,
                    index = index,
                    name = d.Name,
                    phone = d.Phone,
                    surname = d.Surname,
                    insurance = new JsonInsurance()
                    {
                        id = d.hosInsurance.ID,
                        index = index,
                        name = d.hosInsurance.Name,
                        discount = int.Parse(d.hosInsurance.Discount.Value.ToString())
                    },
                    username = d.hosUser.Username,
                    password = d.hosUser.Password
                };

                json.Add(patient);

            }

            return Json(json, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void SavePatient(JsonPatient json)
        {
            Entities entity = new Entities();

            hosPatient patient = entity.hosPatients.Where(p => p.ID == json.id).FirstOrDefault();

            bool itIsNew = patient == null;

            if (itIsNew)
            {
                patient = new hosPatient();

                hosUser user = new hosUser()
                {
                    LastSeen = DateTime.Now,
                    Online = false,
                    Password = json.password,
                    Username = json.username
                };

                entity.hosUsers.Add(user);
                entity.SaveChanges();

                patient.UserID = user.ID;
            }

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

            if (!itIsNew)
            {

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

            }

            if (itIsNew)
                entity.hosPatients.Add(patient);

            entity.SaveChanges();
        }

        [HttpPost]
        public void DeletePatient(int id)
        {
            Entities entity = new Entities();

            hosUser user = entity.hosUsers.Where(u => u.ID == id).FirstOrDefault();

            hosPatient patient = entity.hosPatients.Where(d => d.UserID == id).FirstOrDefault();

            List<hosComplaint> listComplaints = patient.hosComplaints.ToList();

            foreach (hosComplaint complaint in listComplaints)
            {
                entity.hosBookings.RemoveRange(complaint.hosBookings);
                entity.hosComplaintExaminations.RemoveRange(complaint.hosComplaintExaminations);
                entity.hosDiagnosis.RemoveRange(complaint.hosDiagnosis);
                entity.hosPrescriptions.RemoveRange(complaint.hosPrescriptions);
                entity.hosTransactions.RemoveRange(complaint.hosTransactions);

                entity.hosComplaints.Remove(complaint);
            }

            entity.hosPatients.Remove(patient);
            entity.hosUsers.Remove(user);
            entity.SaveChanges();
        }


        [HttpGet]
        public JsonResult AllRooms()
        {
            Entities entity = new Entities();

            List<hosRoom> listRooms = entity.hosRooms.ToList();

            JsonRoom room;
            List<JsonRoom> json = new List<JsonRoom>();

            hosPatient patient;
            hosBooking booking;

            int index = 0;

            foreach (hosRoom r in listRooms)
            {
                index++;

                room = new JsonRoom()
                {
                    id = r.ID,
                    floor = r.Floor.Value,
                    index = index,
                    number = r.Number.Value.ToString(),
                };

                booking = r.hosBookings.OrderByDescending(b => b.StartDate).FirstOrDefault();

                if (booking != null)
                {

                    patient = booking.hosComplaint.hosPatient;

                    room.startDate = booking.StartDate.Value.ToString("dd-MM-yyyy");
                    room.endDate = booking.EndDate.Value.ToString("dd-MM-yyyy");
                    room.status = booking.Status.Value;

                    room.patient = new JsonPatient()
                    {
                        id = patient.ID,
                        name = patient.Name,
                        surname = patient.Surname
                    };

                }

                json.Add(room);

            }

            return Json(json, JsonRequestBehavior.AllowGet);
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

        [HttpPost]
        public void SaveInsurance(JsonInsurance json)
        {
            Entities entity = new Entities();

            hosInsurance insurance = entity.hosInsurances.Where(i => i.ID == json.id).FirstOrDefault();

            bool itIsNew = insurance == null;

            if (itIsNew)
                insurance = new hosInsurance();

            insurance.Name = json.name;
            insurance.Discount = json.discount;

            if (itIsNew)
                entity.hosInsurances.Add(insurance);

            entity.SaveChanges();
        }

        [HttpPost]
        public void DeleteInsurance(int id)
        {
            Entities entity = new Entities();

            hosInsurance insurance = entity.hosInsurances.Where(i => i.ID == id).FirstOrDefault();

            entity.hosInsurances.Remove(insurance);
            entity.SaveChanges();
        }


        [HttpGet]
        public JsonResult AllTransactions()
        {
            Entities entity = new Entities();

            List<hosTransaction> listTransactions = entity.hosTransactions.ToList();

            JsonTransaction transaction;
            List<JsonTransaction> json = new List<JsonTransaction>();

            int index = 0;

            foreach (hosTransaction t in listTransactions)
            {
                index++;

                transaction = new JsonTransaction()
                {
                    amount = t.Amount.Value,
                    date = (t.Date.HasValue) ? t.Date.Value.ToString("dd-MM-yyyy") : null,
                    id = t.ID,
                    index = index,
                    name = t.hosComplaint.hosPatient.Name,
                    provisionDate = t.ProvisionDate.Value.ToString("dd-MM-yyyy"),
                    status = t.Status.Value,
                    surname = t.hosComplaint.hosPatient.Surname
                };

                json.Add(transaction);

            }

            return Json(json, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void SaveTransaction(JsonInsurance json)
        {
            Entities entity = new Entities();

            hosInsurance insurance = entity.hosInsurances.Where(i => i.ID == json.id).FirstOrDefault();

            bool itIsNew = insurance == null;

            if (itIsNew)
                insurance = new hosInsurance();

            insurance.Name = json.name;
            insurance.Discount = json.discount;

            if (itIsNew)
                entity.hosInsurances.Add(insurance);

            entity.SaveChanges();
        }

        [HttpPost]
        public void DeleteTransaction(int id)
        {
            Entities entity = new Entities();

            hosInsurance insurance = entity.hosInsurances.Where(i => i.ID == id).FirstOrDefault();

            entity.hosInsurances.Remove(insurance);
            entity.SaveChanges();
        }


        [HttpGet]
        public JsonResult AllExaminations()
        {
            Entities entity = new Entities();

            List<hosExamination> listExaminations = entity.hosExaminations.ToList();

            JsonExamination examination;
            List<JsonExamination> json = new List<JsonExamination>();

            int index = 0;

            foreach (hosExamination e in listExaminations)
            {
                index++;

                examination = new JsonExamination()
                {
                    fee = e.Fee.Value,
                    id = e.ID,
                    index = index,
                    name = e.Name,
                    needsRoom = e.NeedsRoom.Value
                };

                json.Add(examination);

            }

            return Json(json, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void SaveExamination(JsonExamination json)
        {
            Entities entity = new Entities();

            hosExamination examination = entity.hosExaminations.Where(e => e.ID == json.id).FirstOrDefault();

            bool itIsNew = examination == null;

            if (itIsNew)
                examination = new hosExamination();

            examination.Fee = json.fee;
            examination.Name = json.name;
            examination.NeedsRoom = json.needsRoom;

            if (itIsNew)
                entity.hosExaminations.Add(examination);

            entity.SaveChanges();
        }

        [HttpPost]
        public void DeleteExamination(int id)
        {
            Entities entity = new Entities();

            hosExamination examination = entity.hosExaminations.Where(e => e.ID == id).FirstOrDefault();

            entity.hosExaminations.Remove(examination);
            entity.SaveChanges();
        }


        [HttpGet]
        public JsonResult AllDiseases()
        {
            Entities entity = new Entities();

            List<hosDisease> listDiseases = entity.hosDiseases.ToList();

            JsonDisease disease;
            List<JsonDisease> json = new List<JsonDisease>();

            int index = 0;

            foreach (hosDisease d in listDiseases)
            {
                index++;

                disease = new JsonDisease()
                {
                    id = d.ID,
                    index = index,
                    name = d.Name
                };

                json.Add(disease);

            }

            return Json(json, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult AllMedications()
        {
            Entities entity = new Entities();

            List<hosMedication> listMedications = entity.hosMedications.ToList();

            JsonMedication medication;
            List<JsonMedication> json = new List<JsonMedication>();

            int index = 0;

            foreach (hosMedication m in listMedications)
            {
                index++;

                medication = new JsonMedication()
                {
                    id = m.ID,
                    index = index,
                    name = m.Name
                };

                json.Add(medication);

            }

            return Json(json, JsonRequestBehavior.AllowGet);
        }
    }
}

