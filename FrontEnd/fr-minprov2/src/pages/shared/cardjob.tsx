import { Button } from "@material-tailwind/react";
import Logo from "../../../public/imageTest/ram-geil.jpg";
import Image from "next/image";
import {
  EnvironmentOutlined,
  FieldTimeOutlined,
  HistoryOutlined,
  ScheduleOutlined,
} from "@ant-design/icons";


const CardJob = (dataArray:any) => {

    console.log(dataArray.dataArray)
  return (
    <div className=" grid grid-cols-2 gap-8 relative pl-8 " style={{ gridAutoRows: 'min-content' }}>
      {(dataArray.dataArray || []).map((data:any) => (
        <div > 
        <a
          href="#"
          className="block max-h-60 max-w-md p-6 rounded-md bg-white border border-black-700 shadow hover:bg-gray-100 dark:border-gray-300"
        >
          <div className="flex">
            <Image src={Logo} alt="gambar" height={80} width={80} />

            <h5 className="ml-8 mb-2 text-2xl font-bold tracking-tight text-black-900">
              {data.namaCompany}
            </h5>
          </div>

          <div className="mt-5 flex">
            <EnvironmentOutlined className="mt-1" />
            <p className="ml-2 font-semibold text-black-700">{data.loc}</p>
          </div>

          <div className="mt-1 flex">
            <FieldTimeOutlined className="mt-1" />
            <p className="ml-2 font-semibold text-black-700 ">{data.expe}</p>
          </div>

          <div className="mt-1 flex justify-between">
            <div className="flex bg-orange-400 rounded-md px-1">
              <ScheduleOutlined className="mt-1" />
              <p className="ml-3 font-semibold text-black-700 ">
                {data.freq}
              </p>
            </div>
            <div className="flex">
              <HistoryOutlined className="mt-1" />
              <p className="ml-2 font-light text-black-700 ">
                {data.lastmod}
              </p>
            </div>
          </div>
        </a>
        </div>
      ))}
    </div>
  );
};

export default CardJob
