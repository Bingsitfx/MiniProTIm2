import { createLogger } from "redux-logger";
import createSagaMiddleware from "@redux-saga/core";
import { combineReducers, configureStore } from "@reduxjs/toolkit";
import authReducers from "../usersSchema/auth/reducer/authReducer";
import rootSaga from '@/redux/sagaGlobal'

const logger = createLogger()
const saga = createSagaMiddleware()
const reducer = combineReducers({
    authReducers
})

const store = configureStore({
    reducer,
    middleware: (getDefaultMiddleware) => getDefaultMiddleware({
        serializableCheck: false
    }).concat(logger).concat(saga)
})

saga.run(rootSaga)

export default store