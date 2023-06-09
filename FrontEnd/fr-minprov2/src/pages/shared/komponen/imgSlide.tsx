import React, { useState, useEffect } from "react";
import { Button } from "antd";
import Image from "next/image";
import Logo from "../../../../public/favicon.ico";
import { LeftOutlined, RightOutlined } from "@ant-design/icons";
import Logo1 from '../../../../public/imageTest/headset-corsair.jpg'
import Logo2 from '../../../../public/imageTest/psu-1stplayer.jpg'
import Logo3 from '../../../../public/imageTest/psu-bequiet.jpg'
import Logo4 from '../../../../public/imageTest/ram-geil.jpg'
import Logo5 from '../../../../public/imageTest/ram-klev.jpg'

const ImgSlide = () => {
  const [active, setActive] = useState(1);

  const next = () => {
    if (active === 5) return;

    setActive(active + 1);
  };

  const prev = () => {
    if (active === 1) return;

    setActive(active - 1);
  };

    const imgLogo=[
        {src:Logo1},
        {src:Logo2},
        {src:Logo3},
        {src:Logo4},
        {src:Logo5},
    ]
    
//   const imgLogo = [
//     { src: Logo },
//     { src: Logo },
//     { src: Logo },
//     { src: Logo },
//     { src: Logo },
//   ];
  

  return (
    <div className="relative flex flex-col mt-7 md:flex-row md:items-center md:justify-center md:gap-4">
        <div className="md:order-first">
      <Button
        color="blue-gray"
        className="relative flex flex-warp items-center gap-2 flex-shrink-0"
        onClick={prev}
        disabled={active === 1}
      >
        <LeftOutlined className="p-3 h-10 w-10" />
      </Button>
      </div>
      <div className="flex flex-wrap relative items-center gap-8">
        {(imgLogo || []).map((mn) => (
            <div  className="rounded-b-lg shadow-xl hover:scale-110 transition-all duration-500 cursor-pointer">
          <Image
            src={mn.src}
            className="p-1"
            alt="profile picture"
            width={100}
            height={100}
          />
          </div>
        ))}
      </div>
      <div className="md:order-last">
      <Button
        color="blue-gray"
        className="relative flex flex-warp items-center gap-2 flex-shrink-0"
        onClick={next}
        disabled={active === 5}
      >
        <RightOutlined className="p-3 h-10 w-10" />
      </Button>
      </div>
    </div>
  );
};

export default ImgSlide;
