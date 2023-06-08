import AuthActionTypes from "./actionType";

export const Login = (payload: any) => {
    return {
        type: AuthActionTypes.LOGIN,
        payload
    }
}

export const LoginResponse = (payload: any) => {
    return {
        type: AuthActionTypes.LOGIN_RESPONSE,
        payload
    }
}

export const Logout = (payload: any) => {
    return {
        type: AuthActionTypes.LOGOUT,
        payload
    }
}

export const LogoutResponse = (payload: any) => {
    return {
        type: AuthActionTypes.LOGOUT_RESPONSE,
        payload
    }
}