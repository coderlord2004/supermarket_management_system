package model;

public class WarehouseStaff extends Staff{

    public WarehouseStaff() {}

    public WarehouseStaff(String position) {
        super(position);
    }

    public WarehouseStaff(String username, String password, String name, String role, String position) {
        super(username, password, name, role, position);
    }
}
