package com.pcmarketplace.services;

import com.pcmarketplace.models.Sale;
import com.pcmarketplace.repositories.SaleRepositoryIMPL;

import java.util.List;

public class SaleService {

    private SaleRepositoryIMPL saleRepository = new SaleRepositoryIMPL();

    public void createSale(Sale sale) {
        if (sale.getState() == null || sale.getState().isEmpty()) {
            System.out.println("Error: el estado de la venta no puede estar vacio.");
            return;
        }
        if (sale.getTotal() < 0) {
            System.out.println("Error: el total de la venta no puede ser negativo.");
            return;
        }
        saleRepository.create(sale);
    }

    public List<Sale> listSales() {
        return saleRepository.listAll();
    }

    public Sale searchSale(int id) {
        Sale sale = saleRepository.searchById(id);
        if (sale == null) {
            System.out.println("No se encontro ninguna venta con id: " + id);
        }
        return sale;
    }

    public void updateSale(Sale sale) {
        if (saleRepository.searchById(sale.getIdSale()) == null) {
            System.out.println("No se puede actualizar. Venta con id " + sale.getIdSale() + " no existe.");
            return;
        }
        saleRepository.update(sale);
    }

    public void deleteSale(int id) {
        if (saleRepository.searchById(id) == null) {
            System.out.println("No se puede eliminar. Venta con id " + id + " no existe.");
            return;
        }
        saleRepository.delete(id);
    }
}