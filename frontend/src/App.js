import { BrowserRouter, Route, Routes, Navigate } from 'react-router-dom';
import { useEffect, useState } from 'react';
import './App.css';
import NavbarConcierge from './components/NavbarConcierge';
import NavbarResident from './components/NavbarResident';


// Importacion de las paginas
import Home from './Pages/Home';
import Login from './Pages/Login';
import NewCorrespondenceForm from './Pages/NewCorrespondenceForm';
import NewVisitForm from './Pages/NewVisitForm';
import Notifications from './Pages/notifications';
import SearchPersonForm from './Pages/SearchPersonForm';
import SearchPersonCam from './Pages/SearchPersonCam';
import AdminFrequentVisits from './Pages/AdminFrequentVisits';
import Messages from './Pages/Messages';
import Config from './Pages/config';
import AdminCorrespondence from './Pages/AdminCorrespondence';
import AdminMessages from './Pages/AdminMessages';
import ConfigAdmin from './Pages/ConfigAdmin';
import NewVehicleForm from './Pages/NewVehicleForm';
import AdminParking from './Pages/AdminParking';


function App() {
  const [loggedIn, setLoggedIn] = useState(false)
  const [email, setEmail] = useState("")

  useEffect(() => {
    // Fetch the user email and token from local storage
    const user = JSON.parse(localStorage.getItem("user"))

    // If the token/email does not exist, mark the user as logged out
    if (!user || !user.token) {
      setLoggedIn(false)
      return
    }

    // If the token exists, verify it with the auth server to see if it is valid
    fetch("http://localhost:3080/verify", {
            method: "POST",
            headers: {
                'jwt-token': user.token
              }
        })
        .then(r => r.json())
        .then(r => {
            setLoggedIn('success' === r.message)
            setEmail(user.email || "")
        })
  }, [])

  return (
    <div className="App">
      <BrowserRouter>
      <NavbarConcierge /> {/* Aca alternar navbar entre Concierge y Resident hasta conectar backend */}
        <Routes>
          <Route path="/home" element={<Home email={email} loggedIn={loggedIn} setLoggedIn={setLoggedIn}/>} />
          <Route path="/login" element={<Login setLoggedIn={setLoggedIn} setEmail={setEmail} />} />
          <Route path="/newcorrespondenceform" element={<NewCorrespondenceForm />} />
          <Route path="/newvisitform" element={<NewVisitForm />} />
          <Route path="/searchpersonform" element={<SearchPersonForm />} />
          <Route path="/searchpersoncam" element={<SearchPersonCam />} />
          <Route path="/notifications" element={<Notifications />} />
          <Route path="/messages" element={<Messages />} />
          <Route path="/newvehicleform" element={<NewVehicleForm />} />
          <Route path="/config" element={<Config />} />
          <Route path="/configadmin" element={<ConfigAdmin />} />
          <Route path="/admincorrespondence" element={<AdminCorrespondence />} />
          <Route path="/adminmessages" element={<AdminMessages />} />
          <Route path="/adminfrequentvisits" element={<AdminFrequentVisits />} />
          <Route path="/adminparking" element={<AdminParking />} />
          <Route path="*" element={<Navigate to="/home" replace />} /> {/* Redireccionar desde cualquier ruta inválida a /home */}
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;