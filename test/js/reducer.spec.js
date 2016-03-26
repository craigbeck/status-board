import { expect } from "chai";
import reducer from "../../web/static/js/reducer";


describe("status reducer", () => {

  it("should import", () => {
    expect(reducer).to.be.a("function");
  })

  describe("INIT", () => {

    it("should return empty array", () => {
      expect(reducer(undefined, {})).to.deep.equal([]);
      expect(reducer(null, {})).to.deep.equal([]);
    })
  });

  describe("LOAD", () => {

    it("should return payload", () => {
      const expected = [
        {id:1},
        {id:2}
      ];
      const action = { type: "LOAD", payload: expected };
      expect(reducer(undefined, action)).to.deep.equal(expected);
      expect(reducer(null, action)).to.deep.equal(expected);
      expect(reducer([{id:3}], action)).to.deep.equal(expected);
    })
  });

  describe("UPDATE", () => {

    it("should add new items from payload", () => {
      const initial = [
        {id: 1, status: "ok"},
        {id: 2, status: "ok"}
      ];
      const action = {type: "UPDATE", payload: {id:3, status: "wfh"}};
      const expected = initial.concat(action.payload);
      expect(reducer(initial, action)).to.deep.equal(expected);
    });

    it("should merge existing items from payload", () => {
      const initial = [
        {id: 1, status: "ok"},
        {id: 2, status: "ok"}
      ];
      const action = {type: "UPDATE", payload: {id:2, status: "wfh"}};
      const expected = [initial[0], action.payload];
      const actual = reducer(initial, action);
      console.log("INITIAL", initial);
      console.log("EXPECT ", expected);
      console.log("ACTUAL ", actual);
      expect(actual).to.deep.equal(expected);
    });
  });
});
