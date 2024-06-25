'use client';

import Link from "next/link";
import React from "react";

const Sidebar = () => {

  return (
    <>
      <aside
        id="logo-sidebar"
        className="fixed top-0 left-0 z-40 w-52 h-screen transition-transform -translate-x-full sm:translate-x-0"
        aria-label="Sidebar"
      >
        <div className="h-full px-3 py-4 overflow-y-auto bg-gray-50 dark:bg-zinc-800 rounded-r-2xl">
          <Link href="/dashboard" className="flex items-center justify-center h-16 mb-5">
            <img
              src="https://img.icons8.com/?size=100&id=fg8iJn7Kq0qQ&format=png&color=000000"
              className="h-6 sm:h-16"
              alt="Flowbite Logo"
            />
          </Link>
          <ul className="space-y-2 font-medium">
            <li>
              <Link
                className="flex items-center p-2 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 "
                href="/dashboard"
              >
                <span className="ms-3">Dashboard</span>
              </Link>
            </li>
            <li>
            <Link
            className="flex items-center p-2 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 "
            href="/inbox"
          >
            <span className="ms-3">Inbox</span>
          </Link>
            </li>
            <li>
              <Link
                href="#"
                className="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
              >
                <span className="flex-1 ms-3 whitespace-nowrap">Users</span>
              </Link>
            </li>
            <li>
              <Link
                href="#"
                className="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
              >
                <span className="flex-1 ms-3 whitespace-nowrap">BCT</span>
              </Link>
            </li>
          </ul>
        </div>
      </aside>
    </>
  );
};

export default Sidebar;