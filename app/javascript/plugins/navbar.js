const myNav = document.getElementById('mynav')

window.onscroll = function () {
  if (document.body.scrollTop >= 280 || document.documentElement.scrollTop >= 280) {
    myNav.classList.add("change-color");
  } else {
    myNav.classList.remove("change-color");
  }
};
