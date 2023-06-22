import Logo from "../../../../public/imageTest/ram-geil.jpg";
import Image from "next/image";
import {
  EnvironmentOutlined,
  FieldTimeOutlined,
  HistoryOutlined,
  ScheduleOutlined,
} from "@ant-design/icons";
import { useRouter } from "next/router";
import Link from "next/link";

const CardJob = (props: any) => {
  /* KONVERT JAM  */

  const getTimeAgoString = (startDate: any) => {
    const currentDate = new Date();
    const gmtOffset = 7 * 60 * 60 * 1000;
    currentDate.setTime(currentDate.getTime() + gmtOffset);
    const timeDiff = currentDate.getTime() - startDate.getTime();
    const diffInDays = Math.floor(timeDiff / (1000 * 3600 * 24));
    const diffInHours = Math.floor(timeDiff / (1000 * 3600));

    if (diffInDays > 0) {
      return `Diperbarui ${diffInDays} hari yang lalu`;
    } else if (diffInHours > 0) {
      return `Diperbarui ${diffInHours} jam yang lalu`;
    } else {
      return "Baru saja diperbarui";
    }
  };

  if (props.dataArray?.length === 0) {
    return (
      <div className="pt-10 text-center justify-center w-full lg:w-1/2 h-fit">
        <h1 className="font-base">
          <span className="font-bold text-lg">
            {" "}
            Maaf, tidak ada lowongan ditemukan{" "}
          </span>
          <br></br> Cek typo atau coba kata kunci lain. Kamu juga bisa lihat
          rekomendasi pekerjaan untukmu
        </h1>
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 gap-4 md:grid-cols-1 lg:grid-cols-1 xl:grid-cols-2 ">
      {(props.dataArray || []).map((data: any) => {
        const startDate = new Date(data.jopo_modified_date);
        const timeAgoString = getTimeAgoString(startDate);

        if (data.jopo_status === "publish" && data.jopo_open === "1") {
          return (
            <Link
              href={{
                pathname: "jobs/jobdetail",
                query: {
                  id: data.jopo_entity_id,
                },
              }}
            >
              <div className="flex flex-wrap">
                <div className="w-[450px] lg:w-[500px] hover:opacity-70 transition ease-in-out pb-1">
                  <div className="bg-white border shadow-lg p-3 block ">
                    <div className="flex">
                      <img
                        src={`http://localhost:3003/images/${data.jopho_filename}`}
                        alt="gambar"
                        height={100}
                        width={100}
                      />
                      <div>
                        <h1 className="pl-5 text-xl font-bold max-w-xs ">
                          {data.jopo_title}
                        </h1>
                        <h2 className="pl-5 text-lg font-light max-w-xs ">
                          {data.clit_name}
                        </h2>
                      </div>
                    </div>
                    <div className="pt-6">
                      <div className="flex">
                        <EnvironmentOutlined className="pt-1" />
                        <h3 className="pl-2 text-base font-semibold">
                          {data.city_name}
                        </h3>
                      </div>
                      <div className="flex">
                        <FieldTimeOutlined className="pt-1" />
                        <h3 className="pl-2 text-base font-semibold">
                          {data.jopo_min_experience} -{" "}
                          {data.jopo_max_experience} Tahun
                        </h3>
                      </div>
                      <div className="flex justify-between pt-2">
                        <div className="flex bg-orange-400 rounded-md px-1">
                          <ScheduleOutlined className="pt-1" />
                          <h3 className="pl-2 text-base font-semibold">
                            Actively Hiring
                          </h3>
                        </div>
                        <div className="flex pr-2">
                          <HistoryOutlined className="pt-1" />
                          <h3 className="pl-2 text-base font-semibold">
                            {timeAgoString}
                          </h3>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </Link>
          );
        }
      })}
    </div>
  );
};

export default CardJob;
