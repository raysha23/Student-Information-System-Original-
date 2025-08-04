document.addEventListener("DOMContentLoaded", function () {
    const addBtn = document.querySelector(".add-btn");
    const modal = document.getElementById("addStudentModal");
    const cancelBtn = document.querySelector(".cancel-btn");
    const form = modal.querySelector("form");
    const tableBody = document.querySelector(".student-table tbody");
    const submitBtn = document.querySelector(".submit-btn");

    let editingRow = null;

    // Show modal to add new student
    addBtn.addEventListener("click", () => {
        editingRow = null;
        form.reset();
        submitBtn.textContent = "Add Student";
        modal.style.display = "block";
    });

    // Close modal
    cancelBtn.addEventListener("click", closeModal);
    function closeModal() {
        modal.style.display = "none";
        form.reset();
        editingRow = null;
        submitBtn.textContent = "Add Student";
    }

    // Handle form submission
    form.addEventListener("submit", function (e) {
        e.preventDefault();

        const studentId = form.studentId.value;
        const firstName = form.firstName.value;
        const lastName = form.lastName.value;
        const enrollDate = form.enrollDate.value;
        const status = form.status.value;

        // Placeholder values for now
        const birthday = "—";
        const gender = "—";
        const email = `${firstName.toLowerCase()}.${lastName.toLowerCase()}@example.com`;
        const phone = "—";
        const address = "—";

        if (editingRow) {
            const cells = editingRow.querySelectorAll("td");
            cells[0].textContent = studentId;
            cells[1].textContent = firstName;
            cells[2].textContent = lastName;
            cells[3].textContent = birthday;
            cells[4].textContent = gender;
            cells[5].textContent = email;
            cells[6].textContent = phone;
            cells[7].textContent = address;
            cells[8].textContent = enrollDate;
            cells[9].textContent = status;
        } else {
            const newRow = document.createElement("tr");
            newRow.innerHTML = `
        <td>${studentId}</td>
        <td>${firstName}</td>
        <td>${lastName}</td>
        <td>${birthday}</td>
        <td>${gender}</td>
        <td>${email}</td>
        <td>${phone}</td>
        <td>${address}</td>
        <td>${enrollDate}</td>
        <td>${status}</td>
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

    // Add edit/delete listeners to a row
    function addActionListeners(row) {
        const editBtn = row.querySelector(".edit-btn");
        const deleteBtn = row.querySelector(".delete-btn");

        editBtn.addEventListener("click", () => {
            const cells = row.querySelectorAll("td");

            form.studentId.value = cells[0].textContent;
            form.firstName.value = cells[1].textContent;
            form.lastName.value = cells[2].textContent;
            form.enrollDate.value = cells[8].textContent;
            form.status.value = cells[9].textContent;

            editingRow = row;
            submitBtn.textContent = "Save Changes";
            modal.style.display = "block";
        });

        deleteBtn.addEventListener("click", () => {
            if (confirm("Are you sure you want to delete this student?")) {
                row.remove();
            }
        });
    }

    // Initialize existing rows
    document.querySelectorAll(".student-table tbody tr").forEach((row) => {
        addActionListeners(row);
    });

    window.chrome.webview.postMessage({ type: "getStudents" });

    window.chrome.webview.addEventListener("message", (event) => {
        const data = event.data;

        //ibutang sa table, columns sa th, rows sa tr
    });

});
