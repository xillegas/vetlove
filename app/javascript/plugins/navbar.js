const testData = !!document.getElementById("mynav");
  if (testData) {
    const myNav = document.getElementById('mynav')
    window.onscroll = function () {
      if (document.body.scrollTop >= 520 || document.documentElement.scrollTop >= 520) {
        myNav.classList.add("change-color");
      } else {
        myNav.classList.remove("change-color");
      };
      if (document.documentElement.scrollTop >= 270 && document.documentElement.scrollTop <= 312) {
        myNav.classList.add("color-text-nav");
      } else {
        myNav.classList.remove("color-text-nav");
      }
      if (myNav.classList.contains("change-color-devise")) {
        void (0)
      };
    };
  } else {
    void (0);
  };
