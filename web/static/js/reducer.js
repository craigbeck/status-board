
export default function status(state, action) {
  switch (action.type) {
    case "LOAD":
      return [...action.payload];
    case "UPDATE":
      const idx = state.findIndex(i => i.id === action.payload.id);
      if (idx < 0) {
        return [...state, action.payload];
      }
      const newState = [...state];
      newState[idx] = action.payload;
      return newState;
    default:
      return state || [];
  }
}
