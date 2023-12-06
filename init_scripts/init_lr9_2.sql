-- Создание таблицы Doctors для хранения информации о врачах
CREATE TABLE Doctors (
    Doctor_ID SERIAL PRIMARY KEY, -- Уникальный идентификатор врача
    Full_Name VARCHAR(255) NOT NULL, -- Полное имя врача (не может быть NULL)
    Specialty VARCHAR(255), -- Специальность врача
    Percentage DECIMAL(5,2) -- Процент (для чего-то, возможно, ставка)
);

-- Вставка данных в таблицу Doctors
INSERT INTO Doctors (Full_Name, Specialty, Percentage) VALUES
('Dr. John Smith', 'Cardiologist', 80.5),
('Dr. Maria Rodriguez', 'Pediatrician', 75.25),
('Dr. Robert Johnson', 'Dermatologist', 85.0),
('Dr. Emily Davis', 'Orthopedic Surgeon', 90.75),
('Dr. Michael Brown', 'Oncologist', 88.0),
('Dr. Jennifer White', 'Neurologist', 82.3),
('Dr. Christopher Lee', 'Gastroenterologist', 78.6),
('Dr. Jessica Harris', 'Endocrinologist', 76.9),
('Dr. Daniel Wilson', 'Psychiatrist', 87.2),
('Dr. Olivia Taylor', 'Rheumatologist', 79.8),
('Dr. Ethan Martinez', 'Urologist', 91.5),
('Dr. Sophia Anderson', 'Pulmonologist', 84.7),
('Dr. Liam Thomas', 'Ophthalmologist', 88.5),
('Dr. Ava Garcia', 'Nephrologist', 83.2),
('Dr. Noah Smith', 'Hematologist', 89.4),
('Dr. Amelia Wilson', 'Gynecologist', 77.1),
('Dr. Benjamin Jones', 'Dentist', 92.0),
('Dr. Grace Miller', 'Ear, Nose, Throat Specialist', 81.4),
('Dr. Aiden Taylor', 'Allergist', 86.3),
('Dr. Zoe Johnson', 'Family Medicine Physician', 84.0);

-- Создание таблицы Patients для хранения информации о пациентах
CREATE TABLE Patients (
    Patient_ID SERIAL PRIMARY KEY, -- Уникальный идентификатор пациента
    Last_Name VARCHAR(255) NOT NULL, -- Фамилия пациента (не может быть NULL)
    First_Name VARCHAR(255) NOT NULL, -- Имя пациента (не может быть NULL)
    Middle_Name VARCHAR(255), -- Отчество пациента
    Birth_Date DATE, -- Дата рождения пациента
    Address VARCHAR(255) -- Адрес пациента
);

-- Вставка данных в таблицу Patients
INSERT INTO Patients (Last_Name, First_Name, Middle_Name, Birth_Date, Address) VALUES
('Johnson', 'Alice', 'Marie', '1990-05-15', '123 Main St'),
('Smith', 'Bob', 'Robert', '1985-08-22', '456 Oak St'),
('Williams', 'Charlie', 'Michael', '1979-11-10', '789 Elm St'),
('Davis', 'Diana', 'Nicole', '1982-04-03', '101 Pine St'),
('Brown', 'Edward', 'Thomas', '1995-07-17', '202 Cedar St'),
('Miller', 'Fiona', 'Elizabeth', '1988-12-28', '303 Maple St'),
('Wilson', 'George', 'William', '1977-03-05', '404 Birch St'),
('Taylor', 'Hannah', 'Grace', '1993-06-20', '505 Spruce St'),
('Thomas', 'Ian', 'Joseph', '1980-09-14', '606 Pineapple Ave'),
('Garcia', 'Julia', 'Isabel', '1998-02-07', '707 Coconut Blvd'),
('Martinez', 'Keith', 'David', '1984-01-01', '808 Palm St'),
('Jackson', 'Laura', 'Michelle', '1975-10-12', '909 Olive St'),
('Harris', 'Mason', 'Richard', '1991-09-30', '111 Cedar Ave'),
('Anderson', 'Natalie', 'Lynn', '1987-07-08', '222 Maple Ave'),
('Lee', 'Oliver', 'Patrick', '1983-03-18', '333 Birch Ave'),
('White', 'Penelope', 'Rose', '1996-12-25', '444 Oak Ave'),
('Carter', 'Quinn', 'Samuel', '1978-04-21', '555 Pineapple Blvd'),
('Moore', 'Rachel', 'Victoria', '1989-08-05', '666 Pine Blvd'),
('Cooper', 'Steven', 'Charles', '1976-11-28', '777 Olive Ave'),
('Evans', 'Tara', 'Alexis', '1994-01-09', '888 Palm Blvd');


-- Создание таблицы Appointments для хранения информации о приемах
CREATE TABLE Appointments (
    Appointment_ID SERIAL PRIMARY KEY, -- Уникальный идентификатор приема
    Doctor_ID INTEGER REFERENCES Doctors(Doctor_ID), -- Ссылка на врача (внешний ключ)
    Patient_ID INTEGER REFERENCES Patients(Patient_ID), -- Ссылка на пациента (внешний ключ)
    Appointment_Date DATE, -- Дата приема
    Cost DECIMAL(8,2) -- Стоимость приема
);

-- Вставка данных в таблицу Appointments
INSERT INTO Appointments (Doctor_ID, Patient_ID, Appointment_Date, Cost) VALUES
(1, 1, '2023-01-10', 150.00),
(2, 2, '2023-01-15', 200.50),
(3, 3, '2023-01-20', 120.75),
(4, 4, '2023-01-25', 180.25),
(5, 5, '2023-01-30', 160.00),
(1, 6, '2023-02-05', 190.30),
(2, 7, '2023-02-10', 220.00),
(3, 8, '2023-02-15', 130.50),
(4, 9, '2023-02-20', 175.80),
(5, 10, '2023-02-25', 140.25),
(1, 11, '2023-03-02', 200.00),
(2, 12, '2023-03-07', 165.75),
(3, 13, '2023-03-12', 185.50),
(4, 14, '2023-03-17', 195.00),
(5, 15, '2023-03-22', 210.30),
(1, 16, '2023-03-27', 170.25),
(2, 17, '2023-04-01', 140.50),
(3, 18, '2023-04-06', 225.00),
(4, 19, '2023-04-11', 160.75),
(5, 20, '2023-04-16', 180.20);


-- Создание таблицы AppointmentsPatients для установления связи между приемами и пациентами
CREATE TABLE AppointmentsPatients (
    Appointment_ID INTEGER REFERENCES Appointments(Appointment_ID), -- Ссылка на прием (внешний ключ)
    Patient_ID INTEGER REFERENCES Patients(Patient_ID), -- Ссылка на пациента (внешний ключ)
    PRIMARY KEY (Appointment_ID, Patient_ID) -- Комбинированный первичный ключ
);

-- Вставка данных в таблицу AppointmentsPatients
INSERT INTO AppointmentsPatients (Appointment_ID, Patient_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);

-- Создание таблицы Receipts для хранения информации о квитанциях
CREATE TABLE Receipts (
    Receipt_ID SERIAL PRIMARY KEY, -- Уникальный идентификатор квитанции
    Appointment_ID INTEGER REFERENCES Appointments(Appointment_ID) -- Ссылка на прием (внешний ключ)
);

-- Вставка данных в таблицу Receipts
INSERT INTO Receipts (Appointment_ID) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20);

-- Вывод данных о приемах, врачах, пациентах и их квитанциях
SELECT
    R.Receipt_ID, -- Номер квитанции
    A.Appointment_Date, -- Дата приема
    A.Cost, -- Стоимость приема
    P.Last_Name AS Patient_Last_Name, -- Фамилия пациента
    P.First_Name AS Patient_First_Name, -- Имя пациента
    D.Full_Name AS Doctor_Name, -- Полное имя врача
    D.Specialty -- Специальность врача
FROM
    Receipts R
JOIN
    Appointments A ON R.Appointment_ID = A.Appointment_ID -- Соединение с таблицей приемов
JOIN
    Doctors D ON A.Doctor_ID = D.Doctor_ID -- Соединение с таблицей врачей
JOIN
    Patients P ON A.Patient_ID = P.Patient_ID; -- Соединение с таблицей пациентов

