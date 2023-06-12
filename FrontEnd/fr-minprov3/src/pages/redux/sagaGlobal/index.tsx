import ActionType from "../../redux/JobhireSchema/action/actiontype";
import { takeEvery, all, takeLatest } from "redux-saga/effects";
import { handleAddJobPost, handleDeleteJobPost, handleGetAllJobPost, handleGetCurnumber, handleUpdateJobPost } from "../JobhireSchema/saga/jobpostSaga";
import { handleAddClient, handleDeleteClient, handleGetAllClient, handleUpdateClient } from "../JobhireSchema/saga/clientsaga";

function* watchAll() {
    yield all([
      takeEvery(ActionType.REQ_GET_JOBPOST, handleGetAllJobPost),
      takeEvery(ActionType.REQ_GET_CURNUMBER, handleGetCurnumber),
      takeEvery(ActionType.REQ_ADD_JOBPOST, handleAddJobPost),
      takeEvery(ActionType.REQ_UPDATE_JOBPOST, handleUpdateJobPost),
      takeEvery(ActionType.REQ_DELETE_JOBPOST, handleDeleteJobPost),
  
      takeEvery(ActionType.REQ_GET_CLIENT, handleGetAllClient),
      takeEvery(ActionType.REQ_ADD_CLIENT, handleAddClient),
      takeEvery(ActionType.REQ_UPDATE_CLIENT, handleUpdateClient),
      takeEvery(ActionType.REQ_DELETE_CLIENT, handleDeleteClient)

    ]);
  }
  
  export default watchAll;