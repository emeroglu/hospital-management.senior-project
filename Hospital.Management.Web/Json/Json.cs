using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Hospital.Management.Web.Json
{
    public class JsonDoctor
    {
        public int index { get; set; }

        public int id { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public string name { get; set; }
        public string surname { get; set; }
        public int age { get; set; }
        public string email { get; set; }
        public string phone { get; set; }

        public List<JsonComplaint> complaints { get; set; }
    }

    public class JsonPatient
    {
        public int index { get; set; }

        public int id { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public string name { get; set; }
        public string surname { get; set; }
        public int age { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public JsonInsurance insurance { get; set; }

        public List<JsonComplaint> complaints { get; set; }
    }

    public class JsonComplaint
    {
        public int index { get; set; }

        public int id { get; set; }
        public JsonDoctor doctor { get; set; }
        public JsonPatient patient { get; set; }
        public string title { get; set; }
        public string text { get; set; }
        public int status { get; set; }

        public List<JsonPrescription> prescriptions { get; set; }
        public List<JsonTransaction> transactions { get; set; }
        public List<JsonDiagnosis> diagnosis { get; set; }
        public List<JsonBooking> bookings { get; set; }
        public List<JsonExamination> examinations { get; set; }
    }

    public class JsonDiagnosis
    {
        public int index { get; set; }

        public int id { get; set; }
        public JsonDisease disease { get; set; }
        public string comment { get; set; }
    }

    public class JsonDisease
    {
        public int index { get; set; }

        public int id { get; set; }
        public string name { get; set; }
    }

    public class JsonMedication
    {
        public int index { get; set; }

        public int id { get; set; }
        public string name { get; set; }
    }

    public class JsonBooking
    {
        public int index { get; set; }

        public int id { get; set; }
        public JsonRoom room { get; set; }
        public string startDate { get; set; }
        public string endDate { get; set; }
        public int status { get; set; }
    }

    public class JsonInsurance
    {
        public int index { get; set; }

        public int id { get; set; }
        public string name { get; set; }
        public int discount { get; set; }
    }

    public class JsonPrescription
    {
        public int index { get; set; }

        public int id { get; set; }
        public JsonMedication medication { get; set; }
        public string comment { get; set; }
    }

    public class JsonRoom
    {
        public int index { get; set; }

        public int id { get; set; }
        public string number { get; set; }
        public int floor { get; set; }
        public JsonPatient patient { get; set; }
        public string startDate { get; set; }
        public string endDate { get; set; }
        public int status { get; set; }
    }

    public class JsonTransaction
    {
        public int index { get; set; }

        public int id { get; set; }
        public string name { get; set; }
        public string surname { get; set; }        
        public decimal amount { get; set; }
        public string provisionDate { get; set; }
        public string date { get; set; }
        public int status { get; set; }
    }

    public class JsonExamination
    {
        public int index { get; set; }

        public int id { get; set; }
        public int id2 { get; set; }
        public string name { get; set; }
        public decimal fee { get; set; }
        public int needsRoom { get; set; }
        public string date { get; set; }
        public int status { get; set; }
    }
}