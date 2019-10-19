const APIURL = "http://localhost:3000";
$(function () {
    // show the popup window
    $("#addNewFriendBtn").on("click", () => {
        $('.ui.modal')
            .modal({
                blurring: true
            })
            .modal('show');
    });

    // search the user by user_name if it can't find the user show "Nope", 
    // otherwise show the user's photo
    $("#searchBtn").on('click', () => {
        $.ajax({
            type: "GET",
            url: `${APIURL}/users/getUserByUserName`,
            data: { user_name: $("#user_name").val() },
            dataType: "json",
            success: function (data) {
                if (data.status == 200) {
                    const img_url = data.user.picture_url.includes("http") ? data.user.picture_url : "./images/" + data.user.picture_url;
                    $(".user-add-new-friend > img").attr("src", img_url);
                    $(".user-add-new-friend > span").css("display", "none");
                    $(".user-add-new-friend > img").css("display", "block");
                    $("#receiver_id").val(data.user.id);
                    $("#receiver_id").change();
                } else {
                    $(".user-add-new-friend > img").css("display", "none");
                    $(".user-add-new-friend > span").css("display", "block");
                    $("#receiver_id").val('');
                    $("#receiver_id").change();
                }
            }
        });
    });

    // send request to requests controller to create a new request
    $("#sendRequestBtn").on('click', () => {

        $.ajax({
            type: "POST",
            url: `${APIURL}/requests/`,
            data: { receiver_id: $("#receiver_id").val() },
            dataType: "json",
            success: function (data) {
                if (data.status == 200) {
                    window.location = window.location;
                }
                else {
                    $('.ui.negative.hidden.message p').text(data.errors);
                    $('.ui.negative.hidden.message').removeClass("hidden");
                    $("#receiver_id").val('');
                    $("#receiver_id").change();
                    $(".user-add-new-friend > span").css("display", "none");
                    $(".user-add-new-friend > img").css("display", "none");
                    $("#user_name").val('');
                }
            }
        });
    });

    // happened when changing the receiver's id
    $("#receiver_id").change((event) => {
        if (event.currentTarget.value != "") {
            $("#sendRequestBtn").removeAttr("disabled");;
        }
        else {
            $('#sendRequestBtn').attr("disabled", "disabled");
        }
    });

    $('.message .close').on('click', function () {
        $(this)
            .closest('.message')
            .transition('fade');
    });

});

function changeFriend(is_accepted, sender_id, request_id) {
    $.ajax({
        type: "PATCH",
        url: `${APIURL}/requests/${request_id}`,
        data: { sender_id, is_accepted },
        dataType: "json",
        success: function (data) {
            window.location = window.location;
        }
    });
}