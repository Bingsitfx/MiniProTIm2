import { Button } from "antd";
import Link from "next/link";
import React, { PropsWithChildren, useState, useEffect } from "react";
import { CookieValueTypes, getCookie } from "cookies-next";

const UserLayout = ({ children }: PropsWithChildren) => {
  const [haveToken, setHaveToken] = useState<CookieValueTypes>("");

  useEffect(() => {
    const token = getCookie("tokenGuest");
    setHaveToken(token);
  }, []);

  return (
    <>
      <h1>TOpbar</h1>
      {haveToken ? (
        <p>p</p>
      ) : (
        <Button>
          <Link href="/signin">Sign in</Link>
        </Button>
      )}
      {children}
    </>
  );
};

export default UserLayout;
