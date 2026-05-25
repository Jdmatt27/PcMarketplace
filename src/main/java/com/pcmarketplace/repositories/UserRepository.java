package com.pcmarketplace.repositories;

import com.pcmarketplace.models.User;

import java.util.List;

public interface UserRepository {

    void create(User user);

    List<User> listAll();

    User searchById(int id);

    void update(User user);

    void delete(int id);
}
