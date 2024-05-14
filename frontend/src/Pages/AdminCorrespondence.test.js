import React, { useState } from 'react';
import { render, waitFor, fireEvent } from '@testing-library/react';
import AdminCorrespondence from './AdminCorrespondence';
import { formatDateLarge } from '../Utils.js';

// Mock de las dependencias de react-router-dom y react-i18next
jest.mock('react-router-dom', () => ({
  useNavigate: jest.fn(),
}));
jest.mock('react-i18next', () => ({
  useTranslation: () => ({ t: key => key }),
}));
const mockNavigate = jest.fn();
jest.mock('react-router-dom', () => ({
  useNavigate: () => mockNavigate,
}));

describe('AdminCorrespondence Component', () => {
  test('renders with correspondence data', async () => {
    // Simular la respuesta de la API
    global.fetch = jest.fn().mockResolvedValueOnce({
      json: () => Promise.resolve([
        {
          "id": 66,
          "housing_unit_apartment": "101-1",
          "mail_type": "Others",
          "arrival_time": "2024-05-02T00:17:00.000Z",
          "is_notified": 1,
          "is_claimed": 0
        },
        {
          "id": 67,
          "housing_unit_apartment": "102-1",
          "mail_type": "Letters",
          "arrival_time": "2024-04-02T00:17:00.000Z",
          "is_notified": 0,
          "is_claimed": 0
        }
      ]),
    });

    const { getByText, getAllByText } = render(<AdminCorrespondence />);

    // Esperar a que la tabla y los datos de correspondencia se rendericen
    await waitFor(() => {
        // Verificamos si se renderizaron los datos correctamente
        expect(getByText('66')).toBeInTheDocument();
        expect(getByText('67')).toBeInTheDocument();
        expect(getByText('101-1')).toBeInTheDocument();
        expect(getByText('102-1')).toBeInTheDocument();
        expect(getByText('Others')).toBeInTheDocument();
        expect(getByText('Letters')).toBeInTheDocument();
        expect(getByText(formatDateLarge("2024-05-02T00:17:00.000Z"))).toBeInTheDocument();
        expect(getByText(formatDateLarge("2024-04-02T00:17:00.000Z"))).toBeInTheDocument();
        expect(getByText('✔')).toBeInTheDocument();
        expect(getByText('❌')).toBeInTheDocument();
        const elements = getAllByText('adminCorrespondence.claimed');
        elements.forEach(element => {
            expect(element).toBeInTheDocument();
        });
        expect(getByText('adminCorrespondence.addNewCorrespondence')).toBeInTheDocument();
    });
});

});

describe('AdminCorrespondence Component', () => {
    test('calls navigate with correct argument when add new correspondence button is clicked', async () => {
        // Simular la respuesta de la API
        global.fetch = jest.fn().mockResolvedValueOnce({
          json: () => Promise.resolve([
            {
              "id": 66,
              "housing_unit_apartment": "101-1",
              "mail_type": "Others",
              "arrival_time": "2024-05-02T00:17:00.000Z",
              "is_notified": 1,
              "is_claimed": 0
            },
            {
              "id": 67,
              "housing_unit_apartment": "102-1",
              "mail_type": "Letters",
              "arrival_time": "2024-04-02T00:17:00.000Z",
              "is_notified": 0,
              "is_claimed": 0
            }
          ]),
        });
      const { getByText } = render(<AdminCorrespondence />);
      
      // Simula un clic en el botón
      fireEvent.click(getByText('adminCorrespondence.addNewCorrespondence'));
      
      // Verifica si la función navigate se llamó correctamente
      expect(mockNavigate).toHaveBeenCalledWith('/newcorrespondenceform');
    });
  });

  describe('AdminCorrespondence Component', () => {
    test('test fetching data from API', async () => {
        // Simular la respuesta de la API
        global.fetch = jest.fn().mockResolvedValueOnce({
          json: () => Promise.resolve([
            {
              "id": 66,
              "housing_unit_apartment": "101-1",
              "mail_type": "Others",
              "arrival_time": "2024-05-02T00:17:00.000Z",
              "is_notified": 1,
              "is_claimed": 0
            },
            {
              "id": 67,
              "housing_unit_apartment": "102-1",
              "mail_type": "Letters",
              "arrival_time": "2024-04-02T00:17:00.000Z",
              "is_notified": 0,
              "is_claimed": 0
            }
          ]),
        });
      const { getAllByText } = render(<AdminCorrespondence />);
      
        await waitFor(() => {
            // Verifica si la función fetch se llamó con la URL correcta
            expect(global.fetch).toHaveBeenCalledWith('https://dduhalde.online/.netlify/functions/api/unclaimed_correspondence'); // Ajusta el id según tus necesidades
          });
    });
  });