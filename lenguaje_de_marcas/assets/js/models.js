class Cliente {
    constructor(id, nombre, email, telefono, direccion) {
        this.id = id;
        this.nombre = nombre;
        this.email = email;
        this.telefono = telefono;
        this.direccion = direccion;
    }
}


class Producto {
    constructor(id, nombre, categoria, precio, stock) {
        this.id = id;
        this.nombre = nombre;
        this.categoria = categoria;
        this.precio = precio;
        this.stock = stock;
    }
}


class Usuario {
    constructor(id, nombre, email, rol) {
        this.id = id;
        this.nombre = nombre;
        this.email = email;
        this.rol = rol;
    }
}


class Venta {
    constructor(id, clienteId, usuarioId, fecha, estado, total) {
        this.id = id;
        this.clienteId = clienteId;
        this.usuarioId = usuarioId;
        this.fecha = fecha;
        this.estado = estado;
        this.total = total;
    }
}


class DetalleVenta {
    constructor(id, ventaId, productoId, cantidad, precioUnitario) {
        this.id = id;
        this.ventaId = ventaId;
        this.productoId = productoId;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
    }
}
