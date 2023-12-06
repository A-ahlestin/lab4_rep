CREATE TABLE Doctors (
    Doctor_ID SERIAL PRIMARY KEY,
    Full_Name VARCHAR(255) NOT NULL,
    Specialty VARCHAR(255),
    Percentage DECIMAL(5,2)
);

CREATE TABLE Patients (
    Patient_ID SERIAL PRIMARY KEY,
    Last_Name VARCHAR(255) NOT NULL,
    First_Name VARCHAR(255) NOT NULL,
    Middle_Name VARCHAR(255),
    Birth_Date DATE,
    Address VARCHAR(255)
);

CREATE TABLE Appointments (
    Appointment_ID SERIAL PRIMARY KEY,
    Doctor_ID INTEGER REFERENCES Doctors(Doctor_ID),
    Patient_ID INTEGER REFERENCES Patients(Patient_ID),
    Appointment_Date DATE,
    Cost DECIMAL(8,2)
);

CREATE TABLE AppointmentsPatients (
    Appointment_ID INTEGER REFERENCES Appointments(Appointment_ID),
    Patient_ID INTEGER REFERENCES Patients(Patient_ID),
    PRIMARY KEY (Appointment_ID, Patient_ID)
);

CREATE TABLE Receipts (
    Receipt_ID SERIAL PRIMARY KEY,
    Appointment_ID INTEGER REFERENCES Appointments(Appointment_ID)
);
