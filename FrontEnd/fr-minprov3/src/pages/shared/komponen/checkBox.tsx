import { useState } from "react";

const Checkbox = (props:any) => {
    const {option, filterOptions,key, handleFilterChange} = props

    const handleChange = (event:any) => {
      const isChecked = event.target.checked;
      handleFilterChange(option, isChecked);
    };
  return (
    <label className="inline-flex items-center">
      <input
        type="checkbox"
        className="form-checkbox h-4 w-4 text-blue-500 transition duration-150 ease-in-out"
        value={option}
        checked={filterOptions.includes(option)}
        onChange={handleChange}
      />
      <span className="ml-2 text-gray-700">{option}</span>
    </label>
  );
};

export default Checkbox;