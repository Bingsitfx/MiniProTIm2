import React from 'react'
import {
  MagnifyingGlassIcon
} from "@heroicons/react/24/outline";

const handleFormSubmit = (event: any) => {
  event.preventDefault();
  // Tambahkan logika untuk menghandle submit form di sini
};

const SearchBar = () => {
  return (
    <div>
      <form className="mt-5 flex flex-wrap" onSubmit={handleFormSubmit}>
        <div className="relative">
          <div className="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <MagnifyingGlassIcon className="h-4 w-4" />
          </div>
          <input
            type="text"
            id="simple-search"
            className=" text-sm rounded-lg block w-[36rem] pl-10 p-2.5 ring-1 "
            placeholder="Jabatan, Kata Kunci, Perusahaan"
          />
        </div>

        <div className="relative ml-3">
          <div className="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <MagnifyingGlassIcon className="h-4 w-4" />
          </div>
          <input
            type="text"
            id="simple-search"
            className=" text-sm rounded-lg  block w-96 pl-10 p-2.5 ring-1 "
            placeholder="Location"
          />
        </div>

        <div className='ml-3'>
          <select
            id="countries"
            className=" text-sm rounded-lg  ring-1  block w-40 p-2.5"
          >
            <option value="US">IT Programmer</option>
            <option value="CA">UX Design</option>
            <option value="FR">Networking</option>
            <option value="DE">Modelling</option>
          </select>
        </div>
        
        <button
          type="submit"
          className="p-2.5 w-32 ml-3 text-sm font-medium text-white bg-blue-700 rounded-lg border border-blue-700 hover:bg-blue-800 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 "
        >
          Search
          <span className="sr-only">Search</span>
        </button>
      </form>
    </div>
  )
}

export default SearchBar