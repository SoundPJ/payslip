"use client";

//TODO ** middleware should handle this route **
//TODO if (pathname === "/api-docs" && process.env.NODE_ENV === "production") {
//TODO   return NextResponse.redirect("/");
//TODO }

import { useEffect } from "react";
import "swagger-ui-dist/swagger-ui.css";

export default function ApiDocs() {
  useEffect(() => {
    import("swagger-ui-dist/swagger-ui-bundle.js").then((mod) => {
      const SwaggerUI = mod.default;

      SwaggerUI({
        url: "/swagger.json",
        dom_id: "#swagger-ui",
      });
    });
  }, []);
  if (process.env.NODE_ENV === "production") {
    return ("NOT FOUND");
  }
  return (
    <main style={{ background: "white", minHeight: "100vh" }}>
      <div id="swagger-ui" />
    </main>
  );
}