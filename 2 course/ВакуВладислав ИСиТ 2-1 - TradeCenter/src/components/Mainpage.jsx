// All This mess was made by Vladislav. Enjoy ;)

// изображния 
import aboutus_video from '../video/Toyota Supra - Cinematic.mp4'
import garage_img from '../img/garage/tradecenter-garage5.jpg';
import more_cars from '../img/cars/more2.jpg'
import '../style/style.css'

// для роутинга
import { Routes, Route, Link } from 'react-router-dom'

// для 3Д-моделей
import {Canvas} from '@react-three/fiber'
import {OrbitControls} from '@react-three/drei'
import React, {Suspense, useState} from 'react';
import Iphone from './Iphone'

// для тестов
import Counter from './additional requirements/Counter';

// для кастомных хуков
import {useKeyPress} from './additional requirements/Custom-hooks'

// работа с ref
import CustomTextInput from './additional requirements/CustomTextInput'

// redux



// ф-ия для кастомного хука (записвыет значения выбранного автомобиля в перемнную new_car)
function CarChoiceFunc(param) {
  let new_car = param;
  console.log("Client's car is " + new_car)
}

const Mainpage = () => {

   
    // объекты кастомного хука, которые передают ему значения клавиш, для которых нужно сделать обработку
    const supraKey = useKeyPress('s')
    const impalaKey = useKeyPress('i')
    const chargerKey = useKeyPress('c')
    const bugattiKey = useKeyPress('b')
    const astonKey = useKeyPress('a')
    const deloreanKey = useKeyPress('d')
    const nftKey = useKeyPress('t')
    const e30Key = useKeyPress('e')
    const nissanGTRKey = useKeyPress('n')

    // переменная для заголовка выбранного автомобиля через зажатую клавишу
    const customHeader = 'Вы выбрали: ';
    

    return (
        <div className="html-block">
            <header className="main-header">
        <iframe id="myIframe" src='https://my.spline.design/untitled-af13d19296022e05c327f5ca46bd332b/' frameBorder='0'></iframe>
        <h1 className="header-h1"><span className="header-span">TradeCenter</span><br />Обладай<br />Мечтой</h1>
      </header>

    <div className="main-content">
      <div className="about-us">
        <video className="aboutus-video" autoPlay muted loop>
          <source src={aboutus_video}></source>
        </video>
        <h1 data-aos="fade-right" data-aos-duration="300" className="aboutus-h1">Кто мы такие?</h1>
        <p data-aos="fade-right" data-aos-duration="600" className="aboutus-p">
          <span className="aboutus-p-span">TradeCenter</span> - профессиональный серивис, который
          помогает людям по всему <span className="aboutus-p-span">миру</span> найти машину 
          своей мечты. Будь то <span className="aboutus-p-span">Toyota Supra</span> из второго <span className="aboutus-p-span">Форсажа </span>
          или <span className="aboutus-p-span">DeLorean </span>из фильма <span className="aboutus-p-span">Назад в Будущее</span>.
        </p>
      </div>

      <div className="garage">
        <img className="garage-bg" src={garage_img} />
        <h1 data-aos="fade-right" data-aos-duration="300" className="garage-h1">Гараж Популярных Авто</h1>
        <div data-aos="fade-right" data-aos-duration="600" className="garage-iframe-container">
          <div className="gar-ifr-cont-1-3">
            <div class="sketchfab-embed-wrapper"> <iframe frameBorder="0" allowFullScreen mozallowFullScreen="true" webkitallowFullScreen="true" allow="autoplay; fullscreen; xr-spatial-tracking" xr-spatial-tracking execution-while-out-of-viewport execution-while-not-rendered web-share src="https://sketchfab.com/models/2d2f85944d1b4744a9724596751cb93e/embed"> </iframe> </div>
            <div class="sketchfab-embed-wrapper"> <iframe title="Chevrolet Impala 1967- supernatural" frameBorder="0" allowFullScreen mozallowFullScreen="true" webkitallowFullScreen="true" allow="autoplay; fullscreen; xr-spatial-tracking" xr-spatial-tracking execution-while-out-of-viewport execution-while-not-rendered web-share src="https://sketchfab.com/models/cb03ce730658410499f084c493f142bd/embed"> </iframe> </div>
            <div class="sketchfab-embed-wrapper"> <iframe title="Nissan GTR R35 NISMO Download" frameBorder="0" allowFullScreen mozallowFullScreen="true" webkitallowFullScreen="true" allow="autoplay; fullscreen; xr-spatial-tracking" xr-spatial-tracking execution-while-out-of-viewport execution-while-not-rendered web-share src="https://sketchfab.com/models/413753e2b98f42dd8aab986c31e98430/embed"></iframe> </div>
          </div>
          <div className="gar-ifr-cont-1-3">
            <div class="sketchfab-embed-wrapper"> <iframe title="Back To The Future Tribute - For Sketchfab" frameBorder="0" allowFullScreen mozallowFullScreen="true" webkitallowFullScreen="true" allow="autoplay; fullscreen; xr-spatial-tracking" xr-spatial-tracking execution-while-out-of-viewport execution-while-not-rendered web-share src="https://sketchfab.com/models/a95e48f00a8245c997d365f0b46158ea/embed"> </iframe> </div>
            <div class="sketchfab-embed-wrapper"> <iframe title="McLaren 720s Spider" frameBorder="0" allowFullScreen mozallowFullScreen="true" webkitallowFullScreen="true" allow="autoplay; fullscreen; xr-spatial-tracking" xr-spatial-tracking execution-while-out-of-viewport execution-while-not-rendered web-share src="https://sketchfab.com/models/55daa3225615481baabd98e2d3226b0f/embed"> </iframe> </div>
            
            <div className="more-cars-container">
              <Link to="/auto"><img class="more-cars" src={more_cars}/>
              <h2 className="more-cars-caption">Больше...</h2></Link>
            </div>
          </div>
        </div>
      </div>



    <div className="contacts">


      {/* 3D-модель IPhone */}
         <Canvas className="canvas-container">
          <OrbitControls enableZoom={false} />
          <ambientLight intensity={0.5} />
          <directionalLight position={[-2, 5, 2]} intensity={1} />
          <Suspense fallback={null}>
            <Iphone />
          </Suspense>
        </Canvas>


      <form data-aos="fade-right" data-aos-duration="300">
        <h1 data-aos="fade-right" data-aos-duration="350">Оставить заявку на покупку автомобиля</h1>
        {/* два автозаполняемых input с именем и почтой (работа с ref) */}
        <CustomTextInput></CustomTextInput>
        <select data-aos="fade-right" data-aos-duration="500" required>
          <option>Выберите автомобиль или его 1-ю букву</option>
          <option>Toyota Supra (s)</option>
          <option>Chevrolet Impala 1967 supernatural (i)</option>
          <option>Dodge Charger (c)</option>
          <option>Bugatti Chiron 2016 (b)</option>
          <option>Aston Martin (a)</option>
          <option>Back To The Future DeLorean (d)</option>
          <option>BMW NFT (t)</option>
          <option>BMW NFS (f)</option>
          <option>Nissan GTR R35 NISMO (n)</option>
        </select>

        <Counter className="conter-component" initialCount={0}/>

      {/* кастомный хук */}
      <div className="customHooks">
         {/* если supraKey (s) - true (если наш кастомный хук возваращет, что наша клавиша (s) зажата), то выводим customHeader */}
         {(supraKey || impalaKey || chargerKey
          || bugattiKey || astonKey || deloreanKey
          || nftKey || e30Key || nissanGTRKey) && customHeader}

        {/* соответственно и для ф-ии CarChoiceFunc (она записывает выбранный авто-ль в перем-ю) и текста Toyota Supra */}
        {supraKey && CarChoiceFunc('Toyota Supra')}
        {supraKey && 'Toyota Supra'}

        {impalaKey && CarChoiceFunc('Chevrolet Impala 1967 supernatural')}
        {impalaKey && 'Chevrolet Impala 1967 supernatural' }

        {chargerKey && CarChoiceFunc('Dodge Charger')}
        {chargerKey && 'Dodge Charger'}

        {bugattiKey && CarChoiceFunc('Bugatti Chiron 2016')}
        {bugattiKey && 'Bugatti Chiron 2016'}

        {astonKey && CarChoiceFunc('Aston Martin')}
        {astonKey && 'Aston Martin'}

        {deloreanKey && CarChoiceFunc('Back To The Future DeLorean')}
        {deloreanKey && 'Back To The Future DeLorean'}

        {nftKey && CarChoiceFunc('BMW NFT')}
        {nftKey && 'BMW NFT'}

        {e30Key && CarChoiceFunc('Dodge Charger')}
        {e30Key && 'BMW NFS'}

        {nissanGTRKey && CarChoiceFunc('Nissan GTR R35 NISMO')}
        {nissanGTRKey && 'Nissan GTR R35 NISMO'}
      </div>
          
      
        <div className="div4submit">
          <input data-aos="fade-right" data-aos-duration="550" type="submit" value='Отправить заявку' />
        </div>
      </form>
      {/* Counter - ф-ия для которой прописаны тесты */}
      
      {/* <Car name="Vladik" /> */}
    </div>
   
    </div>
    </div>
    )
}

export {Mainpage}