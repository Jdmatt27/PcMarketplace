const STORAGE_KEYS = {
    clientes: "nexuscrm_clientes",
    productos: "nexuscrm_productos",
    usuarios: "nexuscrm_usuarios",
    ventas: "nexuscrm_ventas",
    detalleVentas: "nexuscrm_detalle_ventas"
};


const initialClientes = [
    new Cliente(
        1,
        "Laura Martín",
        "laura.martin@email.com",
        "612345678",
        "Madrid"
    ),

    new Cliente(
        2,
        "Carlos Ruiz",
        "carlos.ruiz@email.com",
        "623456789",
        "Valencia"
    ),

    new Cliente(
        3,
        "Marta Gómez",
        "marta.gomez@email.com",
        "634567890",
        "Sevilla"
    )
];


const initialProductos = [
    new Producto(
        1,
        "Portátil NovaBook 15",
        "Portátiles",
        899,
        4
    ),

    new Producto(
        2,
        "Monitor Vision 27",
        "Monitores",
        229,
        2
    ),

    new Producto(
        3,
        "Teclado Mecánico K90",
        "Periféricos",
        79,
        18
    ),

    new Producto(
        4,
        "Ratón ProClick X",
        "Periféricos",
        49,
        3
    )
];


const initialUsuarios = [
    new Usuario(
        1,
        "Daniel Torres",
        "daniel.torres@nexuscrm.com",
        "Comercial"
    ),

    new Usuario(
        2,
        "Sara López",
        "sara.lopez@nexuscrm.com",
        "Responsable de ventas"
    )
];


const initialVentas = [
    new Venta(
        1,
        1,
        1,
        "2026-05-02",
        "Completada",
        899
    ),

    new Venta(
        2,
        2,
        2,
        "2026-05-03",
        "Pendiente",
        229
    ),

    new Venta(
        3,
        3,
        1,
        "2026-05-04",
        "Completada",
        79
    )
];


const initialDetalleVentas = [
    new DetalleVenta(
        1,
        1,
        1,
        1,
        899
    ),

    new DetalleVenta(
        2,
        2,
        2,
        1,
        229
    ),

    new DetalleVenta(
        3,
        3,
        3,
        1,
        79
    )
];


function saveData(key, data) {
    sessionStorage.setItem(
        key,
        JSON.stringify(data)
    );
}


function getData(key) {
    return JSON.parse(
        sessionStorage.getItem(key)
    ) || [];
}


function initializeStorage() {
    if (!sessionStorage.getItem(STORAGE_KEYS.clientes)) {
        saveData(
            STORAGE_KEYS.clientes,
            initialClientes
        );
    }

    if (!sessionStorage.getItem(STORAGE_KEYS.productos)) {
        saveData(
            STORAGE_KEYS.productos,
            initialProductos
        );
    }

    if (!sessionStorage.getItem(STORAGE_KEYS.usuarios)) {
        saveData(
            STORAGE_KEYS.usuarios,
            initialUsuarios
        );
    }

    if (!sessionStorage.getItem(STORAGE_KEYS.ventas)) {
        saveData(
            STORAGE_KEYS.ventas,
            initialVentas
        );
    }

    if (!sessionStorage.getItem(STORAGE_KEYS.detalleVentas)) {
        saveData(
            STORAGE_KEYS.detalleVentas,
            initialDetalleVentas
        );
    }
}
