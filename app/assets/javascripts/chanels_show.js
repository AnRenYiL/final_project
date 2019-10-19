$(function () {
    $("#message_body").on("keypress", function (event) {
        if (event && event.keyCode == 13) {
            event.preventDefault();
            $(this).parentElement.submit();
            // console.log()

            // const chanel_id = $("#chanel_id").val();
            // const body = $("#message_body").val();
            // console.log(1);
            // $.ajax({
            //     type: "POST",
            //     url: `http://localhost:3000/chanels/${chanel_id}/messages/`,
            //     data: { body },
            //     dataType: "json"
            //     ,
            //     success: function (data) {
            //         if (data.status == 200) {
            //             window.location = window.location;
            //         }
            //         else {

            //         }
            //     }
            // });
            // $("#message_body").val('');
        }
    });
});

