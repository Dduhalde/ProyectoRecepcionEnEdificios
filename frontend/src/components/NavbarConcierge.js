import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import '../App.css';

const NavbarConcierge = () => {
  const { t } = useTranslation();

  return (
    <nav className="navbar navbar-expand-lg navbar-light bg-light fixed-top justify-content-center">
      <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span className="navbar-toggler-icon"></span>
      </button>

      <div className="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
        <ul className="navbar-nav">
          <li className="nav-item active">
            <Link className="nav-link" to="/admincorrespondence">{t('navbarConcierge.adminCorrespondence')}</Link>
          </li>
          <li className="nav-item">
            <Link className="nav-link" to="/adminfrequentvisits">{t('navbarConcierge.adminFrequentVisits')}</Link>
          </li>
          <li className="nav-item">
            <Link className="nav-link" to="/adminparking">{t('navbarConcierge.adminParking')}</Link>
          </li>
          <li className="nav-item dropdown">
            <a className="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              {t('navbarConcierge.searchPerson')}
            </a>
            <div className="dropdown-menu" aria-labelledby="navbarDropdown">
              <Link className="dropdown-item" to="/searchpersonbyrut">{t('navbarConcierge.searchByRut')}</Link>
              <Link className="dropdown-item" to="/scanid">{t('navbarConcierge.scanID')}</Link>
            </div>
          </li>
          <li className="nav-item">
            <Link className="nav-link" to="/newvisitform">{t('navbarConcierge.newVisit')}</Link>
          </li>
          <li className="nav-item">
            <Link className="nav-link" to="/newvehicleform">{t('navbarConcierge.newVehicle')}</Link>
          </li>
          <li className="nav-item">
            <Link className="nav-link" to="/adminmessages">{t('navbarConcierge.messages')}</Link>
          </li>
          <li className="nav-item">
            <Link className="nav-link" to="/configadmin">{t('navbarConcierge.config')}</Link>
          </li>
          <li className="nav-item">
            <Link className="nav-link" to="/home">{t('navbarConcierge.signOut')}</Link>
          </li>
        </ul>
      </div>
    </nav>
  );
};

export default NavbarConcierge;
