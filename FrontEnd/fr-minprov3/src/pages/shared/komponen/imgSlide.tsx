// import React, { useState, useEffect } from "react";
// import { Button } from "antd";
// import Image from "next/image";
// import Logo from "../../../../public/favicon.ico";
// import { LeftOutlined, RightOutlined } from "@ant-design/icons";
// import Logo1 from "../../../../public/imageTest/headset-corsair.jpg";
// import Logo2 from "../../../../public/imageTest/psu-1stplayer.jpg";
// import Logo3 from "../../../../public/imageTest/psu-bequiet.jpg";
// import Logo4 from "../../../../public/imageTest/ram-geil.jpg";
// import Logo5 from "../../../../public/imageTest/ram-klev.jpg";

// const ImgSlide = () => {
//   const [active, setActive] = useState(1);

//   const next = () => {
//     if (active === 5) return;

//     setActive(active + 1);
//   };

//   const prev = () => {
//     if (active === 1) return;

//     setActive(active - 1);
//   };

//   const imgLogo = [
//     { src: Logo1 },
//     { src: Logo2 },
//     { src: Logo3 },
//     { src: Logo4 },
//     { src: Logo5 },
//     { src: Logo1 },
//     { src: Logo2 },
//     { src: Logo3 },
//     { src: Logo4 },
//     { src: Logo5 },
//   ];

//   const numVisibleImages = 5;
// const visibleImages = imgLogo.slice(0, numVisibleImages);

//   useEffect(() => {
//     const handleResize = () => {
//       if (window.innerWidth < 768) {
//         setActive(1);
//       } else if (window.innerWidth < 1024) {
//         setActive(2);
//       } else {
//         setActive(3);
//       }
//       // Tambahkan logika penyesuaian jumlah gambar yang ditampilkan di sini
//     };

//     handleResize();

//     window.addEventListener("resize", handleResize);

//     return () => {
//       window.removeEventListener("resize", handleResize);
//     };
//   }, []);

//   return (
//     <div className="flex flex-wrap mt-3 justify-center">
//       <div className="order-first flex items-center">
//         <Button
//           color="blue-gray"
//           className="flex items-center mr-3"
//           onClick={prev}
//           disabled={active === 1}
//         >
//           <LeftOutlined className="" />
//         </Button>
//       </div>
//       <div className="flex flex-wrap items-center">
//         {(visibleImages || []).map((mn, index) => (
//           <div
//             className={`rounded-b-lg shadow-xl hover:scale-110 transition-all duration-500 cursor-pointer ${
//               index >= active ? "hidden" : ""
//             } sm:hidden md:block lg:block xl:block`}
//             key={index}
//           >
//             <Image
//               src={mn.src}
//               className="p-1"
//               alt="profile picture"
//               width={100}
//               height={100}
//             />
//           </div>
//         ))}
//       </div>
//       <div className="order-last flex items-center">
//         <Button
//           color="blue-gray"
//           className="flex items-center ml-3"
//           onClick={next}
//           disabled={active === 5}
//         >
//           <RightOutlined className="items-center" />
//         </Button>
//       </div>
//     </div>
//   );
// };


import { doRequestGetJobPost } from "@/pages/redux/JobhireSchema/action/actionreducer";
import React, { useEffect } from "react";
import { useDispatch, useSelector } from 'react-redux'

import Slider from "react-slick";


const ImgSlide=()=>{
  const { job_post, refresh } = useSelector((state:any) => state.JobPostReducers,);
  const dispatch = useDispatch();

  useEffect(()=>{
    dispatch(doRequestGetJobPost())
    // console.log('photo',job_photo);
  },[refresh])

  const settings = {
    arrows: false,
    autoplay: true,
    autoplayspeed: 500,
    dots: false,
    infinite: true,
    speed: 500,
    slidesToShow: 2,
    slidesToScroll: 1,
  };

  return (
    <div>
      <Slider {...settings}>
        {(job_post || []).map((photo:any) => (
          <div
          className="p-2"
          
          >
            <div className="drop-shadow bg-white h-28 rounded-md flex items-center justify-center">
            <img
              src={`http://localhost:3003/images/${photo.jopho_filename}`}
              className="object-contain h-28 w-auto"
              alt="profile picture"
            />
            </div>
          </div>
        ))}
      </Slider>
    </div>
  );
}

export default ImgSlide;
