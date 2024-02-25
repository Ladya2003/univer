import nav_logo from './img/logo/tradecenter-logo2.png'
import bg_img from './img/space-bg5.jpg'
import insta from './img/instagram-icon.png'
import vk from './img/vk-icon3.png'
import campfire from './img/Campfire2.png'
import search_icon from './img/search-el2.png'

import { Routes, Route, Link } from 'react-router-dom'
import { Mainpage } from './components/Mainpage'
import { Auto } from './components/Auto'

import { Supra, Impala, Charger, Bugatti, AstonMartin, Delorean, BMWNFT, BMWNFS, NissanGTR } from './components/AllCars'

import CarsData from './components/CarsData'

import './style/style.css'
import React, {Suspense, useState} from 'react';




function App() {

  // хуки для поиска
  const [searchInput, setSearchInput] = useState("");
  const [searchShow, setsearchShow] = useState(true);


  // скрывает блок поиска (setTimeout нужен для того, чтобы дать небольшую задержку для закрытия, которая нужна)
  // если пользователь захочет кликнуть на ссылку в поиске
  const searchBLockShow = (par) => {
    setTimeout(() => setsearchShow(par => !par), 210);
  };

  // показывает блок поиска 
  const searchBLockHide = (par) => {
    setsearchShow(par => !par);
  };

  
  return (
    <div className="html-block">
      <img className="bg-img" src={bg_img} />

      <nav className="main-nav">
        <img className="nav-logo" src={nav_logo} />
        <div className="search-container2">
          <img className="search_icon" src={search_icon} />
          <input 
            className="search-input"
            type="text" 
            placeholder="Поиск авто"
            onChange={(event) => setSearchInput(event.target.value)} 
            onClick={searchBLockHide}
            onBlur={searchBLockShow}
          />
        </div>

        <div className="nav-content-container">
          <Link to="/"><h2 className="nav-content">Главная</h2></Link>
          <Link to="/auto"><h2 className="nav-content">Автомобили</h2></Link>
          <a href="#contacts"><h2 className="nav-content">Контакты</h2></a>
        </div>
      </nav>


      <div id="search-block" style={{display: searchShow ? 'none' : 'block'}} className="search-resault-container">
              <h1 className="search-res-h1">Результат поиска: </h1>
              <div className="search-resault-container2">
                {CarsData.filter((val) => {
                      if (searchInput == "") {
                        return 0;
                      }
                      else if (val.name.toLowerCase().includes(searchInput.toLowerCase())) {
                        return val
                      }
                }).map((val) => {
                  return (
                    <>
                      <div key={val.id} className="single-car22">
                          <Link to={val.linkto}><img className="search-car-img" src={val.img_src} /></Link>
                          <h3 className="search-car-h3">{val.name}</h3>
                      </div>
                    </>
                  )})}
              </div>
            </div>


      <Routes>

        <Route path="/" element={<Mainpage />}></Route>
        <Route path="/auto" element={<Auto />}></Route>
        <Route path="/" element={<Mainpage />}></Route>
        
        <Route path="/supra" element={<Supra />}></Route>
        <Route path="/impala" element={<Impala />}></Route>
        <Route path="/charger" element={<Charger />}></Route>
        <Route path="/bugatti" element={<Bugatti />}></Route>
        <Route path="/astonmartin" element={<AstonMartin />}></Route>
        <Route path="/delorean" element={<Delorean />}></Route>
        <Route path="/bmwnft" element={<BMWNFT />}></Route>
        <Route path="/nfsbmw" element={<BMWNFS />}></Route>
        <Route path="/nissangtr" element={<NissanGTR />}></Route>
      </Routes>
      
      <footer id="contacts" className="main-footer">
      <p className="footer-p">
      <strong>TradeCenter</strong> - хотя выглядит бесподобно, что я бы и сам вложил большие деньги в его развитие 
      и рекламу, является некоммерческим, сделанным специально в рамках курсовой работы 
      в 3 семестре учебы в учреждении БГТУ, проектом.
      </p>
      <div className="author">
        <div className="design">Дизайн и реализация:</div>
        <div className="me">Вакуленчик Владислав ИСиТ 2-1</div>
        <div className="socials">
          <a href="https://www.instagram.com/mega.vlad0n/"><img src={insta} /></a>
          <a href="https://vk.com/itsvladiatorbeach"><img src={vk} /></a>
          <a href="https://ladya2003.github.io/campfire/"><img src={campfire} /></a>
        </div>
      </div>
      <hr className="hr-footer"/>
      <p className="footer-copyright">
        Copyright © 2022 Vladislav Vakulenchik. All rights reserved.
      </p>
    </footer>
    </div>
  );
}

export default App;
