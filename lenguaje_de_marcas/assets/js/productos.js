initializeStorage();
let productos = getData(STORAGE_KEYS.productos);

const productForm = document.querySelector("#productForm");
const productoIdInput = document.querySelector("#productoId");
const nombreInput = document.querySelector("#nombre");
const categoriaInput = document.querySelector("#categoria");
const precioInput = document.querySelector("#precio");
const stockInput = document.querySelector("#stock");
const submitButton = document.querySelector("#submitButton");
const resetButton = document.querySelector("#resetButton");
const searchProductInput = document.querySelector("#searchProduct");
const productsTable = document.querySelector("#productsTable");

function formatCurrency(value) {
    return `${Number(value).toLocaleString("es-ES")} €`;
}

function getNextProductId() {
    if (productos.length === 0) return 1;
    const ids = productos.map((producto) => producto.id);
    return Math.max(...ids) + 1;
}

function resetForm() {
    productForm.reset();
    productoIdInput.value = "";
    submitButton.textContent = "Guardar producto";
}

function saveProductos() {
    saveData(STORAGE_KEYS.productos, productos);
}

function getStockBadge(producto) {
    if (producto.stock <= 5) {
        return `<span class="stock-badge stock-badge--low">${producto.stock} uds.</span>`;
    }
    return `<span class="stock-badge stock-badge--ok">${producto.stock} uds.</span>`;
}

function renderProductos(productosToRender = productos) {
    if (productosToRender.length === 0) {
        productsTable.innerHTML = `
            <div class="empty-state">No se han encontrado productos.</div>
        `;
        return;
    }

    productsTable.innerHTML = `
        <div class="table__row table__row--head">
            <span>Producto</span>
            <span>Categoría</span>
            <span>Precio</span>
            <span>Stock</span>
            <span>Acciones</span>
        </div>
    `;

    productosToRender.forEach((producto) => {
        productsTable.innerHTML += `
            <div class="table__row">
                <span>${producto.nombre}</span>
                <span>${producto.categoria}</span>
                <span>${formatCurrency(producto.precio)}</span>
                <span>${getStockBadge(producto)}</span>
                <div class="table__actions">
                    <button class="table__button table__button--edit" data-id="${producto.id}">
                        Editar
                    </button>
                    <button class="table__button table__button--delete" data-id="${producto.id}">
                        Eliminar
                    </button>
                </div>
            </div>
        `;
    });
}

function createProducto() {
    const nuevoProducto = new Producto(
        getNextProductId(),
        nombreInput.value.trim(),
        categoriaInput.value,
        Number(precioInput.value),
        Number(stockInput.value)
    );

    productos.push(nuevoProducto);
    saveProductos();
    renderProductos();
    resetForm();
}

function updateProducto(id) {
    const producto = productos.find((p) => p.id === id);
    if (!producto) return;

    producto.nombre = nombreInput.value.trim();
    producto.categoria = categoriaInput.value;
    producto.precio = Number(precioInput.value);
    producto.stock = Number(stockInput.value);

    saveProductos();
    renderProductos();
    resetForm();
}

function editProducto(id) {
    const producto = productos.find((p) => p.id === id);
    if (!producto) return;

    productoIdInput.value = producto.id;
    nombreInput.value = producto.nombre;
    categoriaInput.value = producto.categoria;
    precioInput.value = producto.precio;
    stockInput.value = producto.stock;

    submitButton.textContent = "Actualizar producto";
}

function deleteProducto(id) {
    if (!window.confirm("¿Seguro que quieres eliminar este producto?")) return;

    productos = productos.filter((p) => p.id !== id);
    saveProductos();
    renderProductos();
    resetForm();
}

function searchProductos() {
    const searchText = searchProductInput.value.toLowerCase().trim();

    const filteredProductos = productos.filter((producto) => {
        return (
            producto.nombre.toLowerCase().includes(searchText) ||
            producto.categoria.toLowerCase().includes(searchText)
        );
    });

    renderProductos(filteredProductos);
}

productForm.addEventListener("submit", function (event) {
    event.preventDefault();
    const editingId = Number(productoIdInput.value);

    if (editingId) {
        updateProducto(editingId);
    } else {
        createProducto();
    }
});

resetButton.addEventListener("click", resetForm);

searchProductInput.addEventListener("input", searchProductos);

productsTable.addEventListener("click", (event) => {
    const button = event.target;
    const id = Number(button.dataset.id);

    if (button.classList.contains("table__button--edit")) {
        editProducto(id);
    }

    if (button.classList.contains("table__button--delete")) {
        deleteProducto(id);
    }
});

renderProductos();
