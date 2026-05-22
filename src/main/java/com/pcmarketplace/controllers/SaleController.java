package com.pcmarketplace.controllers;

import com.pcmarketplace.models.Sale;
import com.pcmarketplace.services.SaleService;

import java.time.LocalDate;
import java.util.List;
import java.util.Scanner;

public class SaleController {

    private SaleService saleService = new SaleService();
    private Scanner scanner = new Scanner(System.in);

    public void menu() {
        int option;
        do {
            System.out.println("\n--- MENU VENTAS ---");
            System.out.println("1. Crear venta");
            System.out.println("2. Listar ventas");
            System.out.println("3. Buscar venta por ID");
            System.out.println("4. Actualizar venta");
            System.out.println("5. Eliminar venta");
            System.out.println("0. Volver al menu principal");
            option = readLetter("Selecciona una opcion: ");

            switch (option) {
                case 1 -> create();
                case 2 -> list();
                case 3 -> search();
                case 4 -> update();
                case 5 -> delete();
                case 0 -> System.out.println("Volviendo al menu principal...");
                default -> System.out.println("Opcion no valida.");
            }
        } while (option != 0);
    }

    private void create() {
        int idCustomer = readLetter("ID del cliente: ");
        int idUser = readLetter("ID del usuario: ");
        LocalDate date = readDate("Fecha (YYYY-MM-DD): ");
        System.out.print("Estado (PENDIENTE/PAGADA/CANCELADA): ");
        String state = scanner.nextLine();
        double total = readNumber("Total: ");

        Sale sale = new Sale(0, idCustomer, idUser, date, state, total);
        saleService.createSale(sale);
    }

    private void list() {
        List<Sale> list = saleService.listSales();
        if (list.isEmpty()) {
            System.out.println("No hay ventas registradas.");
        } else {
            list.forEach(System.out::println);
        }
    }

    private void search() {
        int id = readLetter("ID de la venta: ");
        Sale sale = saleService.searchSale(id);
        if (sale != null) {
            System.out.println(sale);
        }
    }

    private void update() {
        int id = readLetter("ID de la venta a actualizar: ");
        int idCustomer = readLetter("Nuevo ID del cliente: ");
        int idUser = readLetter("Nuevo ID del usuario: ");
        LocalDate date = readDate("Nueva fecha (YYYY-MM-DD): ");
        System.out.print("Nuevo estado: ");
        String state = scanner.nextLine();
        double total = readNumber("Nuevo total: ");

        Sale sale = new Sale(id, idCustomer, idUser, date, state, total);
        saleService.updateSale(sale);
    }

    private void delete() {
        int id = readLetter("ID de la venta a eliminar: ");
        saleService.deleteSale(id);
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

    private LocalDate readDate(String message) {
        while (true) {
            System.out.print(message);
            try {
                return LocalDate.parse(scanner.nextLine());
            } catch (Exception e) {
                System.out.println("Formato de fecha no valido. Usa el formato YYYY-MM-DD.");
            }
        }
    }
}