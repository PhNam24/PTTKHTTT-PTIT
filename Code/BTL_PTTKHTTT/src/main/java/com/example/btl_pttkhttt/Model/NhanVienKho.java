package com.example.btl_pttkhttt.Model;

public class NhanVienKho extends NhanVien {
    private String role;

    public NhanVienKho() {
        super();
        this.role = "Nhân viên kho";
    }

    public NhanVienKho(NhanVien nhanVien) {
        super(nhanVien.getId(), nhanVien.getName(), nhanVien.getUsername(), nhanVien.getPassword(), nhanVien.getBirth(), nhanVien.getPhone(), nhanVien.getEmail());
        this.role = "Nhân viên kho";
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "NhanVienKho{" +
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
