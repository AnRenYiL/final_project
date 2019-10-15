$(function () {
    $("#message_body").on("keypress", function (event) {
        if (event && event.keyCode == 13) {
            event.preventDefault();
            $(this).parent().submit();
        }
    })
})