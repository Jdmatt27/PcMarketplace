package com.pcmarketplace.repositories;

import com.pcmarketplace.models.SaleDetail;
import com.pcmarketplace.util.DataBaseConection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SaleDetailRepositoryIMPL implements SaleDetailRepository {

    @Override
    public void create(SaleDetail saleDetail) {
        String sql = "INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario) VALUES (?, ?, ?, ?)";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, saleDetail.getIdSale());
            ps.setInt(2, saleDetail.getIdProduct());
            ps.setInt(3, saleDetail.getAmount());
            ps.setDouble(4, saleDetail.getUnitPrice());
            ps.execute();
            System.out.println("Detalle de venta creado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al crear detalle de venta: " + e.getMessage());
        }
    }

    @Override
    public List<SaleDetail> listAll() {
        List<SaleDetail> lista = new ArrayList<>();
        String sql = "SELECT * FROM detalle_venta";
        try (Connection con = DataBaseConection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                SaleDetail sd = new SaleDetail(
                        rs.getInt("id_detalle"),
                        rs.getInt("id_venta"),
                        rs.getInt("id_producto"),
                        rs.getInt("cantidad"),
                rs.getDouble("precio_unitario")
            );
                lista.add(sd);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar detalle de venta: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public SaleDetail searchById(int id) {
        String sql = "SELECT * FROM detalle_venta WHERE id_detalle = ?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new SaleDetail(
                        rs.getInt("id_detalle"),
                        rs.getInt("id_venta"),
                        rs.getInt("id_producto"),
                        rs.getInt("cantidad"),
                        rs.getDouble("precio_unitario")
                );
            }

        } catch (SQLException e) {
            System.out.println("Error al buscar detalle de venta: " + e.getMessage());
        }
        return null;
    }

    @Override
    public void update(SaleDetail saleDetail) {
        String sql = "UPDATE detalle_venta SET id_venta=?, id_producto=?, cantidad=?, precio_unitario=? WHERE id_detalle=?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, saleDetail.getIdSale());
            ps.setInt(2, saleDetail.getIdProduct());
            ps.setInt(3, saleDetail.getAmount());
            ps.setDouble(4, saleDetail.getUnitPrice());
            ps.setInt(5, saleDetail.getIdDetail());
            ps.executeUpdate();
            System.out.println("Detalle de venta actualizado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al actualizar detalle de venta: " + e.getMessage());
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM detalle_venta WHERE id_detalle = ?";
        try (Connection con = DataBaseConection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Detalle de venta eliminado correctamente.");

        } catch (SQLException e) {
            System.out.println("Error al eliminar detalle de venta: " + e.getMessage());
        }
    }
}