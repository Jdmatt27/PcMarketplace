package com.pcmarketplace.controllers;

import com.pcmarketplace.models.SaleDetail;
import com.pcmarketplace.services.SaleDetailService;

import java.util.List;
import java.util.Scanner;

public class SaleDetailController {

    private SaleDetailService saleDetailService = new SaleDetailService();
    private Scanner scanner = new Scanner(System.in);

    public void menu() {
        int option;
        do {
            System.out.println("\n--- MENU DETALLE DE VENTA ---");
            System.out.println("1. Crear detalle de venta");
            System.out.println("2. Listar detalles de venta");
            System.out.println("3. Buscar detalle por ID");
            System.out.println("4. Actualizar detalle de venta");
            System.out.println("5. Eliminar detalle de venta");
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
        int idSale = readLetter("ID de la venta: ");
        int idProduct = readLetter("ID del producto: ");
        int amount = readLetter("Cantidad: ");
        double unitPrice = readNumber("Precio unitario: ");

        SaleDetail saleDetail = new SaleDetail(0, idSale, idProduct, amount, unitPrice);
        saleDetailService.createSaleDetail(saleDetail);
    }

    private void list() {
        List<SaleDetail> list = saleDetailService.listSaleDetails();
        if (list.isEmpty()) {
            System.out.println("No hay detalles de venta registrados.");
        } else {
            list.forEach(System.out::println);
        }
    }

    private void search() {
        int id = readLetter("ID del detalle: ");
        SaleDetail saleDetail = saleDetailService.searchSaleDetail(id);
        if (saleDetail != null) {
            System.out.println(saleDetail);
        }
    }

    private void update() {
        int id = readLetter("ID del detalle a actualizar: ");
        int idSale = readLetter("Nuevo ID de la venta: ");
        int idProduct = readLetter("Nuevo ID del producto: ");
        int amount = readLetter("Nueva cantidad: ");
        double unitPrice = readNumber("Nuevo precio unitario: ");

        SaleDetail saleDetail = new SaleDetail(id, idSale, idProduct, amount, unitPrice);
        saleDetailService.updateSaleDetail(saleDetail);
    }

    private void delete() {
        int id = readLetter("ID del detalle a eliminar: ");
        saleDetailService.deleteSaleDetail(id);
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