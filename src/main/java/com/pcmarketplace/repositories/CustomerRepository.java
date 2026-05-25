package com.pcmarketplace.repositories;

import com.pcmarketplace.models.Customer;

import java.util.List;

public interface CustomerRepository {

    void create(Customer customer);

    List<Customer> listAll();

    Customer searchById(int id);

    void update(Customer customer);

    void delete(int id);
}
