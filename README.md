Proiectul acesta a presupus masurarea temperaturii cu senzorul de pe placa Nexys 4 DDR și transmiterea ei la un dispozitiv mobil prin intermediul unui modul Bluetooth.

Cerintele proiectului in integritate au fost:
- Proiectare utilizând limbajul VHDL
- Implementare pe placa Digilent Nexys 4 DDR
- Măsurarea temperaturii cu senzorul de temperatură ADT7420
- Utilizarea modulului Bluetooth Pmod BT2 pentru transmiterea temperaturii la un
dispozitiv mobil
- Aplicație pe dispozitivul mobil pentru preluarea și afișarea temperaturii

Proiectul prezentat în acest raport se concentrează pe utilizarea limbajului VHDL pentru a construi un sistem capabil să citească valorile de temperatură de pe senzorul integrat al plăcii Nexys 4 DDR și să le trimită prin Bluetooth folosind modulul Pmod BT2. Acest sistem poate fi setat să trimită valorile automat sau doar la apăsarea unui buton. Senzorul integrat de temperatură utilizat în acest proiect este un dispozitiv electronic care poate detecta și converti variațiile de temperatură în semnale electrice, care pot fi apoi prelucrate de sistemul proiectat. Acest senzor este o componenta importanta pentru monitorizarea și controlul temperaturii în diferite aplicații.

Functionare:
- Se conecteaza modulul bluetooth la placa.
- Se conecteaza telefonul la modul Bluetooth
- Prin apasarea de buton se transmite temperature manual
- In momentul in care se detecteaza o schimbare de temperature se trimite
temperatura automat
- Temperatura este primita pe telefon, in aplicatia Serial Bluetooth Terminal

<img width="892" alt="Screenshot 2023-01-18 at 00 24 19" src="https://user-images.githubusercontent.com/99261319/213025672-ac1e6749-05e3-4cf4-bd3f-6aa636f003ee.png">

Proiect realizat de:
- [@BogdanNP]( https://github.com/BogdanNP )
- [@erictoader]( https://github.com/erictoader )

Universitatea Tehnica din Cluj-Napoca
Structura Sistemelor de Calcul
2022 / 2023
