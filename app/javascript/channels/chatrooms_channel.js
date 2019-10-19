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
      // document.querySelector(`[data-behavior='chatroom-link'][data-chatroom-id='${data.chatroom_id}']`)
    }

    // Called when there's incoming data on the websocket for this channel
  }
});
