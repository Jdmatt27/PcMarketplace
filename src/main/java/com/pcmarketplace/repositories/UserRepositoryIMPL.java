package com.pcmarketplace.repositories;

import com.pcmarketplace.models.User;
import com.pcmarketplace.util.DataBaseConection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserRepositoryIMPL implements UserRepository {

    @Override
    public void create(User user) {
        String sql = "INSERT INTO usuarios (nombre, email, rol, password_hash) VALUES (?, ?, ?, ?)";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getRol());
            ps.setString(4, user.getPasswordHash());
            ps.executeUpdate();
            System.out.println("Usuario creado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al crear usuario: " + e.getMessage());
        }
    }

    @Override
    public List<User> listAll() {
        List<User> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";
        try (Connection con = DataBaseConection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                User u = new User(
                        rs.getInt("id_usuario"),
                        rs.getString("nombre"),
                        rs.getString("email"),
                        rs.getString("rol"),
                        rs.getString("password_hash")
                );
                lista.add(u);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar usuarios: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public User searchById(int id) {
        String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("id_usuario"),
                        rs.getString("nombre"),
                        rs.getString("email"),
                        rs.getString("rol"),
                        rs.getString("password_hash")
                );
            }

        } catch (SQLException e) {
            System.out.println("Error al buscar usuario: " + e.getMessage());
        }
        return null;
    }

    @Override
    public void update(User user) {
        String sql = "UPDATE usuarios SET nombre=?, email=?, rol=?, password_hash=? WHERE id_usuario=?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getRol());
            ps.setString(4, user.getPasswordHash());
            ps.setInt(5, user.getIdUser());
            ps.executeUpdate();
            System.out.println("Usuario actualizado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al actualizar usuario: " + e.getMessage());
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Usuario eliminado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al eliminar usuario: " + e.getMessage());
        }
    }
}