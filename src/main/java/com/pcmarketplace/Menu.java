package com.pcmarketplace;

import com.pcmarketplace.controllers.*;

import java.util.Scanner;

public class Menu {

    public void start() {
        Scanner scanner = new Scanner(System.in);
        CustomerController customerController = new CustomerController();
        UserController userController = new UserController();
        ProductController productController = new ProductController();
        SaleController saleController = new SaleController();
        SaleDetailController saleDetailController = new SaleDetailController();

        int opcion;
        do {
            System.out.println("\n=============================");
            System.out.println("           MENU PRINCIPAL    ");
            System.out.println("=============================");
            System.out.println("1. Clientes");
            System.out.println("2. Usuarios");
            System.out.println("3. Productos");
            System.out.println("4. Ventas");
            System.out.println("5. Detalles de venta");
            System.out.println("0. Salir");
            System.out.println("=============================");
            System.out.print("Selecciona una opcion: ");

            try {
                opcion = Integer.parseInt(scanner.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Entrada no valida. Introduce un numero.");
                opcion = -1;
            }

            switch (opcion) {
                case 1 -> customerController.menu();
                case 2 -> userController.menu();
                case 3 -> productController.menu();
                case 4 -> saleController.menu();
                case 5 -> saleDetailController.menu();
                case 0 -> System.out.println("Saliendo del sistema CRM...");
                default -> System.out.println("Opcion no valida.");
            }
        } while (opcion != 0);

        scanner.close();
    }
}