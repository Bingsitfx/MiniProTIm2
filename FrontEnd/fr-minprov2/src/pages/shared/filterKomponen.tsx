import CheckBox from "./komponen/checkBox";
import AccordionTemplate from "./komponen/accordion";
import ToggleSwitch from "./komponen/switch";
import Button from "./komponen/button";
import RadioButton from "./komponen/radioButton";

const FilterComp = () => {
  return (
      <div className="block h-fit items-center border w-1/4 p-3 py-2">
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
            <div className="grid grid-rows-1 gap-3 pl-1 py-3">
              <CheckBox namaCheck="Magang" />
              <CheckBox namaCheck="Full-time" />
              <CheckBox namaCheck="Part-time" />
              <CheckBox namaCheck="Freelance" />
            </div>
          }
        />
        <AccordionTemplate
          desc="Pengalaman"
          Content={
            <div className="grid grid-rows-1 gap-3 pl-1 py-3">
              <CheckBox namaCheck="< 1 Tahun" />
              <CheckBox namaCheck="1 - 3 Tahun" />
              <CheckBox namaCheck="5 - 10 Tahun" />
              <CheckBox namaCheck="> 10 Tahun" />
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
            <div className="pl-1 pt-3 text-center ">
              <RadioButton text="24 Jam Terakhir"></RadioButton>
              <RadioButton text="Seminggu Terakhir"></RadioButton>
              <RadioButton text="Sebuan Terakhir"></RadioButton>
              <RadioButton text="Kapan pun"></RadioButton>
            </div>
          }
        />
      </div>
  );
};
export default FilterComp;
