package com.pcmarketplace.models;

public class SaleDetail extends BaseEntity {

    private int idSale;
    private int idProduct;
    private int amount;
    private double unitPrice;

    public SaleDetail() {}

    public SaleDetail(int id, int idSale, int idProduct, int amount, double unitPrice) {
        this.id = id;
        this.idSale = idSale;
        this.idProduct = idProduct;
        this.amount = amount;
        this.unitPrice = unitPrice;
    }

    public int getIdDetail() { return id; }
    public void setIdDetail(int id) { this.id = id; }

    public int getIdSale() { return idSale; }
    public void setIdSale(int idSale) { this.idSale = idSale; }

    public int getIdProduct() { return idProduct; }
    public void setIdProduct(int idProduct) { this.idProduct = idProduct; }

    public int getAmount() { return amount; }
    public void setAmount(int amount) { this.amount = amount; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    @Override
    public String toString() {
        return "DetalleVenta{id=" + id + ", idVenta=" + idSale +
                ", idProducto=" + idProduct + ", cantidad=" + amount +
                ", precioUnitario=" + unitPrice + "}";
    }
}