package com.pcmarketplace.models;

public class Product extends BaseEntity {

    private String name;
    private String description;
    private double price;
    private String category;

    public Product() {}

    public Product(int id, String name, String description, double price, String category) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
    }

    public int getIdProduct() { return id; }
    public void setIdProduct(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    @Override
    public String toString() {
        return "Producto{id=" + id + ", nombre=" + name +
                ", precio=" + price + ", categoria=" + category + "}";
    }
}