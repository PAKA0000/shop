package dto;

public class Emp {
	private String empCode;
	private String empId;
	private String pw;
	private String empName;
	private String active;
	private String createdate;
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "Emp [empCode=" + empCode + ", empId=" + empId + ", pw=" + pw + ", empName=" + empName + ", active="
				+ active + ", createdate=" + createdate + "]";
	}
	
}
