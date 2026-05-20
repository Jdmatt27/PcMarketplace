package com.pcmarketplace.services;

import com.pcmarketplace.models.User;
import com.pcmarketplace.repositories.UserRepositoryIMPL;

import java.util.List;

public class UserService {

    private UserRepositoryIMPL userRepository = new UserRepositoryIMPL();

    public void createUser(User user) {
        if (user.getName() == null || user.getName().isEmpty()) {
            System.out.println("Error: el nombre del usuario no puede estar vacio.");
            return;
        }
        if (user.getRol() == null || user.getRol().isEmpty()) {
            System.out.println("Error: el rol del usuario no puede estar vacio.");
            return;
        }
        userRepository.create(user);
    }

    public List<User> listUsers() {
        return userRepository.listAll();
    }

    public User searchUser(int id) {
        User user = userRepository.searchById(id);
        if (user == null) {
            System.out.println("No se encontro ningun usuario con id: " + id);
        }
        return user;
    }

    public void updateUser(User user) {
        if (userRepository.searchById(user.getIdUser()) == null) {
            System.out.println("No se puede actualizar. Usuario con id " + user.getIdUser() + " no existe.");
            return;
        }
        userRepository.update(user);
    }

    public void deleteUser(int id) {
        if (userRepository.searchById(id) == null) {
            System.out.println("No se puede eliminar. Usuario con id " + id + " no existe.");
            return;
        }
        userRepository.delete(id);
    }
}