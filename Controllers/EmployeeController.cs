using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Mvc;
using EmployeeMgmt.Models;

namespace EmployeeMgmt.Controllers
{
    public class EmployeeController : Controller
    {
        string cs = ConfigurationManager.ConnectionStrings["EmpDB"].ConnectionString;

        public ActionResult Index()
        {
            return View();
        }

        public JsonResult GetAll()
        {
            var list = new List<Employee>();
            using (var con = new SqlConnection(cs))
            using (var cmd = new SqlCommand("sp_Emp_GetAll", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read()) list.Add(Map(r));
                }
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetById(int id)
        {
            using (var con = new SqlConnection(cs))
            using (var cmd = new SqlCommand("sp_Emp_GetById", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpId", id);
                con.Open();
                using (var r = cmd.ExecuteReader())
                {
                    if (r.Read()) return Json(Map(r), JsonRequestBehavior.AllowGet);
                }
            }
            return Json(null, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Save(Employee e)
        {
            if (string.IsNullOrWhiteSpace(e.FullName) || string.IsNullOrWhiteSpace(e.Email))
                return Json(new { success = false, message = "Name and Email required" });

            using (var con = new SqlConnection(cs))
            using (var cmd = new SqlCommand(e.EmpId == 0 ? "sp_Emp_Insert" : "sp_Emp_Update", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                if (e.EmpId != 0) cmd.Parameters.AddWithValue("@EmpId", e.EmpId);
                cmd.Parameters.AddWithValue("@FullName", e.FullName);
                cmd.Parameters.AddWithValue("@Email", e.Email);
                cmd.Parameters.AddWithValue("@Phone", (object)e.Phone ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Department", (object)e.Department ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Salary", e.Salary);
                cmd.Parameters.AddWithValue("@JoinDate", e.JoinDate);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            return Json(new { success = true });
        }

        [HttpPost]
        public JsonResult Delete(int id)
        {
            using (var con = new SqlConnection(cs))
            using (var cmd = new SqlCommand("sp_Emp_Delete", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpId", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            return Json(new { success = true });
        }

        private Employee Map(SqlDataReader r)
        {
            return new Employee
            {
                EmpId = (int)r["EmpId"],
                FullName = r["FullName"].ToString(),
                Email = r["Email"].ToString(),
                Phone = r["Phone"].ToString(),
                Department = r["Department"].ToString(),
                Salary = r["Salary"] == DBNull.Value ? 0 : (decimal)r["Salary"],
                JoinDate = r["JoinDate"] == DBNull.Value ? DateTime.MinValue : (DateTime)r["JoinDate"]
            };
        }
    }
}