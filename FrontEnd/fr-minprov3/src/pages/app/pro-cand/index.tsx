import React, { Fragment, useEffect, useState } from "react";
import { Tabs } from "antd";
import type { TabsProps } from "antd";
import { Dialog, Menu, Transition } from "@headlessui/react";
import MoreVertIcon from "@mui/icons-material/MoreVert";
import Link from "next/link";
import { useDispatch, useSelector } from "react-redux";

import { format } from "date-fns";
import {
  doRequestGetCandidateApply,
  doRequestGetCandidateContract,
  doRequestGetCandidateFailed,
  doRequestGetCandidateInterview,
  doRequestUpdateCandidate,
  doRequestUpdateStatus,
} from "@/pages/redux/JobhireSchema/action/actionreducer";
import { useForm } from "react-hook-form";
import { TextField } from "@mui/material";

const App: React.FC = () => {
  const [status, setStatus] = useState("1");

  const onChange = (key: string) => {
    setStatus(key);
  };

  let { candidates_apply, candidates_interview, candidates_contract,candidates_failed, refresh } =
    useSelector((state: any) => state.TalentReducers);

  console.log("APPLY", candidates_apply);
  console.log("INTERVIEW", candidates_interview);
  console.log("CONTRACT", candidates_contract);
  console.log("FAILED", candidates_failed);

  useEffect(() => {
    setStatus(status);
    if (status === "1") {
      dispatch(doRequestGetCandidateApply());
    } else if (status === "2") {
      dispatch(doRequestGetCandidateInterview());

      // dispatch(filteringAction());
    } else if (status === "3") {
      dispatch(doRequestGetCandidateContract());
    } else if (status === "4"){
      dispatch(doRequestGetCandidateFailed())
    }
  }, [refresh, status]);

  const dispatch = useDispatch();

  /* HANDLE STATUS */

  type Value = {
    user_entity_id: number;
    taap_scoring: number;
    tapr_progress_name: string;
    taap_status: string;
    tapr_comment: string;
  };

  const {
    register,
    handleSubmit,
    formState: { errors },
    setValue,
  } = useForm<Value>();

  let [isOpen, setIsOpen] = useState(false);
  let [statusTalent, setStatusTalent] = useState("");

  function closeModal() {
    setIsOpen(false);
  }

  function openModal() {
    setIsOpen(true);
  }

  const registerOption = {
    tapr_comment: { required: "Review is required" },
  };

  const handleNumberChange = (e: any) => {
    const value = parseInt(e.target.value);
    // console.log("value", value);
    if (value < 70) {
      setStatusTalent("failed");
    } else{
      setStatusTalent("succeed");
    }
  };

  useEffect(()=>{
    setValue('taap_status',statusTalent)
  },[statusTalent])
  
  const handleApplyStatus = (data: any) => {
    const dataApply = {
      user_entity_id: candidates_apply[0].user_entity_id,
      taap_status: data.taap_status,
      tapr_status: data.taap_status === "interview" ? "waiting" : "cancelled",
      tapr_progress_name:
      data.taap_status === "interview" ? "interview" : "cancelled",
    };
    dispatch(doRequestUpdateCandidate(dataApply));
  };

  const handleInterviewStatus = (data: any) => {
    const dataInter = {
      user_entity_id: candidates_interview[0].user_entity_id,
      taap_status: data.taap_status,
      taap_scoring: data.taap_scoring,
      tapr_comment: data.tapr_comment,
      tapr_status: data.taap_status === 'succeed'?'done':'cancelled',
      tapr_progress_name: data.taap_status === 'succeed'?'contract':'cancelled',
    };
    // console.log("EYE2", data);
    dispatch(doRequestUpdateCandidate(dataInter))
    console.log("EYE", dataInter);
  };

  const items: TabsProps["items"] = [
    {
      key: "1",
      label: <p className="font-semibold">Apply</p>,
      children: [
        <>
         {(candidates_apply.length === 0)? 
        <div>BELUM ADA DATA</div>:
          (candidates_apply || []).map((dt: any) => (
            <div className="w-full h-[5rem] p-3 justify-between flex items-center border-b-2 ">
              <div>
                <h1 className="font-semibold">{dt.full_name}</h1>
                <h1 className="font-light italic">{dt.pmail_address}</h1>
              </div>

              <div>
                <h1 className="font-semibold">{dt.usdu_school}</h1>
                <h1 className="font-light italic">{dt.usdu_field_study}</h1>
              </div>

              <div>
                <h1 className="font-semibold">{dt.usdu_graduate_year}</h1>
              </div>

              <div>
                <h1 className="font-semibold">Apply Job</h1>
                <h2 className="font-light italic">{dt.jopo_title}</h2>
              </div>

              <div>
                <h1 className="font-semibold">{dt.clit_name}</h1>
              </div>

              <div>
                <h1 className="font-semibold">
                  Applied On -{" "}
                  {format(new Date(dt.taap_modified_date), "dd MMMM yyyy")}
                </h1>
                <p className="font-light italic capitalize">
                  {dt.tapr_progress_name}
                </p>
              </div>

              <div className="">
                <div className="finline-flex w-full justify-center rounded-md px-4 py-2 text-sm font-medium text-white hover:bg-opacity-30 focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-opacity-75">
                  <button
                    type="button"
                    onClick={openModal}
                    className="text-black hover:text-gray-400"
                  >
                    <MoreVertIcon></MoreVertIcon>
                  </button>
                </div>

                <Transition appear show={isOpen} as={Fragment}>
                  <Dialog
                    as="div"
                    className="relative z-10"
                    onClose={closeModal}
                  >
                    <Transition.Child
                      as={Fragment}
                      enter="ease-out duration-300"
                      enterFrom="opacity-0"
                      enterTo="opacity-100"
                      leave="ease-in duration-200"
                      leaveFrom="opacity-100"
                      leaveTo="opacity-0"
                    >
                      <div className="fixed inset-0 bg-black bg-opacity-25" />
                    </Transition.Child>

                    <div className="fixed inset-0 overflow-y-auto">
                      <div className="flex min-h-full items-center justify-center p-4 text-center">
                        <Transition.Child
                          as={Fragment}
                          enter="ease-out duration-300"
                          enterFrom="opacity-0 scale-95"
                          enterTo="opacity-100 scale-100"
                          leave="ease-in duration-200"
                          leaveFrom="opacity-100 scale-100"
                          leaveTo="opacity-0 scale-95"
                        >
                          <Dialog.Panel className="w-60 max-w-md transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-all">
                            <Dialog.Title
                              as="h3"
                              className="text-lg font-medium leading-6 text-gray-900"
                            >
                              Edit Status
                            </Dialog.Title>
                            <form onSubmit={handleSubmit(handleApplyStatus)}>
                              <div className="px-1 py-1 ">
                                <div>
                                  <select
                                    className="text-sm rounded-lg ring-1 block w-full p-1"
                                    {...register("taap_status")}
                                  >
                                    <option value="interview">Interview</option>
                                    <option value="failed">Failed</option>
                                  </select>
                                  <div className="pt-2 flex flex-cols-1 gap-2 w-full justify-center">
                                    <button
                                      type="submit"
                                      className="border  w-full rounded-lg text-white bg-blue-400"
                                      onClick={closeModal}
                                    >
                                      Save
                                    </button>
                                  </div>
                                </div>
                              </div>
                            </form>
                          </Dialog.Panel>
                        </Transition.Child>
                      </div>
                    </div>
                  </Dialog>
                </Transition>
              </div>
            </div>
          ))}
        </>,
      ],
    },
    {
      key: "2",
      label: <p className="font-semibold">Interview</p>,
      children: [
        <>
         {(candidates_interview.length === 0)? 
        <div>BELUM ADA DATA</div>:
          (candidates_interview || []).map((dt: any) => (
            <div className="w-full h-[5rem] p-3 justify-between flex items-center border-b-2 ">
              <div>
                <h1 className="font-semibold">{dt.full_name}</h1>
                <h1 className="font-light italic">{dt.pmail_address}</h1>
              </div>

              <div>
                <h1 className="font-semibold">{dt.usdu_school}</h1>
                <h1 className="font-light italic">{dt.usdu_field_study}</h1>
              </div>

              <div>
                <h1 className="font-semibold">{dt.usdu_graduate_year}</h1>
              </div>

              <div>
                <h1 className="font-semibold">Apply Job</h1>
                <h2 className="font-light italic">{dt.jopo_title}</h2>
              </div>

              <div>
                <h1 className="font-semibold">{dt.clit_name}</h1>
              </div>

              <div>
                <h1 className="font-semibold">
                  Applied On -{" "}
                  {format(new Date(dt.taap_modified_date), "dd MMMM yyyy")}
                </h1>
                <p className="font-light italic capitalize">{dt.tapr_progress_name}</p>
              </div>

              <div className="">
                <div className="finline-flex w-full justify-center rounded-md px-4 py-2 text-sm font-medium text-white hover:bg-opacity-30 focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-opacity-75">
                  <button
                    type="button"
                    onClick={openModal}
                    className="text-black hover:text-gray-400"
                  >
                    <MoreVertIcon></MoreVertIcon>
                  </button>
                </div>

                <Transition appear show={isOpen} as={Fragment}>
                  <Dialog
                    as="div"
                    className="relative z-10"
                    onClose={closeModal}
                  >
                    <Transition.Child
                      as={Fragment}
                      enter="ease-out duration-300"
                      enterFrom="opacity-0"
                      enterTo="opacity-100"
                      leave="ease-in duration-200"
                      leaveFrom="opacity-100"
                      leaveTo="opacity-0"
                    >
                      <div className="fixed inset-0 bg-black bg-opacity-25" />
                    </Transition.Child>

                    <div className="fixed inset-0 overflow-y-auto">
                      <div className="flex min-h-full items-center justify-center p-4 text-center">
                        <Transition.Child
                          as={Fragment}
                          enter="ease-out duration-300"
                          enterFrom="opacity-0 scale-95"
                          enterTo="opacity-100 scale-100"
                          leave="ease-in duration-200"
                          leaveFrom="opacity-100 scale-100"
                          leaveTo="opacity-0 scale-95"
                        >
                          <Dialog.Panel className="w-60 max-w-md transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-all">
                            <Dialog.Title
                              as="h3"
                              className="text-lg font-medium leading-6 text-gray-900"
                            >
                              Edit Status
                            </Dialog.Title>
                            <form
                              onSubmit={handleSubmit(handleInterviewStatus)}
                            >
                              <div className="px-1 py-1 ">
                                <div>
                                  <div className="flex pb-3 justify-between items-center">
                                    <label className="pr-2">Score</label>
                                    <input
                                      type="number"
                                      max="100"
                                      min="0"
                                      className="border rounded-lg w-20 px-2 py-1 ring-1"
                                      placeholder="Score"
                                      {...register("taap_scoring")}
                                      onChange={handleNumberChange}
                                    ></input>
                                  </div>
                                  <div className="flex items-center pb-3">
                                    <label className="pr-2">Status</label>
                                    <input
                                      className="border rounded-lg w-full px-2 py-1 ring-1"
                                      value={statusTalent}
                                      
                                    ></input>
                                  </div>
                                  <div>
                                    <label>Review</label>
                                    <TextField
                                      multiline
                                      rows={4}
                                      placeholder="Review"
                                      {...register('tapr_comment')}
                                    />
                                    <small className="text-red-500">
                                      {errors?.tapr_comment &&
                                        errors.tapr_comment.message}
                                    </small>
                                  </div>
                                  <div className="pt-2 flex flex-cols-1 gap-2 w-full justify-center">
                                    <button
                                      type="submit"
                                      className="border  w-full rounded-lg text-white bg-blue-400"
                                      onClick={closeModal}
                                    >
                                      Save
                                    </button>
                                  </div>
                                </div>
                              </div>
                            </form>
                          </Dialog.Panel>
                        </Transition.Child>
                      </div>
                    </div>
                  </Dialog>
                </Transition>
              </div>
            </div>
          ))}
        </>,
      ],
    },
    {
      key: "3",
      label: <p className="font-semibold">Contract</p>,
      children: [
        <>
         {(candidates_contract.length === 0)? 
        <div>BELUM ADA DATA</div>:
        (candidates_contract || []).map((dt: any) => (
          <div className="w-full h-[5rem] p-3 justify-between flex items-center border-b-2 ">
            <div>
              <h1 className="font-semibold">{dt.full_name}</h1>
              <h1 className="font-light italic">{dt.pmail_address}</h1>
            </div>

            <div>
              <h1 className="font-semibold">{dt.usdu_school}</h1>
              <h1 className="font-light italic">{dt.usdu_field_study}</h1>
            </div>

            <div>
              <h1 className="font-semibold">{dt.usdu_graduate_year}</h1>
            </div>

            <div>
              <h1 className="font-semibold">Apply Job</h1>
              <h2 className="font-light italic">{dt.jopo_title}</h2>
            </div>

            <div>
              <h1 className="font-semibold">{dt.clit_name}</h1>
            </div>

            <div>
              <h1 className="font-semibold">
                Applied On -{" "}
                {format(new Date(dt.taap_modified_date), "dd MMMM yyyy")}
              </h1>
              <p className="font-light italic capitalize">{dt.tapr_progress_name}</p>
            </div>

            <div className="">
              
            </div>
          </div>
        ))}
        </>
      ],
    },
    {
      key: "4",
      label: <p className="font-semibold">Failed</p>,
      children: [
        <>
        {(candidates_failed.length === 0)? 
        <div className="font-semimbold ">BELUM ADA DATA</div>:
        (candidates_failed || []).map((dt: any) => (
          <div className="w-full h-[5rem] p-3 justify-between flex items-center border-b-2 ">
            <div>
              <h1 className="font-semibold">{dt.full_name}</h1>
              <h1 className="font-light italic">{dt.pmail_address}</h1>
            </div>

            <div>
              <h1 className="font-semibold">{dt.usdu_school}</h1>
              <h1 className="font-light italic">{dt.usdu_field_study}</h1>
            </div>

            <div>
              <h1 className="font-semibold">{dt.usdu_graduate_year}</h1>
            </div>

            <div>
              <h1 className="font-semibold">Apply Job</h1>
              <h2 className="font-light italic">{dt.jopo_title}</h2>
            </div>

            <div>
              <h1 className="font-semibold">{dt.clit_name}</h1>
            </div>

            <div>
              <h1 className="font-semibold">
                Applied On -{" "}
                {format(new Date(dt.taap_modified_date), "dd MMMM yyyy")}
              </h1>
              <p className="font-light italic capitalize">{dt.tapr_progress_name}</p>
            </div>

            <div className="">
              
            </div>
          </div>
        ))}
        </>
      
      ],
    },
  ];

  return (
    <div className="w-full justify-center">
      <Tabs
        className="text-center border-2 px-2 bg-gray-100"
        defaultActiveKey="1"
        items={items}
        onChange={onChange}
      />
    </div>
  );
};

export default App;
