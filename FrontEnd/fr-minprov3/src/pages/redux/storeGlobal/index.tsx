import { configureStore } from "@reduxjs/toolkit";
import { createLogger } from "redux-logger";
import createSagaMiddleware from "@redux-saga/core";
import { combineReducers } from "redux";
import rootSaga from "../sagaGlobal";
import JobPostReducers from "../JobhireSchema/reducer/JobPostReducer";
import ClientReducers from "../JobhireSchema/reducer/ClientReducer";


const logger = createLogger();
const saga = createSagaMiddleware();

const reducer = combineReducers({
    JobPostReducers,
    ClientReducers
});

const store = configureStore({
  reducer,
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({ serializableCheck: false })
      .concat(logger)
      .concat(saga),
});

saga.run(rootSaga);
export default store;