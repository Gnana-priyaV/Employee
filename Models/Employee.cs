using System;

namespace EmployeeMgmt.Models
{
    public class Employee
    {
        public int EmpId { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Department { get; set; }
        public decimal Salary { get; set; }
        public DateTime JoinDate { get; set; }
    }
}