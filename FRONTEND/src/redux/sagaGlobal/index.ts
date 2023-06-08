import { all, takeEvery } from 'redux-saga/effects'
import AuthActionTypes from '../usersSchema/auth/action/actionType'
import { handleLogin } from '../usersSchema/auth/saga'

function* watchAll() {
    yield all([
        takeEvery(AuthActionTypes.LOGIN,handleLogin),
    ])
}

export default watchAll