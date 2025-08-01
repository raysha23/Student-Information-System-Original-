document.addEventListener("DOMContentLoaded", function () {
    const addBtn = document.querySelector(".add-btn");
    const modal = document.getElementById("addTeacherModal");
    const cancelBtn = document.querySelector(".cancel-btn");
    const form = modal.querySelector("form");
    const tableBody = document.querySelector(".teacher-table tbody");

    let editingRow = null;

    // Show modal
    addBtn.addEventListener("click", () => {
        editingRow = null;
        form.reset();
        modal.style.display = "block";
        document.querySelector(".submit-btn").textContent = "Add Teacher";
    });

    // Close modal
    cancelBtn.addEventListener("click", closeModal);
    function closeModal() {
        modal.style.display = "none";
        form.reset();
        editingRow = null;
    }

    // Submit (Add or Edit)
    form.addEventListener("submit", function (e) {
        e.preventDefault();

        const firstName = form.firstName.value;
        const lastName = form.lastName.value;
        const email = form.email.value;
        const hireDate = form.hireDate.value;
        const department = form.department.value;
        const specialization = form.specialization.value;

        if (editingRow) {
            const cells = editingRow.querySelectorAll("td");
            cells[1].textContent = firstName;
            cells[2].textContent = lastName;
            cells[3].textContent = email;
            cells[5].textContent = hireDate;
            cells[6].textContent = department;
            cells[7].textContent = specialization;
        } else {
            const newRow = document.createElement("tr");
            newRow.innerHTML = `
          <td>${generateID()}</td>
          <td>${firstName}</td>
          <td>${lastName}</td>
          <td>${email}</td>
          <td>—</td>
          <td>${hireDate}</td>
          <td>${department}</td>
          <td>${specialization}</td>
          <td>Active</td>
          <td>
            <div class="action-button">
              <button class="edit-btn">Edit</button>
              <button class="delete-btn">Delete</button>
            </div>
          </td>
        `;
            addActionListeners(newRow);
            tableBody.appendChild(newRow);
        }

        closeModal();
    });

    function generateID() {
        const lastRow = tableBody.lastElementChild;
        if (!lastRow) return 2001;
        const lastID = parseInt(lastRow.firstElementChild.textContent);
        return lastID + 1;
    }

    function addActionListeners(row) {
        const editBtn = row.querySelector(".edit-btn");
        const deleteBtn = row.querySelector(".delete-btn");

        editBtn.addEventListener("click", function () {
            const cells = row.querySelectorAll("td");

            form.firstName.value = cells[1].textContent;
            form.lastName.value = cells[2].textContent;
            form.email.value = cells[3].textContent;
            form.hireDate.value = cells[5].textContent;
            form.department.value = cells[6].textContent;
            form.specialization.value = cells[7].textContent;

            editingRow = row;
            modal.style.display = "block";
            document.querySelector(".submit-btn").textContent = "Save Changes";
        });

        deleteBtn.addEventListener("click", function () {
            if (confirm("Are you sure you want to delete this teacher?")) {
                row.remove();
            }
        });
    }

    // 🟡 Apply Edit/Delete to all existing rows in the table at page load
    document.querySelectorAll(".teacher-table tbody tr").forEach((row) => {
        addActionListeners(row);
    });
});
