package com.pcmarketplace.controllers;

import com.pcmarketplace.models.Customer;
import com.pcmarketplace.services.CustomerService;
import com.pcmarketplace.util.ExportUtil;

import java.util.List;
import java.util.Scanner;

public class CustomerController {

    private CustomerService customerService = new CustomerService();
    private Scanner scanner = new Scanner(System.in);

    public void menu() {
        int option;
        do {
            System.out.println("\n--- MENU CLIENTES ---");
            System.out.println("1. Crear cliente");
            System.out.println("2. Listar clientes");
            System.out.println("3. Buscar cliente por ID");
            System.out.println("4. Actualizar cliente");
            System.out.println("5. Eliminar cliente");
            System.out.println("6. Exportar clientes a CSV");
            System.out.println("0. Volver al menu principal");
            System.out.print("Selecciona una opcion: ");
            option = readLetter("");

            switch (option) {
                case 1 -> create();
                case 2 -> list();
                case 3 -> search();
                case 4 -> update();
                case 5 -> delete();
                case 6 -> export();
                case 0 -> System.out.println("Volviendo al menu principal...");
                default -> System.out.println("Opcion no valida.");
            }
        } while (option != 0);
    }

    private void create() {
        System.out.print("Nombre: ");
        String name = scanner.nextLine();
        System.out.print("Email: ");
        String email = scanner.nextLine();
        System.out.print("Telefono: ");
        String phone = scanner.nextLine();
        System.out.print("Direccion: ");
        String direction = scanner.nextLine();

        Customer customer = new Customer(0, name, email, phone, direction);
        customerService.createCustomer(customer);
    }

    private void list() {
        List<Customer> list = customerService.listCustomers();
        if (list.isEmpty()) {
            System.out.println("No hay clientes registrados.");
        } else {
            list.forEach(System.out::println);
        }
    }

    private void search() {
        int id = readLetter("ID del cliente: ");
        Customer customer = customerService.searchCustomer(id);
        if (customer != null) {
            System.out.println(customer);
        }
    }

    private void update() {
        int id = readLetter("ID del cliente a actualizar: ");
        System.out.print("Nuevo nombre: ");
        String name = scanner.nextLine();
        System.out.print("Nuevo email: ");
        String email = scanner.nextLine();
        System.out.print("Nuevo telefono: ");
        String phone = scanner.nextLine();
        System.out.print("Nueva direccion: ");
        String direction = scanner.nextLine();

        Customer customer = new Customer(id, name, email, phone, direction);
        customerService.updateCustomer(customer);
    }

    private void delete() {
        int id = readLetter("ID del cliente a eliminar: ");
        customerService.deleteCustomer(id);
    }

    private void export() {
        List<Customer> list = customerService.listCustomers();
        if (list.isEmpty()) {
            System.out.println("No hay clientes para exportar.");
            return;
        }
        System.out.println("Introduce la ruta del archivo: ");
        String filePath = scanner.nextLine();
        ExportUtil.exportCustomerToCSV(list, filePath);
    }

    private int readLetter(String message) {
        while (true) {
            System.out.print(message);
            try {
                return Integer.parseInt(scanner.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Entrada no valida. Introduce un numero entero.");
            }
        }
    }

    private double readNumber(String message) {
        while (true) {
            System.out.print(message);
            try {
                return Double.parseDouble(scanner.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Entrada no valida. Introduce un numero decimal.");
            }
        }
    }

}