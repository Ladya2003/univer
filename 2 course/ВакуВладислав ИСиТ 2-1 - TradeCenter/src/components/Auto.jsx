import '../style/auto.css';
import car1 from '../img/cars/supra.jpg';
import car2 from '../img/cars/impala.jpg';
import car3 from '../img/cars/dom dodge charger.jpg';
import car4 from '../img/cars/bugatto chiron.jpg';
import car5 from '../img/cars/ason martin.jpg';
import car6 from '../img/cars/back-to-the-future-doloren.jpg';
import car7 from '../img/cars/bmw racecar.jpg';
import car8 from '../img/cars/bmw1.jpg';
import car9 from '../img/cars/nissan gtr.jpg';

import { Routes, Route, Link } from 'react-router-dom'
import React, {useState} from 'react';
import { useDispatch } from 'react-redux';
// redux comps
import { addTodo } from '../store/todoSlice';
import NewTodoForm from './NewTodoForm';
import TodoList from './TodoList';

const Auto = () => {

    // redux
   const [text, setText] = useState('Ваш комментарий');
   const dispatch = useDispatch();
 
   const handleAction = () => {
    // текст который мы заносим в наш input, передается в качестве объекта нашему срезу в событие addTodo с помощью хука dispatch
     if(text.trim().length) {
      // dispatch передает события в срезы. Все эти данные передаются вторым параметрам action в наши события
       dispatch(addTodo({text}));
       setText('');
     }
   }

    return (
        <div className="content-container">
            <h1 data-aos="fade-right" data-aos-duration="300" className="main-h1">Коллекция всех автомобилей</h1>
            <div className="cars-conteiner">
                <div className="cars-conteiner1-3">
                    <div data-aos="fade-right" data-aos-duration="350" className="single-car-container">
                        <Link to="/supra"><img className="single-car" src={car1} />
                            <h3 className="car-caption">Больше информации</h3>
                        </Link>
                        <h3 className="car-name">Toyota Supra Fast 2010</h3>
                    </div>
                    <div data-aos="fade-right" data-aos-duration="400" className="single-car-container">
                        <Link to="/impala"><img className="single-car" src={car2} />
                            <h3 className="car-caption">Больше информации</h3>
                        </Link>
                        <h3 className="car-name">Chevrolet Impala 1967</h3>
                    </div>
                    <div data-aos="fade-right" data-aos-duration="450" className="single-car-container">
                        <Link to="/charger"><img className="single-car" src={car3} />
                            <h3 className="car-caption">Больше информации</h3>
                        </Link>
                        <h3 className="car-name">Dodge Charger 1969</h3>
                    </div>
                </div>

                <div className="cars-conteiner1-3">
                    <div data-aos="fade-right" data-aos-duration="500" className="single-car-container">
                        <Link to="/bugatti"><img className="single-car" src={car4} />
                        <h3 className="car-caption">Больше информации</h3>
                        </Link>
                        <h3 className="car-name">Bugatti Chiron 2016</h3>
                        
                    </div>
                    <div data-aos="fade-right" data-aos-duration="550" className="single-car-container">
                        <Link to="/astonmartin"><img className="single-car" src={car5} />
                        <h3 className="car-caption">Больше информации</h3>
                        </Link>
                        <h3 className="car-name">Aston Martin 1965</h3>
                        
                    </div>
                    <div data-aos="fade-right" data-aos-duration="600" className="single-car-container">
                        <Link to="/delorean"><img className="single-car" src={car6} />
                        <h3 className="car-caption">Больше информации</h3>
                        </Link>
                        <h3 className="car-name">DeLorean 1983</h3>
                    </div>
                </div>

                <div className="cars-conteiner1-3">
                    <div data-aos="fade-right" data-aos-duration="650" className="single-car-container">
                        <Link to="/bmwnft"><img className="single-car" src={car7} />
                        <h3 className="car-caption">Больше информации</h3>
                        </Link>
                        <h3 className="car-name">BMW NFT</h3>
                    </div>
                    <div data-aos="fade-right" data-aos-duration="700" className="single-car-container">
                        <Link to="/nfsbmw"><img className="single-car" src={car8} />
                        <h3 className="car-caption">Больше информации</h3>
                        </Link>
                        <h3 className="car-name">NFS BMW</h3>
                    </div>
                    <div data-aos="fade-right" data-aos-duration="750" className="single-car-container">
                        <Link to="/nissangtr"><img className="single-car" src={car9} />
                        <h3 className="car-caption">Больше информации</h3>
                        </Link>
                        <h3 className="car-name">Nissan GTR NISMO</h3>
                    </div>
                </div>
            </div>
                <div className="comments-main-container">
                    <NewTodoForm
                        value={text}
                        updateText={setText}
                        handleAction={handleAction}
                        />
                        <h2 className="comments-h2">Комментарии</h2>
                        <TodoList />
                </div>
        </div>
    )
}

export {Auto}