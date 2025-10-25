package model;

public class Staff extends User{
    private int staffId;
    private String position;

    public Staff() {}

    public Staff(String position) {
        this.position = position;
    }

    public Staff(String username, String password, String name, String role, String position) {
        super(username, password, name, role);
        this.position = position;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
