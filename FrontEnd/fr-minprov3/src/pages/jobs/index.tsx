import { useEffect, useState } from "react";
import CardJob from "../shared/komponen/cardjob";
import FilterComp from "../shared/komponen/filterKomponen";
import ImgSlide from "../shared/komponen/imgSlide";
import Pagination from "../shared/komponen/pagination";
import { company } from "../shared/komponen/data";
import SearchBar from "../shared/komponen/search";
import { useDispatch, useSelector } from "react-redux";
import { doRequestGetJobPost } from "../redux/JobhireSchema/action/actionreducer";

export default function Home() {
  const dispatch = useDispatch();

  let { job_post, refresh } = useSelector(
    (state: any) => state.JobPostReducers
  );

  useEffect(() => {
    dispatch(doRequestGetJobPost());
  }, [refresh]);

  /* ````````````` */

  const [selectedValue, setSelectedValue] = useState("all");
  const [searchValue, setSearchValue] = useState("");
  const [searchLocation, setSearchLocation] = useState("");
  const [isSearching, setIsSearching] = useState(false);
  const [filteredData, setFilteredData]: any = useState([]);

  const handleChange = (event: any) => {
    setSelectedValue(event.target.value);
  };

  const handleSearchChange = () => {
    setIsSearching(true);
    let filtered = job_post;
    if (selectedValue !== "all") {
      filtered = filtered.filter((item: { joro_name: string }) =>
        item.joro_name.toLowerCase().includes(selectedValue.toLowerCase())
      );
    }

    if (searchValue) {
      filtered = filtered.filter(
        (item: { jopo_title: string; clit_name: string }) =>
          item.jopo_title.toLowerCase().includes(searchValue.toLowerCase()) ||
          item.clit_name.toLowerCase().includes(searchValue.toLowerCase())
      );
    }

    if (searchLocation) {
      filtered = filtered.filter(
        (item: { city_name: string; prov_name: string }) =>
          item.city_name.toLowerCase().includes(searchLocation.toLowerCase()) ||
          item.prov_name.toLowerCase().includes(searchLocation.toLowerCase())
      );
    }

    setFilteredData(filtered);
  };

  const displayData = isSearching ? filteredData : job_post;

  /* ````````````` */

  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(6);
  const totalPages = Math.ceil(displayData?.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;
  const currentItems = displayData?.slice(startIndex, endIndex);

  const handlePageChange = (page: any) => {
    setCurrentPage(page);
  };

  return (
    <div className="container">
      <div className="mx-5 pt-24">
        <h1 className=" text-lg">Our Network</h1>
        <div className="mb-4 border-2  p-2.5">
          <ImgSlide />
        </div>
        <div className="border-2 b p-2.5">
          <SearchBar
            buttonClick={handleSearchChange}
            searchValue={searchValue}
            searchLocation={searchLocation}
            setSearchValue={(e: any) => setSearchValue(e.target.value)}
            setSearchLocation={(e: any) => setSearchLocation(e.target.value)}
            selectedValue={selectedValue}
            handleChange={handleChange}
          />
        </div>
        <h2 className="py-5 text-lg">100 Lowongan Pekerjaan di Indonesia</h2>
        <div className=" p-2.5 border-2">
          <div className="flex flex-wrap lg:flex-none">
            <FilterComp />
            <CardJob dataArray={currentItems} />
          </div>
          <Pagination
            totalPages={totalPages}
            currentPage={currentPage}
            handlePageChange={handlePageChange}
          ></Pagination>
        </div>
      </div>
    </div>
  );
}
