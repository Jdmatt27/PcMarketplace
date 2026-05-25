package com.pcmarketplace.repositories;

import com.pcmarketplace.models.Sale;
import com.pcmarketplace.util.DataBaseConection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SaleRepositoryIMPL implements SaleRepository {

    @Override
    public void create(Sale sale) {
        String sql = "INSERT INTO ventas (id_cliente, id_usuario, fecha, estado, total) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, sale.getIdCustomer());
            ps.setInt(2, sale.getIdUser());
            ps.setDate(3, Date.valueOf(sale.getDate()));
            ps.setString(4, sale.getState());
            ps.setDouble(5, sale.getTotal());
            ps.execute();
            System.out.println("Venta creada correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al crear venta: " + e.getMessage());
        }
    }

    @Override
    public List<Sale> listAll() {
        List<Sale> lista = new ArrayList<>();
        String sql = "SELECT * FROM ventas";
        try (Connection con = DataBaseConection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Sale s = new Sale(
                        rs.getInt("id_venta"),
                        rs.getInt("id_cliente"),
                        rs.getInt("id_usuario"),
                        rs.getDate("fecha").toLocalDate(),
                        rs.getString("estado"),
                        rs.getDouble("total")
                );
                lista.add(s);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar ventas: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public Sale searchById(int id) {
        String sql = "SELECT * FROM ventas WHERE id_venta = ?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Sale(
                        rs.getInt("id_venta"),
                        rs.getInt("id_cliente"),
                        rs.getInt("id_usuario"),
                        rs.getDate("fecha").toLocalDate(),
                        rs.getString("estado"),
                        rs.getDouble("total")
                );
            }

        } catch (SQLException e) {
            System.out.println("Error al buscar venta: " + e.getMessage());
        }
        return null;
    }

    @Override
    public void update(Sale sale) {
        String sql = "UPDATE ventas SET id_cliente=?, id_usuario=?, fecha=?, estado=?, total=? WHERE id_venta=?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, sale.getIdCustomer());
            ps.setInt(2, sale.getIdUser());
            ps.setDate(3, Date.valueOf(sale.getDate()));
            ps.setString(4, sale.getState());
            ps.setDouble(5, sale.getTotal());
            ps.setInt(6, sale.getIdSale());
            ps.executeUpdate();
            System.out.println("Venta actualizada correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al actualizar venta: " + e.getMessage());
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM ventas WHERE id_venta = ?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Venta eliminada correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al eliminar venta: " + e.getMessage());
        }
    }
}