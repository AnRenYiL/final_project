import consumer from "./consumer"
consumer.subscriptions.create("ChatroomsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const activeChatroom = document.querySelector(`.chatting-room-body-part[data-chatroom-id='${data.chatroom_id}']`);
    if (activeChatroom) {
      activeChatroom.appendChild(document.createRange().createContextualFragment(data.message));
    } else {

    }
    if (document.visibilityState == "hidden") {
      const img_url = $(data.message).children("img")[0].src;
      const childDiv = $(data.message).children("div");
      let a = new Notification(`${childDiv.children("strong")[0].innerText}: `, {
        body: childDiv.children("p")[0].innerText,
        icon: img_url,
        renotify: true,
        tag: childDiv.children("p")[0].innerText,
        silent: true
      });
      setTimeout(function () {
        a.close();
      }, 5000);
      // document.querySelector(`[data-behavior='chatroom-link'][data-chatroom-id='${data.chatroom_id}']`)
    }

    // Called when there's incoming data on the websocket for this channel
  }
});
