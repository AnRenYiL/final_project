// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


$(function () {
    // show the popup window
    $("#addNewFriendBtn").on("click", () => {
        $('#add_new_friend_modal')
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
            url: `/users/getUserByUserName`,
            data: { user_name: $("#user_name").val() },
            dataType: "json",
            success: function (data) {
                if (data.status == 200) {
                    const img_url = data.user.picture_url.includes("http") ? data.user.picture_url : "./images/" + data.user.picture_url;
                    // const img_url = data.user.picture_url;
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
            url: `/requests/`,
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
    // show the add new channel window
    $("#add_new_channel").on("click", () => {
        $('#add_new_channel_modal')
            .modal({
                blurring: true
            })
            .modal('show');
    });
    $("#add_new_channel_btn").on("click", () => {
        const checkList = document.querySelectorAll('input[type="checkbox"]');
        let id_list = [];
        checkList.forEach(e => {
            if ($(e)[0].checked) {
                id_list.push($(e).val());
            }
        });
        const channel_name = $("#channel_name").val();
        $.ajax({
            type: "POST",
            url: `/chanels/`,
            data: { channel_name, id_list },
            dataType: "json",
            success: function (data) {
                if (data.status == 200) {
                    window.location.reload();
                }
            }
        });
    });
});


