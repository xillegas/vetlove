import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    altInput: true,
    enableTime: true
  });
  $("#datePets").flatpickr({
    altInput: true,
    disable: [
      {
        from: "2021-11-04",
        to: "2025-05-01"
      }
    ]
  })
}

export { initFlatpickr };
