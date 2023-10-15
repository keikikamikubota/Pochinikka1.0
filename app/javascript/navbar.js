import { Turbo } from "@hotwired/turbo-rails";

document.addEventListener("turbolinks:load", function() {
    // ページ遷移時にNavbarを閉じる
    const navbarToggler = document.querySelector(".navbar-toggler");
    const navbarCollapse = document.querySelector(".navbar-collapse");

    if (navbarToggler && navbarCollapse) {
        navbarToggler.addEventListener("click", function() {
            navbarCollapse.classList.toggle("show");
        });

        Turbo.streams.channel("turbo:visit").addEventListener("turbo:load", function() {
            // ページが遷移した後にトグルバーを閉じる
            navbarCollapse.classList.remove("show");
        });
    }
});