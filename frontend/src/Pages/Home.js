import React from "react";
import { useTranslation } from 'react-i18next';
import 'bootstrap/dist/css/bootstrap.min.css';
import home_img from '../img/home_img.png';

const Home = () => {
    
    // General configuration
    const { t } = useTranslation();

    return (
        <div id="change" className="container">
            <div className="row justify-content-center">
                <div className="col-md-6">
                    <div className="card">
                        <img src={home_img} className="card-img-top" alt="Home Image"/>
                        <div className="card-body">
                            <h2 className="card-title text-center">{t('home.welcome')}</h2>
                            <h4 className="card-title text-center">{t('home.info')}</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default Home;
