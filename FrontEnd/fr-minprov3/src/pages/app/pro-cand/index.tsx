import React, { Fragment, useEffect, useState } from "react";
import { Tabs } from "antd";
import type { TabsProps } from "antd";
import { Menu, Transition } from "@headlessui/react";
import MoreVertIcon from "@mui/icons-material/MoreVert";
import Link from "next/link";
import { useDispatch, useSelector } from "react-redux";

import { format } from "date-fns";
import { doRequestGetCandidateApply, doRequestGetCandidateContract, doRequestGetCandidateInterview } from "@/pages/redux/JobhireSchema/action/actionreducer";

const App: React.FC = () => {
  const [status, setStatus] = useState("1");

  const onChange = (key: string) => {
    setStatus(key);
  };

  let { candidates_apply,candidates_interview,candidates_contract ,refresh } = useSelector(
    (state: any) => state.TalentReducers
  );
 
  console.log('APPLY',candidates_apply)
  console.log('INTERVIEW',candidates_interview)
  console.log('CONTRACT',candidates_contract)


    useEffect(()=>{
      setStatus(status);
      if (status === "1") {

       dispatch(doRequestGetCandidateApply())
  
      } else if (status === "2") {
  
        dispatch(doRequestGetCandidateInterview())
      
        // dispatch(filteringAction());
      } else if (status === "3") {
 
        dispatch(doRequestGetCandidateContract())
      
      }
    },[refresh,status])

  

  
  // useEffect(()=>{
    
  //   // console.log("HASIL", untukDispatch);
  // },[refresh])

  const dispatch = useDispatch();

  // useEffect(() => {
  //   dispatch(doRequestGetCandidate());
  // }, [refresh]);

  const items: TabsProps["items"] = [
    {
      key: "1",
      label: <p className="font-semibold">Apply</p>,
      children: [
        <>
          {(candidates_apply || []).map((dt: any) => (
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
              </div>

              <div className="">
                <Menu as="div" className="relative inline-block text-left">
                  <div>
                    <Menu.Button className="inline-flex w-full justify-center rounded-md px-4 py-2 text-sm font-medium text-white hover:bg-opacity-30 focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-opacity-75">
                      <MoreVertIcon
                        className="ml-2 -mr-1 h-5 w-5 text-gray-700 hover:text-gray-400 sm:flex"
                        aria-hidden="true"
                      />
                    </Menu.Button>
                  </div>
                  <Transition
                    as={Fragment}
                    enter="transition ease-out duration-100"
                    enterFrom="transform opacity-0 scale-95"
                    enterTo="transform opacity-100 scale-100"
                    leave="transition ease-in duration-75"
                    leaveFrom="transform opacity-100 scale-100"
                    leaveTo="transform opacity-0 scale-95"
                  >
                    <Menu.Items className="absolute right-7 -mt-[4rem] mr-2 w-24 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
                      <div className="px-1 py-1 ">
                        <Menu.Item>
                          {({ active }) => (
                            <Link
                              href={{
                                pathname: "#",
                              }}
                              className={`${
                                active
                                  ? "bg-blue-400 text-white"
                                  : "text-gray-900"
                              } group flex w-full items-center rounded-md px-2 py-2 text-sm`}
                            >
                              Ready Test
                            </Link>
                          )}
                        </Menu.Item>
                      </div>
                    </Menu.Items>
                  </Transition>
                </Menu>
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
          {(candidates_interview || []).map((dt: any) => (
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
              </div>

              <div className="">
                <Menu as="div" className="relative inline-block text-left">
                  <div>
                    <Menu.Button className="inline-flex w-full justify-center rounded-md px-4 py-2 text-sm font-medium text-white hover:bg-opacity-30 focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-opacity-75">
                      <MoreVertIcon
                        className="ml-2 -mr-1 h-5 w-5 text-gray-700 hover:text-gray-400 sm:flex"
                        aria-hidden="true"
                      />
                    </Menu.Button>
                  </div>
                  <Transition
                    as={Fragment}
                    enter="transition ease-out duration-100"
                    enterFrom="transform opacity-0 scale-95"
                    enterTo="transform opacity-100 scale-100"
                    leave="transition ease-in duration-75"
                    leaveFrom="transform opacity-100 scale-100"
                    leaveTo="transform opacity-0 scale-95"
                  >
                    <Menu.Items className="absolute right-7 -mt-[4rem] mr-2 w-24 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
                      <div className="px-1 py-1 ">
                        <Menu.Item>
                          {({ active }) => (
                            <Link
                              href={{
                                pathname: "#",
                              }}
                              className={`${
                                active
                                  ? "bg-blue-400 text-white"
                                  : "text-gray-900"
                              } group flex w-full items-center rounded-md px-2 py-2 text-sm`}
                            >
                              Ready Test
                            </Link>
                          )}
                        </Menu.Item>
                      </div>
                    </Menu.Items>
                  </Transition>
                </Menu>
              </div>
            </div>
          ))}
        </>,
      ],
    },
    {
      key: "3",
      label: <p className="font-semibold">Contract</p>,
      children: `Content of Tab Pane 3`,
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
