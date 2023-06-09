import React from 'react'
import {
    MagnifyingGlassIcon,
  } from "@heroicons/react/24/outline";

const handleFormSubmit = (event: any) => {
    event.preventDefault();
    // Tambahkan logika untuk menghandle submit form di sini
  };

const SearchBar=()=>{
    return(
        <div>
        <form className="mt-4 flex justify-center" onSubmit={handleFormSubmit}>
          <div className="relative">
            <div className="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
              <MagnifyingGlassIcon className="h-4 w-4" />
            </div>
            <input
              type="text"
              id="simple-search"
              className=" text-sm rounded-lg  block w-full pl-10 p-2.5 ring-1  "
              placeholder="Jabatan, Kata Kunci, Perusahaan"
            />
          </div>

          <div className="relative ml-2">
            <div className="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
              <MagnifyingGlassIcon className="h-4 w-4" />
            </div>
            <input
              type="text"
              id="simple-search"
              className=" text-sm rounded-lg  block w-full pl-10 p-2.5 ring-1 "
              placeholder="Location"
            />
          </div>

          <div className="pl-2 ">
            <select
              id="countries"
              className=" text-sm rounded-lg  ring-1  block w-full p-2.5"
            >
              <option value="US">United States</option>
              <option value="CA">Canada</option>
              <option value="FR">France</option>
              <option value="DE">Germany</option>
            </select>
          </div>
          <button
            type="submit"
            className="p-2.5 ml-2 text-sm font-medium text-white bg-blue-700 rounded-lg border border-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
          >
            Search
            <span className="sr-only">Search</span>
          </button>
        </form>
      </div>
    )
}

export default SearchBar