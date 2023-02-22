import { PageHeader } from "antd";
import React from "react";

// displays a page header

export default function Header() {
  return (
    <a href="https://yugasi.com" target="_blank" rel="noopener noreferrer">
      <PageHeader title="🪦 Yugasi" subTitle="Immortalize, own, and share your digital legacy. (and be awesome)" style={{ cursor: "pointer" }} />
    </a>
  );
}
