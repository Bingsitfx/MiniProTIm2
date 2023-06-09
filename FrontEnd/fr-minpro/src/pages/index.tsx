import { Carousel } from "@material-tailwind/react";
import Image from "next/image";
import React, { useState, Fragment } from "react";
import { Button, Select, Option } from "@material-tailwind/react";
import {
  ChevronLeftIcon,
  ChevronRightIcon,
  ChevronDownIcon,
  MagnifyingGlassIcon,
} from "@heroicons/react/24/outline";
import Logo from "../../public/favicon.ico";

import {
  Accordion,
  AccordionHeader,
  AccordionBody,
} from "@material-tailwind/react";

const Home = () => {
  function Icon({ id, open }: any) {
    return (
      <svg
        xmlns="http://www.w3.org/2000/svg"
        className={`${
          id === open ? "rotate-180" : ""
        } h-5 w-5 transition-transform`}
        fill="none"
        viewBox="0 0 24 24"
        stroke="currentColor"
        strokeWidth={2}
      >
        <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
      </svg>
    );
  }

  const [active, setActive] = useState(1);

  // const getItemProps = (index: any) =>
  //   ({
  //     variant: active === index ? "filled" : "text",
  //     color: active === index ? "blue" : "blue-gray",
  //     onClick: () => setActive(index),
  //   } as any);

  const next = () => {
    if (active === 5) return;

    setActive(active + 1);
  };

  const prev = () => {
    if (active === 1) return;

    setActive(active - 1);
  };

  const handleFormSubmit = (event: any) => {
    event.preventDefault();
    // Tambahkan logika untuk menghandle submit form di sini
  };

  const [open, setOpen] = useState(1);

  const handleOpen = (value: any) => {
    setOpen(open === value ? 0 : value);
  };

  return (
    <div className="m-5 mx-10">
      <h1 className="text-lg">Our Network</h1>

      {/* Paging Image*/}
      <div className="relative flex w-full mt-7 flex justify-center items-center gap-4">
        <Button
          variant="text"
          color="blue-gray"
          className="flex items-center gap-2"
          onClick={prev}
          disabled={active === 1}
        >
          <ChevronLeftIcon strokeWidth={2} className="h-10 w-10" />
        </Button>
        <div className="flex relative items-center gap-8">
          <Image
            src={Logo}
            className="p-1"
            alt="profile picture"
            width={100}
            height={100}
          />
          <Image
            src={Logo}
            className="p-1"
            alt="profile picture"
            width={100}
            height={100}
          />
          <Image
            src={Logo}
            className="p-1"
            alt="profile picture"
            width={100}
            height={100}
          />
          <Image
            src={Logo}
            className="p-1"
            alt="profile picture"
            width={100}
            height={100}
          />
          <Image
            src={Logo}
            className="p-1"
            alt="profile picture"
            width={100}
            height={100}
          />
        </div>
        <Button
          variant="text"
          color="blue-gray"
          className="flex items-center gap-2"
          onClick={next}
          disabled={active === 5}
        >
          <ChevronRightIcon strokeWidth={2} className="h-10 w-10" />
        </Button>
      </div>

      {/* Search bar */}
      <div>
        <form className="mt-4 flex justify-center" onSubmit={handleFormSubmit}>
          <div className="relative">
            <div className="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
              <MagnifyingGlassIcon className="h-4 w-4" />
            </div>
            <input
              type="text"
              id="simple-search"
              className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
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
              className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
              placeholder="Location"
            />
          </div>

          <div className="pl-2 ">
            <select
              id="countries"
              className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
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
      <div className="mt-6 text-lg">100 Lowongan Kerja di Indonesia</div>

      <div className="pt-6 w-1/4">
        <Fragment>
          <Accordion open={open === 1}>
            <AccordionHeader onClick={() => handleOpen(0)}>
              What is Material Tailwind?
            </AccordionHeader>
            <AccordionBody>
              <Button className="mt-2 w-1/4 text-white border-rounded bg-blue-700">
                sadasdasdad
              </Button>
            </AccordionBody>
          </Accordion>
        </Fragment>
      </div>
    </div>
  );
};

export default Home;
