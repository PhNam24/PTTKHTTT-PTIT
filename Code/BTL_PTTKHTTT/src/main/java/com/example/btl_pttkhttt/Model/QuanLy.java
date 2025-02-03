package com.example.btl_pttkhttt.Model;

public class QuanLy extends NhanVien {
    private String role;

    public QuanLy() {
        super();
        this.role = "Quản lý";
    }

    public QuanLy(NhanVien nhanVien) {
        super(nhanVien.getId(), nhanVien.getName(), nhanVien.getUsername(), nhanVien.getPassword(), nhanVien.getBirth(), nhanVien.getPhone(), nhanVien.getEmail());
        this.role = "Quản lý";
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "QuanLy{" +
                "id=" + getId() +
                ", name='" + getName() + '\'' +
                ", username='" + getUsername() + '\'' +
                ", password='" + getPassword() + '\'' +
                ", birth=" + getBirth() +
                ", phone='" + getPhone() + '\'' +
                ", email='" + getEmail() + '\'' +
                ",role='" + role + '\'' +
                '}';
    }
}
