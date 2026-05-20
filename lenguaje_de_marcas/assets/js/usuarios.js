initializeStorage();

let usuarios = getData(STORAGE_KEYS.usuarios);

const userForm = document.querySelector("#userForm");
const usuarioIdInput = document.querySelector("#usuarioId");
const nombreInput = document.querySelector("#nombre");
const emailInput = document.querySelector("#email");
const rolInput = document.querySelector("#rol");
const submitButton = document.querySelector("#submitButton");
const resetButton = document.querySelector("#resetButton");
const searchUserInput = document.querySelector("#searchUser");
const usersTable = document.querySelector("#usersTable");

function getNextUserId() {
    if (usuarios.length === 0) {
        return 1;
    }

    const ids = usuarios.map((usuario) => usuario.id);
    return Math.max(...ids) + 1;
}

function resetForm() {
    userForm.reset();
    usuarioIdInput.value = "";
    submitButton.textContent = "Guardar miembro";
}

function saveUsuarios() {
    saveData(STORAGE_KEYS.usuarios, usuarios);
}

function renderUsuarios(usuariosToRender = usuarios) {
    if (usuariosToRender.length === 0) {
        usersTable.innerHTML = `
            <div class="empty-state">
                No se han encontrado miembros del equipo.
            </div>
        `;
        return;
    }

    usersTable.innerHTML = `
        <div class="table__row table__row--head">
            <span>Nombre</span>
            <span>Email</span>
            <span>Rol</span>
            <span>Acciones</span>
        </div>
    `;

    usuariosToRender.forEach((usuario) => {
        usersTable.innerHTML += `
            <div class="table__row">

                <span>${usuario.nombre}</span>

                <span>${usuario.email}</span>

                <span>
                    <span class="role-badge">
                        ${usuario.rol}
                    </span>
                </span>

                <div class="table__actions">

                    <button
                        class="table__button table__button--edit"
                        data-id="${usuario.id}"
                    >
                        Editar
                    </button>

                    <button
                        class="table__button table__button--delete"
                        data-id="${usuario.id}"
                    >
                        Eliminar
                    </button>

                </div>

            </div>
        `;
    });
}

function createUsuario() {
    const nuevoUsuario = new Usuario(
        getNextUserId(),
        nombreInput.value.trim(),
        emailInput.value.trim(),
        rolInput.value
    );

    usuarios.push(nuevoUsuario);
    saveUsuarios();
    renderUsuarios();
    resetForm();
}

function updateUsuario(id) {
    const usuario = usuarios.find(
        (usuario) => usuario.id === id
    );

    if (!usuario) {
        return;
    }

    usuario.nombre = nombreInput.value.trim();
    usuario.email = emailInput.value.trim();
    usuario.rol = rolInput.value;

    saveUsuarios();
    renderUsuarios();
    resetForm();
}

function editUsuario(id) {
    const usuario = usuarios.find(
        (usuario) => usuario.id === id
    );

    if (!usuario) {
        return;
    }

    usuarioIdInput.value = usuario.id;
    nombreInput.value = usuario.nombre;
    emailInput.value = usuario.email;
    rolInput.value = usuario.rol;

    submitButton.textContent = "Actualizar miembro";
}

function deleteUsuario(id) {
    const confirmDelete = window.confirm(
        "¿Seguro que quieres eliminar este miembro del equipo?"
    );

    if (!confirmDelete) {
        return;
    }

    usuarios = usuarios.filter(
        (usuario) => usuario.id !== id
    );

    saveUsuarios();
    renderUsuarios();
    resetForm();
}

function searchUsuarios() {
    const searchText = searchUserInput.value
        .toLowerCase()
        .trim();

    const filteredUsuarios = usuarios.filter((usuario) => {
        return (
            usuario.nombre
                .toLowerCase()
                .includes(searchText)

            ||

            usuario.email
                .toLowerCase()
                .includes(searchText)

            ||

            usuario.rol
                .toLowerCase()
                .includes(searchText)
        );
    });

    renderUsuarios(filteredUsuarios);
}

userForm.addEventListener("submit", function (event) {
    event.preventDefault();

    const editingId = Number(usuarioIdInput.value);

    if (editingId) {
        updateUsuario(editingId);
    } else {
        createUsuario();
    }
});

resetButton.addEventListener(
    "click",
    resetForm
);

searchUserInput.addEventListener(
    "input",
    searchUsuarios
);

usersTable.addEventListener("click", (event) => {
    const button = event.target;
    const id = Number(button.dataset.id);

    if (button.classList.contains("table__button--edit")) {
        editUsuario(id);
    }

    if (button.classList.contains("table__button--delete")) {
        deleteUsuario(id);
    }
});

renderUsuarios();
