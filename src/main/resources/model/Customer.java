package model;

public class Customer extends User{
    private String phoneNumber;
    private String address;

    public Customer() {}

    public Customer(String username, String password, String name,  String role, String phoneNumber, String address) {
        super(username, password, name, role);
        this.phoneNumber = phoneNumber;
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
