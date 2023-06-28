import ActionTypes from "../action/actiontype";

const initialState = {
    client: [],
    client_id: [],
    message: "",
    status: "",
    refresh: "",
  }; 
  
  function ClientReducers(state = initialState, action: any) {
    const { type, payload } = action;

    // console.log('REDUCER',clit_id)x  
    switch (type) {
      case ActionTypes.RES_GET_CLIENT:
        return { state, client: payload, refresh: true };

      case ActionTypes.RES_GET_CLIENT_BY_ID:
        return { state, client_id: payload, refresh: true };

      case ActionTypes.RES_ADD_CLIENT:
        return {
          message: payload.message,
          status: payload.status,
          refresh: false,
        };
      case ActionTypes.RES_UPDATE_CLIENT:
        return {
          message: payload.message,
          status: payload.status,
          refresh: false,
        };
      case ActionTypes.RES_DELETE_CLIENT:
        return {
          message: payload.message,
          status: payload.status,
          refresh: false,
        };

        case ActionTypes.RESET_STATE:
        return {
          initialState
        };
        
      default:
        return state;
    }
  }

  export default ClientReducers