import ActionTypes from "../action/actiontype";

const initialState = {
    candidates_apply: [],
    candidates_interview: [],
    candidates_contract :[],
    candidates_failed :[],
    message: "",
    status: "",
    refresh: "",
  }; 
  
  function TalentReducers(state = initialState, action: any) {
    const { type, payload } = action;
    // console.log("talentReducer payload",payload);
    switch (type) {
      case ActionTypes.RES_GET_CANDIDATE_APPLY:
        return { ...state, candidates_apply: payload, refresh: true };  
        
      case ActionTypes.RES_GET_CANDIDATE_INTERVIEW:
        return { ...state, candidates_interview: payload, refresh: true };  
        
      case ActionTypes.RES_GET_CANDIDATE_CONTRACT:
        return { ...state, candidates_contract: payload, refresh: true };  

      case ActionTypes.RES_GET_CANDIDATE_FAILED:
        return { ...state, candidates_failed: payload, refresh: true };  
        
      case ActionTypes.RES_UPDATE_CANDIDATE:
        return { message: payload.message, status: payload.status, refresh: false };  
      default:
        return state;
    }
  }

  export default TalentReducers