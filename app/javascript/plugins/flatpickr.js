import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    altInput: true,
    enableTime: true
  });
  $("#datePets").flatpickr({
    altInput: true,
    enable: [
      {
        from: "2000-01-01",
        to: "today"
      }
    ]
  });
  $("#dateBookings").flatpickr({
    altInput: true,
    enable: [
      {
        from: "today",
        to: new Date().fp_incr(180)
      }]
  })
}

export { initFlatpickr };
