package com.pcmarketplace.controllers;

import com.pcmarketplace.models.Product;
import com.pcmarketplace.services.ProductService;

import java.util.List;
import java.util.Scanner;

public class ProductController {

    private ProductService productService = new ProductService();
    private Scanner scanner = new Scanner(System.in);

    public void menu() {
        int option;
        do {
            System.out.println("\n--- MENU PRODUCTOS ---");
            System.out.println("1. Crear producto");
            System.out.println("2. Listar productos");
            System.out.println("3. Buscar producto por ID");
            System.out.println("4. Actualizar producto");
            System.out.println("5. Eliminar producto");
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
        System.out.print("Nombre: ");
        String name = scanner.nextLine();
        System.out.print("Descripcion: ");
        String description = scanner.nextLine();
        double price = readNumber("Precio: ");
        System.out.print("Categoria: ");
        String category = scanner.nextLine();

        Product product = new Product(0, name, description, price, category);
        productService.createProduct(product);
    }

    private void list() {
        List<Product> list = productService.listProducts();
        if (list.isEmpty()) {
            System.out.println("No hay productos registrados.");
        } else {
            list.forEach(System.out::println);
        }
    }

    private void search() {
        int id = readLetter("ID del producto: ");
        Product product = productService.searchProduct(id);
        if (product != null) {
            System.out.println(product);
        }
    }

    private void update() {
        int id = readLetter("ID del producto a actualizar: ");
        System.out.print("Nuevo nombre: ");
        String name = scanner.nextLine();
        System.out.print("Nueva descripcion: ");
        String description = scanner.nextLine();
        double price = readNumber("Nuevo precio: ");
        System.out.print("Nueva categoria: ");
        String category = scanner.nextLine();

        Product product = new Product(id, name, description, price, category);
        productService.updateProduct(product);
    }

    private void delete() {
        int id = readLetter("ID del producto a eliminar: ");
        productService.deleteProduct(id);
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