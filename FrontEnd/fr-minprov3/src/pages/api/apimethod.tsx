import axios from "../config/endpoint";


/*-------- CRUD JOB POST --------*/
const findAllJob =()=>{
    return axios.get("/")
}

const findCurrentNumber =()=>{
    return axios.get("/job-hire/currnum")
}

const createJobPost =(data:any)=>{
    return axios.post("/",data)
}

const updateJobPost =(data:any)=>{
    return axios.patch(`/`,data)
}

const deleteJobPost =(data:any)=>{
    return axios.delete(`/`,data)
}

/*-------- CRUD CLIENT ---------*/

const findAllClient =()=>{
    return axios.get("/")
}

const createClient =(data:any)=>{
    return axios.post("/",data)
}

const updateClient =(data:any)=>{
    return axios.patch(`/`,data)
}

const deleteClient =(data:any)=>{
    return axios.delete(`/`,data)
}


export default {
    findAllJob,
    findCurrentNumber,
    createJobPost,
    updateJobPost,
    deleteJobPost,

    findAllClient,
    createClient,
    updateClient,
    deleteClient
}