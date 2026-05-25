initializeStorage();

let clientes = getData(STORAGE_KEYS.clientes);
let productos = getData(STORAGE_KEYS.productos);
let usuarios = getData(STORAGE_KEYS.usuarios);
let ventas = getData(STORAGE_KEYS.ventas);
let detalleVentas = getData(STORAGE_KEYS.detalleVentas);

const saleForm = document.querySelector("#saleForm");
const ventaIdInput = document.querySelector("#ventaId");
const clienteInput = document.querySelector("#cliente");
const usuarioInput = document.querySelector("#usuario");
const productoInput = document.querySelector("#producto");
const cantidadInput = document.querySelector("#cantidad");
const estadoInput = document.querySelector("#estado");
const saleTotal = document.querySelector("#saleTotal");
const submitButton = document.querySelector("#submitButton");
const resetButton = document.querySelector("#resetButton");
const searchSaleInput = document.querySelector("#searchSale");
const salesTable = document.querySelector("#salesTable");

function formatCurrency(value) {
    return `${Number(value).toLocaleString("es-ES")} €`;
}

function getNextSaleId() {
    if (ventas.length === 0) return 1;
    const ids = ventas.map((venta) => venta.id);
    return Math.max(...ids) + 1;
}

function getNextDetailId() {
    if (detalleVentas.length === 0) return 1;
    const ids = detalleVentas.map((detalle) => detalle.id);
    return Math.max(...ids) + 1;
}

function getClienteById(id) {
    return clientes.find((cliente) => cliente.id === Number(id));
}

function getProductoById(id) {
    return productos.find((producto) => producto.id === Number(id));
}

function getDetalleByVentaId(ventaId) {
    return detalleVentas.find((detalle) => detalle.ventaId === Number(ventaId));
}

function loadSelects() {
    clienteInput.innerHTML = `<option value="">Selecciona un cliente</option>`;
    usuarioInput.innerHTML = `<option value="">Selecciona un comercial</option>`;
    productoInput.innerHTML = `<option value="">Selecciona un producto</option>`;

    clientes.forEach((cliente) => {
        clienteInput.innerHTML += `<option value="${cliente.id}">${cliente.nombre}</option>`;
    });

    usuarios.forEach((usuario) => {
        usuarioInput.innerHTML += `<option value="${usuario.id}">${usuario.nombre}</option>`;
    });

    productos.forEach((producto) => {
        productoInput.innerHTML += `
            <option value="${producto.id}">
                ${producto.nombre} - ${formatCurrency(producto.precio)} - Stock: ${producto.stock}
            </option>`;
    });
}

function calculateTotal() {
    const producto = getProductoById(productoInput.value);
    const cantidad = Number(cantidadInput.value);

    if (!producto || cantidad <= 0) {
        saleTotal.textContent = formatCurrency(0);
        return 0;
    }

    const total = producto.precio * cantidad;
    saleTotal.textContent = formatCurrency(total);
    return total;
}

function resetForm() {
    saleForm.reset();
    ventaIdInput.value = "";
    cantidadInput.value = 1;
    submitButton.textContent = "Registrar venta";
    calculateTotal();
}

function saveVentasData() {
    saveData(STORAGE_KEYS.ventas, ventas);
    saveData(STORAGE_KEYS.detalleVentas, detalleVentas);
    saveData(STORAGE_KEYS.productos, productos);
}

function renderVentas(ventasToRender = ventas) {
    if (ventasToRender.length === 0) {
        salesTable.innerHTML = `<div class="empty-state">No se han encontrado ventas.</div>`;
        return;
    }

    salesTable.innerHTML = `
        <div class="table__row table__row--head">
            <span>Cliente</span>
            <span>Comercial</span>
            <span>Producto</span>
            <span>Fecha</span>
            <span>Estado</span>
            <span>Total</span>
            <span>Acciones</span>
        </div>
    `;

    ventasToRender.forEach((venta) => {
        const cliente = getClienteById(venta.clienteId);
        const usuario = usuarios.find((u) => u.id === venta.usuarioId);
        const detalle = getDetalleByVentaId(venta.id);
        const producto = detalle ? getProductoById(detalle.productoId) : null;

        const badgeClass = venta.estado === "Completada"
            ? "badge badge--success"
            : venta.estado === "Pendiente"
            ? "badge badge--warning"
            : "badge badge--danger";

        salesTable.innerHTML += `
            <div class="table__row">
                <span>${cliente ? cliente.nombre : "—"}</span>
                <span>${usuario ? usuario.nombre : "—"}</span>
                <span>${producto ? producto.nombre : "—"}</span>
                <span>${venta.fecha}</span>
                <span class="${badgeClass}">${venta.estado}</span>
                <span>${formatCurrency(venta.total)}</span>
                <div class="table__actions">
                    <button class="table__button table__button--edit" data-id="${venta.id}">Editar</button>
                    <button class="table__button table__button--delete" data-id="${venta.id}">Eliminar</button>
                </div>
            </div>
        `;
    });
}

function validarStock(producto, cantidad, cantidadAnterior = 0) {
    const stockDisponible = producto.stock + cantidadAnterior;

    if (cantidad > stockDisponible) {
        window.alert("No hay suficiente stock disponible para registrar esta venta.");
        return false;
    }
    return true;
}

function createVenta() {
    const producto = getProductoById(productoInput.value);
    const cantidad = Number(cantidadInput.value);

    if (!validarStock(producto, cantidad)) return;

    const nuevaVentaId = getNextSaleId();
    const total = calculateTotal();

    const nuevaVenta = new Venta(
        nuevaVentaId,
        Number(clienteInput.value),
        Number(usuarioInput.value),
        new Date().toISOString().split("T")[0],
        estadoInput.value,
        total
    );

    const nuevoDetalle = new DetalleVenta(
        getNextDetailId(),
        nuevaVentaId,
        Number(productoInput.value),
        cantidad,
        producto.precio
    );

    ventas.push(nuevaVenta);
    detalleVentas.push(nuevoDetalle);

    if (estadoInput.value !== "Cancelada") {
        producto.stock -= cantidad;
    }

    saveVentasData();
    loadSelects();
    renderVentas();
    resetForm();
}

function updateVenta(id) {
    const venta = ventas.find((venta) => venta.id === id);
    const detalle = getDetalleByVentaId(id);
    const productoNuevo = getProductoById(productoInput.value);

    if (!venta || !detalle || !productoNuevo) return;

    const cantidadNueva = Number(cantidadInput.value);
    const productoAnterior = getProductoById(detalle.productoId);
    const cantidadAnterior = detalle.cantidad;

    if (productoAnterior && venta.estado !== "Cancelada") {
        productoAnterior.stock += cantidadAnterior;
    }

    if (!validarStock(productoNuevo, cantidadNueva)) {
        if (productoAnterior && venta.estado !== "Cancelada") {
            productoAnterior.stock -= cantidadAnterior;
        }
        return;
    }

    venta.clienteId = Number(clienteInput.value);
    venta.usuarioId = Number(usuarioInput.value);
    venta.estado = estadoInput.value;
    venta.total = calculateTotal();

    detalle.productoId = Number(productoInput.value);
    detalle.cantidad = cantidadNueva;

    if (estadoInput.value !== "Cancelada") {
        productoNuevo.stock -= cantidadNueva;
    }

    saveVentasData();
    loadSelects();
    renderVentas();
    resetForm();
}

function editVenta(id) {
    const venta = ventas.find((v) => v.id === id);
    const detalle = getDetalleByVentaId(id);
    if (!venta || !detalle) return;

    ventaIdInput.value = venta.id;
    clienteInput.value = venta.clienteId;
    usuarioInput.value = venta.usuarioId;
    productoInput.value = detalle.productoId;
    cantidadInput.value = detalle.cantidad;
    estadoInput.value = venta.estado;
    submitButton.textContent = "Actualizar venta";
    calculateTotal();
}

function deleteVenta(id) {
    const confirmDelete = window.confirm("¿Seguro que quieres eliminar esta venta?");
    if (!confirmDelete) return;

    const venta = ventas.find((v) => v.id === id);
    const detalle = getDetalleByVentaId(id);

    if (detalle && venta && venta.estado !== "Cancelada") {
        const producto = getProductoById(detalle.productoId);
        if (producto) producto.stock += detalle.cantidad;
    }

    ventas = ventas.filter((v) => v.id !== id);
    detalleVentas = detalleVentas.filter((d) => d.ventaId !== id);

    saveVentasData();
    loadSelects();
    renderVentas();
    resetForm();
}

function searchVentas() {
    const searchText = searchSaleInput.value.toLowerCase().trim();

    const filtered = ventas.filter((venta) => {
        const cliente = getClienteById(venta.clienteId);
        const usuario = usuarios.find((u) => u.id === venta.usuarioId);
        const detalle = getDetalleByVentaId(venta.id);
        const producto = detalle ? getProductoById(detalle.productoId) : null;

        return (
            (cliente && cliente.nombre.toLowerCase().includes(searchText)) ||
            (usuario && usuario.nombre.toLowerCase().includes(searchText)) ||
            (producto && producto.nombre.toLowerCase().includes(searchText)) ||
            venta.estado.toLowerCase().includes(searchText) ||
            venta.fecha.includes(searchText)
        );
    });

    renderVentas(filtered);
}

productoInput.addEventListener("change", calculateTotal);
cantidadInput.addEventListener("input", calculateTotal);

saleForm.addEventListener("submit", function (event) {
    event.preventDefault();
    const editingId = Number(ventaIdInput.value);
    if (editingId) {
        updateVenta(editingId);
    } else {
        createVenta();
    }
});

resetButton.addEventListener("click", resetForm);

searchSaleInput.addEventListener("input", searchVentas);

salesTable.addEventListener("click", (event) => {
    const button = event.target;
    const id = Number(button.dataset.id);

    if (button.classList.contains("table__button--edit")) {
        editVenta(id);
    }

    if (button.classList.contains("table__button--delete")) {
        deleteVenta(id);
    }
});

loadSelects();
calculateTotal();
renderVentas();