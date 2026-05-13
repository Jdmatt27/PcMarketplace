package com.pcmarketplace.repositories;

import com.pcmarketplace.models.Customer;
import com.pcmarketplace.util.DataBaseConection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerRepositoryIMPL implements CustomerRepository {

    @Override
    public void create(Customer customer) {
        String sql = "INSERT INTO clientes (nombre, email, telefono, direccion) VALUES (?, ?, ?, ?)";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPhone());
            ps.setString(4, customer.getDirection());
            ps.execute();
            System.out.println("Cliente creado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al crear cliente: " + e.getMessage());
        }
    }

    @Override
    public List<Customer> listAll() {
        List<Customer> lista = new ArrayList<>();
        String sql = "SELECT * FROM clientes";
        try (Connection con = DataBaseConection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Customer c = new Customer(
                        rs.getInt("id_cliente"),
                        rs.getString("nombre"),
                        rs.getString("email"),
                        rs.getString("telefono"),
                        rs.getString("direccion")
                );
                lista.add(c);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar cliente: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public Customer searchById(int id) {
        String sql = "SELECT * FROM clientes WHERE id_cliente = ?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("id_cliente"),
                        rs.getString("nombre"),
                        rs.getString("email"),
                        rs.getString("telefono"),
                        rs.getString("direccion")
                );
            }

        } catch (SQLException e) {
            System.out.println("Error al buscar cliente: " + e.getMessage());
        }
        return null;
    }

    @Override
    public void update(Customer customer) {
        String sql = "UPDATE clientes SET nombre=?, email=?, telefono=?, direccion=? WHERE id_cliente=?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPhone());
            ps.setString(4, customer.getDirection());
            ps.setInt(5, customer.getIdCustomer());
            ps.executeUpdate();
            System.out.println("Cliente actualizado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al actualizar cliente: " + e.getMessage());
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM clientes WHERE id_cliente = ?";

        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            int filas = ps.executeUpdate();

            if (filas > 0) {
                System.out.println("Cliente eliminado correctamente.");
            } else {
                System.out.println("No se encontró ningún cliente con ID: " + id);
            }

        } catch (SQLException e) {
            System.out.println("Error al eliminar cliente: " + e.getMessage());
        }
    }
}