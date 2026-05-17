initializeStorage();
let clientes = getData(STORAGE_KEYS.clientes);

const clientForm = document.querySelector("#clientForm");
const clienteIdInput = document.querySelector("#clienteId");
const nombreInput = document.querySelector("#nombre");
const emailInput = document.querySelector("#email");
const telefonoInput = document.querySelector("#telefono");
const direccionInput = document.querySelector("#direccion");
const submitButton = document.querySelector("#submitButton");
const resetButton = document.querySelector("#resetButton");
const searchClientInput = document.querySelector("#searchClient");
const clientsTable = document.querySelector("#clientsTable");

function getNextClientId() {
    if (clientes.length === 0) return 1;
    const ids = clientes.map((cliente) => cliente.id);
    return Math.max(...ids) + 1;
}

function resetForm() {
    clientForm.reset();
    clienteIdInput.value = "";
    submitButton.textContent = "Guardar cliente";
}

function saveClientes() {
    saveData(STORAGE_KEYS.clientes, clientes);
}

function renderClientes(clientesToRender = clientes) {
    if (clientesToRender.length === 0) {
        clientsTable.innerHTML = `
            <div class="empty-state">No se han encontrado clientes.</div>
        `;
        return;
    }

    clientsTable.innerHTML = `
        <div class="table__row table__row--head">
            <span>Nombre</span>
            <span>Email</span>
            <span>Teléfono</span>
            <span>Dirección</span>
            <span>Acciones</span>
        </div>
    `;

    clientesToRender.forEach((cliente) => {
        clientsTable.innerHTML += `
            <div class="table__row">
                <span>${cliente.nombre}</span>
                <span>${cliente.email}</span>
                <span>${cliente.telefono}</span>
                <span>${cliente.direccion}</span>
                <div class="table__actions">
                    <button class="table__button table__button--edit" data-id="${cliente.id}">
                        Editar
                    </button>
                    <button class="table__button table__button--delete" data-id="${cliente.id}">
                        Eliminar
                    </button>
                </div>
            </div>
        `;
    });
}

function createCliente() {
    const nuevoCliente = new Cliente(
        getNextClientId(),
        nombreInput.value.trim(),
        emailInput.value.trim(),
        telefonoInput.value.trim(),
        direccionInput.value.trim()
    );

    clientes.push(nuevoCliente);
    saveClientes();
    renderClientes();
    resetForm();
}

function updateCliente(id) {
    const cliente = clientes.find((cliente) => cliente.id === id);

    if (!cliente) return;

    cliente.nombre = nombreInput.value.trim();
    cliente.email = emailInput.value.trim();
    cliente.telefono = telefonoInput.value.trim();
    cliente.direccion = direccionInput.value.trim();

    saveClientes();
    renderClientes();
    resetForm();
}

function editCliente(id) {
    const cliente = clientes.find((cliente) => cliente.id === id);
    if (!cliente) return;

    clienteIdInput.value = cliente.id;
    nombreInput.value = cliente.nombre;
    emailInput.value = cliente.email;
    telefonoInput.value = cliente.telefono;
    direccionInput.value = cliente.direccion;

    submitButton.textContent = "Actualizar cliente";
}

function deleteCliente(id) {
    const confirmDelete = window.confirm("¿Seguro que quieres eliminar este cliente?");
    if (!confirmDelete) return;

    clientes = clientes.filter((cliente) => cliente.id !== id);
    saveClientes();
    renderClientes();
    resetForm();
}

function searchClientes() {
    const searchText = searchClientInput.value.toLowerCase().trim();

    const filteredClientes = clientes.filter((cliente) => {
        return (
            cliente.nombre.toLowerCase().includes(searchText) ||
            cliente.email.toLowerCase().includes(searchText) ||
            cliente.telefono.includes(searchText) ||
            cliente.direccion.toLowerCase().includes(searchText)
        );
    });

    renderClientes(filteredClientes);
}

clientForm.addEventListener("submit", function (event) {
    event.preventDefault();

    const editingId = Number(clienteIdInput.value);

    if (editingId) {
        updateCliente(editingId);
    } else {
        createCliente();
    }
});

resetButton.addEventListener("click", resetForm);

searchClientInput.addEventListener("input", searchClientes);

clientsTable.addEventListener("click", (event) => {
    const button = event.target;
    const id = Number(button.dataset.id);

    if (button.classList.contains("table__button--edit")) {
        editCliente(id);
    }

    if (button.classList.contains("table__button--delete")) {
        deleteCliente(id);
    }
});

renderClientes();
