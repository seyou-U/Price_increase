import React from "react";
import { useEffect, useState } from 'react'

function ReturnTopButton() {
  const [isButton, setIsButton] = useState(false)

  function returnTop() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    })
  }

  useEffect(() => {
    window.addEventListener('scroll', scrollWindow)
    return () => {
      window.removeEventListener('scroll', scrollWindow)
    }
  }, [])

  function scrollWindow() {
      const top = 1000;
      let scroll = 0;
      scroll = window.scrollY;
      if (top <= scroll) {
        setIsButton(true);
      } else {
        setIsButton(false);
      }
    }
    const style = isButton ? dynamicStyle : normalStyle
  return <button style={style} onClick={returnTop}>TOPへ</button>;
}

const normalStyle = {
  opacity: 0,
  transition: "0.5s",
  pointerEvents: "none"
}
const dynamicStyle= {
  opacity: 1,
  transition: "0.5s",
  width: 110,
  height: 110,
  color: "#fff",
  fontSize: 20,
  fontWeight: "bold",
  borderColor: "#dc143c",
  background: "#ff0000",
  borderRadius: "50%",
  position: "fixed",
  bottom: 15,
  right: 50,
  zIndex: 1
}

export default ReturnTopButton
