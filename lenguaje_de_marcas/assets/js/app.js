initializeStorage();


const clientes = getData(STORAGE_KEYS.clientes);
const productos = getData(STORAGE_KEYS.productos);
const usuarios = getData(STORAGE_KEYS.usuarios);
const ventas = getData(STORAGE_KEYS.ventas);
const detalleVentas = getData(STORAGE_KEYS.detalleVentas);


function formatCurrency(value) {
    return `${value.toLocaleString("es-ES")} €`;
}


function getClienteName(clienteId) {
    const cliente = clientes.find((cliente) => cliente.id === clienteId);

    return cliente ? cliente.nombre : "Cliente no encontrado";
}


function getProductoName(productoId) {
    const producto = productos.find((producto) => producto.id === productoId);

    return producto ? producto.nombre : "Producto no encontrado";
}


function getVentaMainProduct(ventaId) {
    const detalle = detalleVentas.find((detalle) => detalle.ventaId === ventaId);

    if (!detalle) {
        return "Sin productos";
    }

    return getProductoName(detalle.productoId);
}


const renderStats = () => {
    const statsContainer = document.querySelector("#stats");

    const ingresos = ventas.reduce((total, venta) => total + venta.total, 0);

    const ventasCompletadas = ventas.filter((venta) => venta.estado === "Completada").length;

    const productosBajoStock = productos.filter((producto) => producto.stock <= 5).length;

    const stats = [
        {
            label: "Ingresos registrados",
            number: formatCurrency(ingresos),
            detail: "Ventas actuales"
        },
        {
            label: "Ventas completadas",
            number: ventasCompletadas,
            detail: `${ventas.length} ventas totales`
        },
        {
            label: "Clientes activos",
            number: clientes.length,
            detail: "Base comercial"
        },
        {
            label: "Bajo stock",
            number: productosBajoStock,
            detail: "Revisión recomendada"
        }
    ];

    statsContainer.innerHTML = stats.map((item) => {
        return `
            <article class="stats__card">
                <p class="stats__label">${item.label}</p>
                <h3 class="stats__number">${item.number}</h3>
                <span class="stats__detail">${item.detail}</span>
            </article>
        `;
    }).join("");
};


const renderLatestSales = () => {
    const table = document.querySelector("#latestSalesTable");

    table.innerHTML = `
        <div class="table__row table__row--head">
            <span>Cliente</span>
            <span>Producto</span>
            <span>Estado</span>
            <span>Total</span>
        </div>
    `;

    ventas.forEach((venta) => {
        const badgeClass = venta.estado === "Completada"
            ? "badge badge--success"
            : "badge badge--warning";

        table.innerHTML += `
            <div class="table__row">
                <span>${getClienteName(venta.clienteId)}</span>
                <span>${getVentaMainProduct(venta.id)}</span>
                <span class="${badgeClass}">${venta.estado}</span>
                <span>${formatCurrency(venta.total)}</span>
            </div>
        `;
    });
};


const renderLowStock = () => {
    const stockList = document.querySelector("#lowStockList");

    const lowStockProducts = productos.filter((producto) => producto.stock <= 5);

    stockList.innerHTML = lowStockProducts.map((producto) => {
        return `
            <article class="stock-item">
                <div>
                    <h4 class="stock-item__name">${producto.nombre}</h4>
                    <p class="stock-item__category">${producto.categoria}</p>
                </div>

                <span class="stock-item__units">${producto.stock} uds.</span>
            </article>
        `;
    }).join("");
};


renderStats();
renderLatestSales();
renderLowStock();
