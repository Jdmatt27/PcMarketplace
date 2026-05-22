package com.pcmarketplace.controllers;

import com.pcmarketplace.models.User;
import com.pcmarketplace.services.UserService;

import java.util.List;
import java.util.Scanner;

public class UserController {

    private UserService userService = new UserService();
    private Scanner scanner = new Scanner(System.in);

    public void menu() {
        int option;
        do {
            System.out.println("\n--- MENU USUARIOS ---");
            System.out.println("1. Crear usuario");
            System.out.println("2. Listar usuarios");
            System.out.println("3. Buscar usuario por ID");
            System.out.println("4. Actualizar usuario");
            System.out.println("5. Eliminar usuario");
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
        System.out.print("Email: ");
        String email = scanner.nextLine();
        System.out.print("Rol: ");
        String rol = scanner.nextLine();
        System.out.print("Password: ");
        String password = scanner.nextLine();

        User user = new User(0, name, email, rol, password);
        userService.createUser(user);
    }

    private void list() {
        List<User> list = userService.listUsers();
        if (list.isEmpty()) {
            System.out.println("No hay usuarios registrados.");
        } else {
            list.forEach(System.out::println);
        }
    }

    private void search() {
        int id = readLetter("ID del usuario: ");
        User user = userService.searchUser(id);
        if (user != null) {
            System.out.println(user);
        }
    }

    private void update() {
        int id = readLetter("ID del usuario a actualizar: ");
        System.out.print("Nuevo nombre: ");
        String name = scanner.nextLine();
        System.out.print("Nuevo email: ");
        String email = scanner.nextLine();
        System.out.print("Nuevo rol: ");
        String rol = scanner.nextLine();
        System.out.print("Nueva password: ");
        String password = scanner.nextLine();

        User user = new User(id, name, email, rol, password);
        userService.updateUser(user);
    }

    private void delete() {
        int id = readLetter("ID del usuario a eliminar: ");
        userService.deleteUser(id);
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