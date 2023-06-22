import CheckBox from "./checkBox";
import AccordionTemplate from "./accordion";
import ToggleSwitch from "./switch";
import Button from "./button";
import RadioButton from "./radioButton";
import { useDispatch, useSelector } from "react-redux";
import { useEffect, useState } from "react";
import { doRequestGetWorktype } from "@/pages/redux/MasterSchema/action/actionReducer";

const FilterComp = (props: any) => {
  const {
    handleToggle,
    valueCheck,
    handleCheckboxChange,
    handleCheckboxChangeExpe,
    handleOptionChange,
    handleNewestButton,
    handleMatchButton
  } = props;

  const dispatch = useDispatch();
  let { work_type, refresh } = useSelector(
    (state: any) => state.WorktypeReducers
  );

  const rangeExpe = [
    { value: "0-0", label: "< 1 Tahun" },
    { value: "1-3", label: "1 - 3 Tahun" },
    { value: "5-10", label: "5 - 10 Tahun" },
    { value: "11-100", label: "> 10 Tahun" },
  ];

  const terUpdate = [
    { value: "24 Jam Terakhir", label: "24 Jam Terakhir" },
    { value: "Seminggu Terakhir", label: "Seminggu Terakhir" },
    { value: "Sebulan Terakhir", label: "Sebulan Terakhir" },
    { value: "Kapan pun", label: "Kapan pun" },
  ];

  useEffect(() => {
    dispatch(doRequestGetWorktype());
  }, [refresh]);

  return (
    <div className=" pr-5 pb-5 flex">
      <div className="overflow-y-auto h-[32rem] w-[22rem] block items-center border p-5 py-1 ">
        <AccordionTemplate desc="Filter Pencarianmu" />
        <AccordionTemplate
          desc="Tampilan berdasarkan"
          Content={
            <div className="relative flex flex-wrap justify-center py-3">
              <button
                type="button"
                className="flex justify-center items-center h-7 w-20 text-blue-700 bg-white hover:bg-blue-50 focus:outline-none focus:ring-2 focus:ring-blue-500 font-medium rounded-lg text-xs px-4 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:text-white dark:focus:ring-blue-800"
                onClick={handleMatchButton}
              >
                Match
              </button>

              <button
                type="button"
                className="flex justify-center items-center h-7 w-20 text-blue-700 bg-white hover:bg-blue-50 focus:outline-none focus:ring-2 focus:ring-blue-500 font-medium rounded-lg text-xs px-4 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:text-white dark:focus:ring-blue-800"
                onClick={handleNewestButton}
              >
                Newest
              </button>
            </div>
          }
        />
        <AccordionTemplate
          desc="Tipe Pekerjaan"
          Content={
            <div className="grid grid-rows-1 gap-3 pl-1 py-3 ">
              {work_type.map((option: any) => (
                <label className="inline-flex items-center">
                  <input
                    type="checkbox"
                    className="form-checkbox h-4 w-4 text-blue-500 transition duration-150 ease-in-out"
                    value={option.woty_code}
                    onChange={handleCheckboxChange}
                  />
                  <span className="ml-2 text-gray-700">{option.woty_name}</span>
                </label>
              ))}
            </div>
          }
        />
        <AccordionTemplate
          desc="Pengalaman"
          Content={
            <div className="grid grid-rows-1 gap-3 pl-1 py-3">
              {rangeExpe.map((option: any) => (
                <label className="inline-flex items-center">
                  <input
                    type="checkbox"
                    className="form-checkbox h-4 w-4 text-blue-500 transition duration-150 ease-in-out"
                    value={option.value}
                    onChange={handleCheckboxChangeExpe}
                  />
                  <span className="ml-2 text-gray-700">{option.label}</span>
                </label>
              ))}
            </div>
          }
        />
        <AccordionTemplate
          desc="Remote"
          Content={
            <div className="pl-1 py-3 text-center">
              <label className="relative inline-flex items-center mb-4 cursor-pointer">
                <input
                  type="checkbox"
                  value=""
                  className="sr-only peer"
                  checked={valueCheck}
                  onChange={handleToggle}
                />
                <div className="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600"></div>
              </label>
            </div>
          }
        />

        <AccordionTemplate
          desc="Terupdate"
          Content={
            <div className="pl-1 py-3 text-center ">
              {terUpdate.map((option: any, index: any) => (
                <div className="flex items-center mb-3">
                  <input
                    id={`radio-${index}`}
                    type="radio"
                    value={option.value}
                    name="default-radio"
                    onChange={handleOptionChange}
                    className="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800  dark:bg-gray-700 dark:border-gray-600"
                  />
                  <label className="ml-2 text-gray-700">{option.label}</label>
                </div>
              ))}
            </div>
          }
        />
      </div>
    </div>
  );
};
export default FilterComp;
