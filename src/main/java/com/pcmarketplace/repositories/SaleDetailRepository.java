package com.pcmarketplace.repositories;

import com.pcmarketplace.models.SaleDetail;

import java.util.List;

public interface SaleDetailRepository {

    void create(SaleDetail saleDetail);

    List<SaleDetail> listAll();

    SaleDetail searchById(int id);

    void update(SaleDetail saleDetail);

    void delete(int id);
}
