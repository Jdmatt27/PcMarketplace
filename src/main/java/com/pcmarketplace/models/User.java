package com.pcmarketplace.models;

public class User extends BaseEntity {

    private String name;
    private String email;
    private String rol;
    private String passwordHash;

    public User() {}

    public User(int id, String name, String email, String rol, String passwordHash) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.rol = rol;
        this.passwordHash = passwordHash;
    }

    public int getIdUser() { return id; }
    public void setIdUser(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    @Override
    public String toString() {
        return "Usuario{id=" + id + ", nombre=" + name +
                ", email=" + email + ", rol=" + rol + "}";
    }
}