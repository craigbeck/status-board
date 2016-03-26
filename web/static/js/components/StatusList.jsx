import React, { Component } from "react";
import { connect } from "react-redux";
import StatusItem from "./StatusItem";

class StatusList extends Component {
  render() {
    const { status } = this.props;
    return <div className="col-xs-12 status">
      {status.map(item => <StatusItem key={item.id} item={item}/>)}
    </div>;
  }
}

const mapProps = state => {
  const { status } = state;
  return {
    status
  }
};

export default connect(mapProps)(StatusList);
