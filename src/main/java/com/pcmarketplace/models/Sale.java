package com.pcmarketplace.models;

import java.time.LocalDate;

public class Sale extends BaseEntity {

    private int idCustomer;
    private int idUser;
    private LocalDate date;
    private String state;
    private double total;

    public Sale() {}

    public Sale(int id, int idCustomer, int idUser, LocalDate date, String state, double total) {
        this.id = id;
        this.idCustomer = idCustomer;
        this.idUser = idUser;
        this.date = date;
        this.state = state;
        this.total = total;
    }

    public int getIdSale() { return id; }
    public void setIdSale(int id) { this.id = id; }

    public int getIdCustomer() { return idCustomer; }
    public void setIdCustomer(int idCustomer) { this.idCustomer = idCustomer; }

    public int getIdUser() { return idUser; }
    public void setIdUser(int idUser) { this.idUser = idUser; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    @Override
    public String toString() {
        return "Venta{id=" + id + ", idCliente=" + idCustomer +
                ", idUsuario=" + idUser + ", fecha=" + date +
                ", estado=" + state + ", total=" + total + "}";
    }
}