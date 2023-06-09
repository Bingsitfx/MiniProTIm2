import { useState } from "react";
import CardJob from "./shared/cardjob";
import FilterComp from "./shared/filterKomponen";
import ImgSlide from "./shared/komponen/imgSlide";
import Pagination from "./shared/komponen/pagination";
import { company } from '../pages/shared/komponen/data'
import SearchBar from "./shared/komponen/search";





export default function Home() {
  const [currentPage, setCurrentPage] = useState(1);
    const [itemsPerPage, setItemsPerPage] = useState(6);
    const totalPages = Math.ceil(company?.length / itemsPerPage);
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const currentItems = company?.slice(startIndex, endIndex);
  
    const handlePageChange = (page: any) => {
      setCurrentPage(page);
    };
    
  return (
    <div className="m-10">
      <h1 className="pl-10 pt-3 text-lg">Our Network</h1>
      <ImgSlide />
      <SearchBar/>
      <h2 className="py-5 text-lg">100 Lowongan Pekerjaan di Indonesia</h2>
      <div className="flex">
        <FilterComp />
        <CardJob dataArray={currentItems}/>
      </div>
      <Pagination  totalPages={totalPages} currentPage={currentPage} handlePageChange={handlePageChange}></Pagination>
    </div>
  );
}
