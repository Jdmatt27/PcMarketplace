package com.pcmarketplace.models;

public abstract class BaseEntity {

    protected int id;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    @Override
    public String toString() {
        return "BaseEntity{id=" + id + "}";
    }
}
