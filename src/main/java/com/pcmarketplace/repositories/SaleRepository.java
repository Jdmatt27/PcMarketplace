package com.pcmarketplace.repositories;

import com.pcmarketplace.models.Sale;

import java.util.List;

public interface SaleRepository {

    void create(Sale sale);

    List<Sale> listAll();

    Sale searchById(int id);

    void update(Sale sale);

    void delete(int id);
}
