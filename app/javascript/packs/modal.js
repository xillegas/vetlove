
function modals() {
    // console.log(document.querySelectorAll(".modal-btn"));
    document.querySelectorAll(".modal-btn").forEach(modal_btn => {
        modal_btn.addEventListener('click', (element) => {
            let modalForm = document.querySelector(".new_booking")
            const route = `/consulting_rooms/${element.target.dataset.roomid}/bookings`;
            modalForm.action = route;
        })
    });
}

export { modals };
