package com.pcmarketplace.models;

public class Customer extends BaseEntity {

    private String name;
    private String email;
    private String phone;
    private String direction;

    public Customer() {}

    public Customer(int id, String name, String email, String phone, String direction) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.direction = direction;
    }

    public int getIdCustomer() { return id; }
    public void setIdCustomer(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDirection() { return direction; }
    public void setDirection(String direction) { this.direction = direction; }

    @Override
    public String toString() {
        return "Cliente{id=" + id + ", nombre=" + name +
                ", email=" + email + ", telefono=" + phone +
                ", direccion=" + direction + "}";
    }
}