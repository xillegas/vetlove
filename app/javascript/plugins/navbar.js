const myNav = document.getElementById('mynav')

window.onscroll = function () {
  if (document.body.scrollTop >= 520 || document.documentElement.scrollTop >= 520) {
    myNav.classList.add("change-color");
  } else {
    myNav.classList.remove("change-color");
  }
};
