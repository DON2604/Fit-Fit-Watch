import React from "react";
import {
  FaUsers,
  FaNetworkWired,
  FaChartLine,
  FaClock,
  FaExchangeAlt,
} from "react-icons/fa";
import { GiChaingun } from "react-icons/gi";
import { TbMobiledata } from "react-icons/tb";
import { HiBuildingOffice2 } from "react-icons/hi2";

const page = () => {
  return (
    <div className="p-4 sm:ml-56 pt-6 bg-black text-white">
      <h1 className="text-white text-center text-2xl pb-4">
        P2P Network Dashboard
      </h1>
      <div className="p-4 border-2 border-zinc-700 border-dashed rounded-lg">
        <div className="grid grid-cols-2 md:grid-cols-2 gap-4 mb-4">
          <div className="flex items-center justify-center h-24 rounded bg-yellow-100">
            <div className="text-center">
              <p className="text-sm text-black font-bold flex">
                Connected Peers &nbsp;
                <GiChaingun className=" text-black font-bold text-xl" />
              </p>
              <p className="text-2xl text-black font-bold">1,234</p>
            </div>
          </div>
          <div className="flex items-center justify-center h-24 rounded bg-pink-200">
            <div className="text-center">
              <p className="text-sm text-black font-bold flex">
                Total Data Transferred &nbsp;
                <TbMobiledata className=" text-black font-bold text-xl" />
              </p>
              <p className="text-2xl text-black font-bold">1.5 TB</p>
            </div>
          </div>
        </div>
        <div className="grid grid-cols-3 gap-4 mb-4">
          <div className="flex flex-col items-center justify-center h-32 rounded bg-green-200 p-4">
            <div className="text-center">
              <p className="text-sm text-black font-bold flex">
                Organisations &nbsp;
                <HiBuildingOffice2  className="text-xl text-black font-bold" />
              </p>
              <p className="text-2xl text-black font-bold">10</p>
            </div>
          </div>
          <div className="flex flex-col items-center justify-center h-32 rounded bg-blue-200 p-4">
            <FaExchangeAlt className="text-3xl text-white mb-2" />
            <div className="text-center">
              <p className="text-xs text-black font-bold">Upload</p>
              <p className="text-lg text-black font-bold">500 GB</p>
              <p className="text-xs text-black font-bold">Download</p>
              <p className="text-lg text-black font-bold">1 TB</p>
            </div>
          </div>
          <div className="flex flex-col items-center justify-center h-32 rounded bg-orange-200 p-4">
            <FaClock className="text-3xl text-black font-bold mb-2" />
            <div className="text-center">
              <p className="text-xs text-black font-bold">Uptime</p>
              <p className="text-lg text-black font-bold">99.9%</p>
            </div>
          </div>
        </div>
        <div className="flex items-center justify-center h-24 mb-4 rounded bg-zinc-800">
          <div className="text-center">
            <p className="text-lg text-white">Most Active Peer</p>
            <p className="text-sm text-gray-400">Peer ID: 0x1a2b3c4d5e6f</p>
          </div>
        </div>
        <div className="flex items-center justify-center h-24 rounded bg-zinc-800">
          <div className="text-center">
            <p className="text-2xl text-white font-bold">Network Health</p>
            <p className="text-xl text-gray-400">Excellent</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default page;
