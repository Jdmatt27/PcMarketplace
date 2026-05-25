package com.pcmarketplace.util;

import com.pcmarketplace.models.Customer;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class ExportUtil {
    public static void exportCustomerToCSV(List<Customer> customers, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            writer.write("ID,Nombre,Email,Telefono,Direccion");
            writer.newLine();

            for (Customer c : customers) {
                writer.write(
                        c.getIdCustomer() + "," +
                                c.getName() + "," +
                                c.getEmail() + "," +
                                c.getPhone() + "," +
                                c.getDirection()
                );
                writer.newLine();
            }

        } catch (IOException e) {
            System.out.println("Error al exportar el archivo: " + e.getMessage());
        }
    }
}
