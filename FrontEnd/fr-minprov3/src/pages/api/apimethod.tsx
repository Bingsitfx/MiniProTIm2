import axios from "../config/endpoint";

/*--------------------------- Schema Job Hire ------------------------------*/
/*-------- CRUD JOB POST --------*/
const findAllJob =()=>{
    return axios.get("/job-hire/alljob")
}

const findJobPhoto =()=>{
    return axios.get("/job-hire/photo")
}

const jobPostById = (id:any) => {
    return axios.get(`/job-hire/find/${id}`)
}

const findCurrentNumber =()=>{
    return axios.get("/job-hire/currnum")
}

const createJobPost =(data:any)=>{
    // console.log('api',...data)
    return axios.post("/job-hire/create",data ,{headers:{"Content-Type":"multipart/form-data"}})
}

const updateJobPost =(data:any)=>{  
    console.log('api update',...data)
    return axios.patch(`/job-hire/update/${data.get("jopo_entity_id")}`,data,{headers:{"Content-Type":"multipart/form-data"}})
}

const deleteJobPost =(data:any)=>{
    return axios.delete(`/job-hire/delete/${data.id}`,data)
}

const updateStatus =(data:any)=>{  
    // console.log('api update',data)
    return axios.patch(`/job-hire/status`,data)
}

const searchPostJob =(data:any)=>{
    return axios.get(`/job-hire/search`, {
        params: {
          key: data.search.keyword,
          loc: data.search.location,
          job : data.search.job,
          type: data.search.type,
          jobType: data.search.jobType.join(","),
          expe : data.search.expe.join(","),
          terupdate : data.search.terupdate,
          newest : data.search.newest,
        },
      })
}



/*-------- CRUD CLIENT ---------*/

const findAllClient =()=>{
    return axios.get("/job-hire/clientall")
}

const allClientAll =()=>{
    return axios.get("/job-hire/allclient")
}

const clientById = (id:any) => {
    return axios.get(`/job-hire/client/find/${id}`)
}

const createClient =(data:any)=>{
    // console.log('api',data)
    return axios.post("/job-hire/client",data)
}

const updateClient =(data:any)=>{
    // console.log('API',data)
    return axios.patch(`/job-hire/client/update/${data.clit_id}`,data)
}

const deleteClient =(data:any)=>{
    return axios.delete(`/`,data)
    
}

/*-------------- EMPLOYEE RANGE --------------*/
const findAllEmprange =()=>{
    return axios.get(`/job-hire/emprange`)
}

/*--------------------------- Schema Master ------------------------------*/

const findEducation =()=>{
    return axios.get('/master/edu')
}
const findWorktype =()=>{
    return axios.get('/master/worktype')
}
const findJobrole =()=>{
    return axios.get('/master/jobrole')
}
const findIndustry =()=>{
    return axios.get('/master/industry')
}
const findCity =()=>{
    return axios.get('/master/city')
}

export default {
    findAllJob,
    findCurrentNumber,
    createJobPost,
    updateJobPost,
    deleteJobPost,
    jobPostById,
    updateStatus,
    findJobPhoto,
    searchPostJob,

    findAllEmprange,

    findAllClient,
    allClientAll,
    clientById,
    createClient,
    updateClient,
    deleteClient,

    findEducation,
    findWorktype,
    findJobrole,
    findIndustry,
    findCity,
}