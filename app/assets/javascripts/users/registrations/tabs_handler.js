$(document).ready(function() {
    $('#address-tab').on('click', function (event) {
        $('#address-form').show();
        $('#personal-form').hide();
        $('#address-tab').addClass('is-active');
        $('#personal-tab').removeClass('is-active');
    });
    $('#personal-tab').on('click', function (event) {
        $('#personal-form').show();
        $('#address-form').hide();
        $('#personal-tab').addClass('is-active');
        $('#address-tab').removeClass('is-active');
    });
});
