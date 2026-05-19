package com.pcmarketplace.services;

import com.pcmarketplace.models.Customer;
import com.pcmarketplace.repositories.CustomerRepositoryIMPL;

import java.util.List;

public class CustomerService {

    private CustomerRepositoryIMPL CustomerRepository = new CustomerRepositoryIMPL();

    public void createCustomer(Customer customer) {
        if (customer.getName() == null || customer.getName().isEmpty()) {
            System.out.println("Error: el nombre del Cliente no puede estar vacio.");
            return;
        }
        if (customer.getEmail() == null || customer.getEmail().isEmpty()) {
            System.out.println("Error: el email del Cliente no puede estar vacio.");
            return;
        }
        CustomerRepository.create(customer);
    }

    public List<Customer> listCustomers() {
        return CustomerRepository.listAll();
    }

    public Customer searchCustomer(int id) {
        Customer customer = CustomerRepository.searchById(id);
        if (customer == null) {
            System.out.println("No se encontro ningun Cliente con id: " + id);
        }
        return customer;
    }

    public void updateCustomer(Customer customer) {
        if (CustomerRepository.searchById(customer.getIdCustomer()) == null) {
            System.out.println("No se puede actualizar. Cliente con id " + customer.getIdCustomer() + " no existe.");
            return;
        }
        CustomerRepository.update(customer);
    }

    public void deleteCustomer(int id) {
        if (CustomerRepository.searchById(id) == null) {
            System.out.println("No se puede eliminar. Cliente con id " + id + " no existe.");
            return;
        }
        CustomerRepository.delete(id);
    }
}