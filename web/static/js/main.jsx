import React from "react";
import ReactDOM from "react-dom";
import { createStore, combineReducers } from "redux";
import { Provider } from "react-redux";
import StatusList from "./components/StatusList";
import axios from "axios";

import "phoenix_html"
import socket from "./socket"
import status from "./reducer"


const store = createStore(combineReducers({
  status
}));

store.subscribe(() => console.log("CHANGE", store.getState()));

axios.get("/api/status")
  .then(res => {
    store.dispatch({
      type: "LOAD",
      payload: res.data.data
    });
  });

const channel = socket.channel("status:lobby", {});

channel.on("update", resp => {
  const action = {
    type: "UPDATE",
    payload: resp.status
  };
  console.log("action", action);
  store.dispatch(action);
});

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

ReactDOM.render(
  <Provider store={store}>
    <StatusList/>
  </Provider>,
  document.getElementById("root")
)
