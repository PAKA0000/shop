package dto;

public class Customer {
    private int customerCode;
    private String customerId;
    private String customerPw;
    private String customerName;
    private int customerPhone;
    private int point;
    private String createdate;

    public int getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(int customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getCustomerPw() {
        return customerPw;
    }

    public void setCustomerPw(String customerPw) {
        this.customerPw = customerPw;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public int getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(int customerPhone) {
        this.customerPhone = customerPhone;
    }

    public int getPoint() {   
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public String getCreatedate() {
        return createdate;
    }

    public void setCreatedate(String createdate) {
        this.createdate = createdate;
    }

    @Override
    public String toString() {
        return "Customer [customerCode=" + customerCode + ", customerId=" + customerId 
                + ", customerPw=" + customerPw + ", customerName=" + customerName 
                + ", customerPhone=" + customerPhone + ", point=" + point 
                + ", createdate=" + createdate + "]";
    }
}
