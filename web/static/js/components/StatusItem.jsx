import React, { Component } from "react";

export default class StatusItem extends Component {
  render() {
    const { item } = this.props;
    return <div className="status-item">
      <div className="cell name">{item.user}</div>
      <div className="cell project">{item.project}</div>
      <div className={`cell state state-${item.state}`}>{item.state}</div>
      <div className="cell notes">{item.notes}</div>
    </div>;
  }
}
