package com.pcmarketplace.repositories;

import com.pcmarketplace.models.Product;

import java.util.List;

public interface ProductRepository {

    void create(Product product);

    List<Product> listAll();

    Product searchById(int id);

    void update(Product product);

    void delete(int id);
}

