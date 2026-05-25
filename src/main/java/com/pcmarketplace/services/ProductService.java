package com.pcmarketplace.services;

import com.pcmarketplace.models.Product;
import com.pcmarketplace.repositories.ProductRepositoryIMPL;

import java.util.List;

public class ProductService {

    private ProductRepositoryIMPL productRepository = new ProductRepositoryIMPL();

    public void createProduct(Product product) {
        if (product.getName() == null || product.getName().isEmpty()) {
            System.out.println("Error: el nombre del producto no puede estar vacio.");
            return;
        }
        if (product.getPrice() <= 0) {
            System.out.println("Error: el precio del producto debe ser mayor que 0.");
            return;
        }
        productRepository.create(product);
    }

    public List<Product> listProducts() {
        return productRepository.listAll();
    }

    public Product searchProduct(int id) {
        Product product = productRepository.searchById(id);
        if (product == null) {
            System.out.println("No se encontro ningun producto con id: " + id);
        }
        return product;
    }

    public void updateProduct(Product product) {
        if (productRepository.searchById(product.getIdProduct()) == null) {
            System.out.println("No se puede actualizar. Producto con id " + product.getIdProduct() + " no existe.");
            return;
        }
        productRepository.update(product);
    }

    public void deleteProduct(int id) {
        if (productRepository.searchById(id) == null) {
            System.out.println("No se puede eliminar. Producto con id " + id + " no existe.");
            return;
        }
        productRepository.delete(id);
    }
}