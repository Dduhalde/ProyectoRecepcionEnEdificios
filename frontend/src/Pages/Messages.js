import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import '../App.css';

const Messages = () => {
  const { t } = useTranslation();

  const [message, setMessage] = useState('');
  const [selectedOption, setSelectedOption] = useState(t('messages.selectType'));

  const handleInputChange = (e) => {
    setMessage(e.target.value);
  };

  const handleSelectChange = (e) => {
    setSelectedOption(e.target.value);
  };

  const handleSendMessage = () => {
    // Lógica para enviar el mensaje se implementa aquí
    console.log(`Mensaje: ${message}, Tipo: ${selectedOption}`);
  };

  return (
    <div class="container">
      <div class="row m-0">
        <div class="col-md-12">
          <h1 class="text-center mb-4">{t('messages.contactConcierge')}</h1> 
          <hr class="mb-4" />   
          <div class="mb-2">
            <label for="exampleFormControlTextarea1" class="form-label">{t('messages.writeMessage')}</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="4" rezise="none" value={message}
          onChange={handleInputChange}></textarea>
          </div>

          <select class="form-select" aria-label="Default select example" value={selectedOption} onChange={handleSelectChange}>
            <option value="" disabled hidden>{t('messages.selectType')}</option>
            <option value="Packages">{t('messages.packages')}</option>
            <option value="Visits">{t('messages.visits')}</option>
            <option value="Cars">{t('messages.cars')}</option>
            <option value="Parking">{t('messages.parking')}</option>
            <option value="Others">{t('messages.others')}</option>
          </select>
      </div>
      <div class="text-center mt-4">
      <button class="btn btn-primary"  onClick={handleSendMessage}>{t('messages.sendMessage')}</button>
      </div>
    </div>
    </div>
  );
};

export default Messages;
