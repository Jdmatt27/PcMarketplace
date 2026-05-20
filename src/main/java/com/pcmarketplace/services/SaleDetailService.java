package com.pcmarketplace.services;

import com.pcmarketplace.models.SaleDetail;
import com.pcmarketplace.repositories.SaleDetailRepositoryIMPL;

import java.util.List;

public class SaleDetailService {

    private SaleDetailRepositoryIMPL saleDetailRepository = new SaleDetailRepositoryIMPL();

    public void createSaleDetail(SaleDetail saleDetail) {
        if (saleDetail.getAmount() <= 0) {
            System.out.println("Error: la cantidad debe ser mayor que 0.");
            return;
        }
        if (saleDetail.getUnitPrice() <= 0) {
            System.out.println("Error: el precio unitario debe ser mayor que 0.");
            return;
        }
        saleDetailRepository.create(saleDetail);
    }

    public List<SaleDetail> listSaleDetails() {
        return saleDetailRepository.listAll();
    }

    public SaleDetail searchSaleDetail(int id) {
        SaleDetail saleDetail = saleDetailRepository.searchById(id);
        if (saleDetail == null) {
            System.out.println("No se encontro ningun detalle de venta con id: " + id);
        }
        return saleDetail;
    }

    public void updateSaleDetail(SaleDetail saleDetail) {
        if (saleDetailRepository.searchById(saleDetail.getIdDetail()) == null) {
            System.out.println("No se puede actualizar. Detalle con id " + saleDetail.getIdDetail() + " no existe.");
            return;
        }
        saleDetailRepository.update(saleDetail);
    }

    public void deleteSaleDetail(int id) {
        if (saleDetailRepository.searchById(id) == null) {
            System.out.println("No se puede eliminar. Detalle con id " + id + " no existe.");
            return;
        }
        saleDetailRepository.delete(id);
    }
}