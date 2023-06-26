import { call, put } from "redux-saga/effects";
import apiMethod from "../../../api/apimethod";
import {
doResponseGetCandidateApply, doResponseGetCandidateContract, doResponseGetCandidateFailed, doResponseGetCandidateInterview, doResponseUpdateCandidate,
} from "../action/actionreducer";

export function* handleGetProCandidateApply(): any {
  try {
    const result = yield call(apiMethod.findProCandidateApply);
    // console.log("talentSaga", result.data);
    yield put(doResponseGetCandidateApply(result.data));
  } catch (error) {
    yield put(doResponseGetCandidateApply({ message: error, status: 400 }));
  }
}

export function* handleGetProCandidateInterview(): any {
  try {
    const result = yield call(apiMethod.findProCandidateInterview);
    // console.log("talentSaga", result.data);
    yield put(doResponseGetCandidateInterview(result.data));
  } catch (error) {
    yield put(doResponseGetCandidateInterview({ message: error, status: 400 }));
  }
}

export function* handleGetProCandidateContract(): any {
  try {
    const result = yield call(apiMethod.findProCandidateContract);
    // console.log("talentSaga", result.data);
    yield put(doResponseGetCandidateContract(result.data));
  } catch (error) {
    yield put(doResponseGetCandidateContract({ message: error, status: 400 }));
  }
}

export function* handleGetProCandidateFailed(): any {
  try {
    const result = yield call(apiMethod.findProCandidateFailed);
    // console.log("talentSaga", result.data);
    yield put(doResponseGetCandidateFailed(result.data));
  } catch (error) {
    yield put(doResponseGetCandidateFailed({ message: error, status: 400 }));
  }
}

export function* handleUpdateCandidate(action:any): any {
  try {
    const result = yield call(apiMethod.updateTalentStatus, action.payload);
    console.log("UPDATE TALENT", result);
    yield put(doResponseUpdateCandidate(result.data));
  } catch (error) {
    yield put(doResponseUpdateCandidate({ message: error, status: 400 }));
  }
}