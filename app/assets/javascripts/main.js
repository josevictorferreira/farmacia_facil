
$(document).ready(function () {
    $('button.delete').on('click', function (ev) {
        ev.preventDefault();
        $(ev.target).closest('.notification').remove();
    });
});
