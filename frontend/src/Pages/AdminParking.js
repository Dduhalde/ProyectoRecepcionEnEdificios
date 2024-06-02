import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import '../App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import FormParking from '../components/FormParking';
import InfoParking from '../components/InfoParking';

const AdminParking = () => {
  const { t } = useTranslation();
  const [parking, setParking] = useState([]);
  const [showForm, setShowForm] = useState(false);
  const [selectedParkingId, setSelectedParkingId] = useState(null);
  const [showInfo, setShowInfo] = useState(false);
  const [selectedParkingData, setSelectedParkingData] = useState(null);

  const user_role = sessionStorage.getItem('user_role');

  const fetchParkingData = async () => {
    try {
      const response = await fetch('https://dduhalde.online/.netlify/functions/api/parked');
      const data = await response.json();
      setParking(data);
    } catch (error) {
      console.error('Error fetching visitors:', error);
    }
  };

  useEffect(() => {
    fetchParkingData();
  }, []);

  const HandleShowForm = (parkingId) => {
    setShowInfo(false);
    setSelectedParkingId(parkingId);
    setShowForm(true);
  };

  const HandleShowInfo = (parking_) => {
    setShowForm(false);
    setSelectedParkingData(parking_);
    setShowInfo(true);
  };

  const handleFreeParking = async (license_plate, parkingId) => {
    try {
      await fetch(`https://dduhalde.online/.netlify/functions/api/free_parking/${license_plate}`);
      fetchParkingData(); // Update the parking data after freeing a spot
      HandleShowForm(parkingId);
    } catch (error) {
      console.error('An error occurred trying to remove a vehicle:', error);
    }
  };

  const handleAddParking = async (licensePlate, parkingId) => {
    try {
      await fetch(`https://dduhalde.online/.netlify/functions/api/assing_parking/${licensePlate}/${parkingId}`);
      fetchParkingData(); // Update the parking data after freeing a spot
      const response = await fetch('https://dduhalde.online/.netlify/functions/api/parked');
      const data = await response.json();
      const parkingData = data.find(p => p.parked_at === parkingId);
      HandleShowInfo(parkingData);
    } catch (error) {
      console.error('An error occurred trying to remove a vehicle:', error);
    }
  };

  return (
    <div id="change" className="container">
      {user_role !== '3' && (
        <div>
      <h1 className="text-center mb-4">{t('adminParking.adminParking')}</h1>
      <hr className="mb-5"/>
      <div className="container text-center mt-3">
        <div className="btn-group-vertical p-0 my-5" role="group" aria-label="Vertical button group">
          <div className="btn-group p-0 m-0" role="group" aria-label="First group">
            {[1, 2, 3, 4].map(id => (
              <button 
                key={id} 
                id={id} 
                type="button" 
                className={`btn ${parking.some(p => p.parked_at === id) ? 'btn-danger' : 'btn-success'} p-5 fs-1 m-0 border-4 border-warning`} 
                onClick={() => {
                  const parkingData = parking.find(p => p.parked_at === id);
                  parkingData ? HandleShowInfo(parkingData) : HandleShowForm(id);
                }}>
                {id}
              </button>
            ))}
          </div>
          <div className="btn-group p-0 m-0" role="group" aria-label="Second group">
            {[5, 6, 7, 8].map(id => (
              <button 
                key={id} 
                id={id} 
                type="button" 
                className={`btn ${parking.some(p => p.parked_at === id) ? 'btn-danger' : 'btn-success'} p-5 fs-1 m-0 border-4 border-warning`} 
                onClick={() => {
                  const parkingData = parking.find(p => p.parked_at === id);
                  parkingData ? HandleShowInfo(parkingData) : HandleShowForm(id);
                }}>
                {id}
              </button>
            ))}
          </div>
        </div>
      </div>
      <div id="info-container" className="container mt-2 mb-5">
        { showForm && <FormParking parkingId={selectedParkingId} onAddParking={handleAddParking} /> }
        { showInfo && <InfoParking data={selectedParkingData} onFreeParking={handleFreeParking} /> }
      </div>
      </div>
      )}
    </div>
  );
};

export default AdminParking;
