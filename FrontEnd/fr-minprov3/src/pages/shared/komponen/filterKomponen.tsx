import CheckBox from "./checkBox";
import AccordionTemplate from "./accordion";
import ToggleSwitch from "./switch";
import Button from "./button";
import RadioButton from "./radioButton";
import { useDispatch, useSelector } from "react-redux";
import { useEffect } from "react";
import { doRequestGetWorktype } from "@/pages/redux/MasterSchema/action/actionReducer";

const FilterComp = (props: any) => {
  const { filterOptions, handleFilterChange } = props;

  const dispatch = useDispatch();
  let { work_type, refresh } = useSelector(
    (state: any) => state.WorktypeReducers
  );

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
              <Button text="Match"></Button>
              <Button text="Newest"></Button>
            </div>
          }
        />
        <AccordionTemplate
          desc="Tipe Pekerjaan"
          Content={
            <div className="grid grid-rows-1 gap-3 pl-1 py-3 ">
              {work_type.map((option: any) => (
                <CheckBox
                  option={option.woty_name}
                  key = {option.work_code}
                  filterOptions={filterOptions}
                  handleFilterChange={handleFilterChange}
                />
              ))}
            </div>
          }
        />
        <AccordionTemplate
          desc="Pengalaman"
          Content={
            <div className="grid grid-rows-1 gap-3 pl-1 py-3">
              
              {/* <CheckBox  />
              <CheckBox  />
              <CheckBox  />
              <CheckBox  /> */}
            </div>
          }
        />
        <AccordionTemplate
          desc="Remote"
          Content={
            <div className="pl-1 py-3 text-center">
              <ToggleSwitch />
            </div>
          }
        />

        <AccordionTemplate
          desc="Terupdate"
          Content={
            <div className="pl-1 py-3 text-center ">
              <RadioButton text="24 Jam Terakhir"></RadioButton>
              <RadioButton text="Seminggu Terakhir"></RadioButton>
              <RadioButton text="Sebuan Terakhir"></RadioButton>
              <RadioButton text="Kapan pun"></RadioButton>
            </div>
          }
        />
      </div>
    </div>
  );
};
export default FilterComp;
