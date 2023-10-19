document.addEventListener('DOMContentLoaded', (event) => {
    if (window.history && window.history.replaceState) {
        window.history.replaceState({}, '', '/admins/new');
    }
});
