package com.pcmarketplace.repositories;

import com.pcmarketplace.models.Product;
import com.pcmarketplace.util.DataBaseConection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductRepositoryIMPL implements ProductRepository {

    @Override
    public void create(Product product) {
        String sql = "INSERT INTO productos (nombre, descripcion, precio, categoria) VALUES (?, ?, ?, ?)";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setString(4, product.getCategory());
            ps.executeUpdate();
            System.out.println("Producto creado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al crear producto: " + e.getMessage());
        }
    }

    @Override
    public List<Product> listAll() {
        List<Product> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos";
        try (Connection con = DataBaseConection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id_producto"),
                        rs.getString("nombre"),
                        rs.getString("descripcion"),
                        rs.getDouble("precio"),
                        rs.getString("categoria")
                );
                lista.add(p);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar productos: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public Product searchById(int id) {
        String sql = "SELECT * FROM productos WHERE id_producto = ?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt("id_producto"),
                        rs.getString("nombre"),
                        rs.getString("descripcion"),
                        rs.getDouble("precio"),
                        rs.getString("categoria")
                );
            }

        } catch (SQLException e) {
            System.out.println("Error al buscar producto: " + e.getMessage());
        }
        return null;
    }

    @Override
    public void update(Product product) {
        String sql = "UPDATE productos SET nombre=?, descripcion=?, precio=?, categoria=? WHERE id_producto=?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setString(4, product.getCategory());
            ps.setInt(5, product.getIdProduct());
            ps.executeUpdate();
            System.out.println("Producto actualizado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al actualizar producto: " + e.getMessage());
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM productos WHERE id_producto = ?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Producto eliminado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al eliminar producto: " + e.getMessage());
        }
    }
}