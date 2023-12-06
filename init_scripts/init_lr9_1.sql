--
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY, -- Уникальный идентификатор клиента
    FirstName VARCHAR(255), -- Имя клиента
    LastName VARCHAR(255), -- Фамилия клиента
    Email VARCHAR(255) -- Адрес электронной почты клиента
);
--
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY, -- Уникальный идентификатор заказа
    CustomerID INTEGER REFERENCES Customers(CustomerID), -- Идентификатор клиента, совершившего заказ
    OrderDate TIMESTAMP, -- Дата и время создания заказа
    TotalAmount DECIMAL(10, 2) -- Общая стоимость заказа
);

--
CREATE TABLE OrderDetails (
    OrderDetailID SERIAL PRIMARY KEY, -- Уникальный идентификатор детали заказа
    OrderID INTEGER REFERENCES Orders(OrderID), -- Идентификатор заказа
    ProductID INTEGER, -- Идентификатор продукта в заказе
    Quantity INTEGER, -- Количество продуктов в заказе
    UnitPrice DECIMAL(10, 2) -- Цена за единицу продукта
);
--
INSERT INTO Customers (FirstName, LastName, Email) VALUES
    ('John', 'Doe', 'john.doe@example.com'),
    ('Alice', 'Smith', 'alice.smith@example.com'),
    ('Bob', 'Johnson', 'bob.johnson@example.com'),
    ('Emma', 'Williams', 'emma.williams@example.com'),
    ('Michael', 'Brown', 'michael.brown@example.com'),
    ('Sophia', 'Miller', 'sophia.miller@example.com'),
    ('William', 'Jones', 'william.jones@example.com'),
    ('Olivia', 'Davis', 'olivia.davis@example.com'),
    ('James', 'Moore', 'james.moore@example.com'),
    ('Emily', 'Taylor', 'emily.taylor@example.com'),
    ('Daniel', 'Anderson', 'daniel.anderson@example.com'),
    ('Grace', 'White', 'grace.white@example.com'),
    ('Benjamin', 'Lee', 'benjamin.lee@example.com'),
    ('Lily', 'Clark', 'lily.clark@example.com'),
    ('Christopher', 'Hall', 'christopher.hall@example.com'),
    ('Ava', 'Young', 'ava.young@example.com'),
    ('Logan', 'Wright', 'logan.wright@example.com'),
    ('Ella', 'Thomas', 'ella.thomas@example.com'),
    ('Jackson', 'Hill', 'jackson.hill@example.com'),
    ('Mia', 'Walker', 'mia.walker@example.com');
--
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
  (1, '2023-01-01', 100.50),
  (2, '2023-01-02', 75.20),
  (3, '2023-01-03', 120.75),
  (4, '2023-01-04', 200.00),
  (1, '2023-01-05', 50.30),
  (2, '2023-01-06', 90.10),
  (3, '2023-01-07', 150.25),
  (4, '2023-01-08', 180.75),
  (1, '2023-01-09', 30.50),
  (2, '2023-01-10', 120.00),
  (3, '2023-01-11', 85.80),
  (4, '2023-01-12', 95.40),
  (1, '2023-01-13', 110.20),
  (2, '2023-01-14', 60.75),
  (3, '2023-01-15', 40.90),
  (4, '2023-01-16', 130.60),
  (1, '2023-01-17', 75.00),
  (2, '2023-01-18', 200.30),
  (3, '2023-01-19', 160.45),
  (4, '2023-01-20', 90.60);
--
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
  (1, 101, 2, 25.50),
  (1, 102, 1, 30.20),
  (2, 103, 3, 15.75),
  (2, 104, 2, 40.00),
  (3, 105, 1, 10.30),
  (3, 106, 4, 22.50),
  (4, 107, 2, 50.10),
  (4, 108, 3, 30.25),
  (5, 109, 1, 20.50),
  (5, 110, 2, 30.00),
  (6, 111, 3, 15.80),
  (6, 112, 1, 35.40),
  (7, 113, 2, 10.20),
  (7, 114, 4, 45.75),
  (8, 115, 1, 35.90),
  (8, 116, 2, 20.60),
  (9, 117, 3, 18.00),
  (9, 118, 1, 55.30),
  (10, 119, 2, 40.45),
  (10, 120, 1, 30.60);

-- 7. Вывести список клиентов с суммарной стоимостью заказов

SELECT
  c.FirstName, -- Выбираем имя клиента
  c.LastName, -- Выбираем фамилию клиента
  COALESCE(SUM(o.TotalAmount), 0) AS TotalOrderAmount -- Считаем суммарную стоимость заказов с учетом возможных отсутствующих значений и называем столбец
FROM
  Customers c -- Выбираем данные из таблицы Customers и используем псевдоним "c"
LEFT JOIN
  Orders o ON c.CustomerID = o.CustomerID -- Используем LEFT JOIN для соединения таблиц Customers и Orders по CustomerID
GROUP BY
  c.FirstName, c.LastName -- Группируем результат по имени и фамилии клиента
ORDER BY
  c.LastName, c.FirstName; -- Сортируем результат по фамилии и имени клиента

-- 8. Отсортировать список клиентов по убыванию суммарной стоимости заказов

SELECT
  c.FirstName, -- Выбираем имя клиента
  c.LastName, -- Выбираем фамилию клиента
  COALESCE(SUM(o.TotalAmount), 0) AS TotalOrderAmount -- Считаем суммарную стоимость заказов с учетом возможных отсутствующих значений и называем столбец
FROM
  Customers c -- Выбираем данные из таблицы Customers и используем псевдоним "c"
LEFT JOIN
  Orders o ON c.CustomerID = o.CustomerID -- Используем LEFT JOIN для соединения таблиц Customers и Orders по CustomerID
GROUP BY
  c.FirstName, c.LastName -- Группируем результат по имени и фамилии клиента
ORDER BY
  TotalOrderAmount DESC, c.LastName, c.FirstName; -- Сортируем результат по убыванию суммарной стоимости заказов, а затем по фамилии и имени клиента

-- 9. Добавить столбец со средней суммарной стоимостью заказов

SELECT
  c.FirstName, -- Выбираем имя клиента
  c.LastName, -- Выбираем фамилию клиента
  COALESCE(SUM(o.TotalAmount), 0) AS TotalOrderAmount, -- Считаем суммарную стоимость заказов с учетом возможных отсутствующих значений и называем столбец
  COALESCE(ROUND(AVG(o.TotalAmount), 2), 0) AS AvgOrderAmount -- Считаем среднюю стоимость заказов с учетом возможных отсутствующих значений, округляем до двух знаков после запятой и называем столбец
FROM
  Customers c -- Выбираем данные из таблицы Customers и используем псевдоним "c"
LEFT JOIN
  Orders o ON c.CustomerID = o.CustomerID -- Используем LEFT JOIN для соединения таблиц Customers и Orders по CustomerID
GROUP BY
  c.FirstName, c.LastName -- Группируем результат по имени и фамилии клиента
ORDER BY
  TotalOrderAmount DESC, c.LastName, c.FirstName; -- Сортируем результат по убыванию суммарной стоимости заказов, а затем по фамилии и имени клиента

-- 10. Вывести клиента с наибольшей суммарной стоимостью заказов

WITH RankedCustomers AS (
  SELECT
    c.FirstName, -- Выбираем имя клиента
    c.LastName, -- Выбираем фамилию клиента
    COALESCE(SUM(o.TotalAmount), 0) AS TotalOrderAmount, -- Считаем суммарную стоимость заказов с учетом возможных отсутствующих значений и называем столбец
    ROW_NUMBER() OVER (ORDER BY COALESCE(SUM(o.TotalAmount), 0) DESC) AS Rank -- Пронумеровываем строки в порядке убывания суммарной стоимости заказов и называем столбец Rank
  FROM
    Customers c -- Выбираем данные из таблицы Customers и используем псевдоним "c"
  LEFT JOIN
    Orders o ON c.CustomerID = o.CustomerID -- Используем LEFT JOIN для соединения таблиц Customers и Orders по CustomerID
  GROUP BY
    c.FirstName, c.LastName -- Группируем результат по имени и фамилии клиента
)
SELECT
  FirstName,
  LastName,
  TotalOrderAmount
FROM
  RankedCustomers
WHERE
  Rank = 1; -- Выбираем первого клиента в отсортированном списке

--11

WITH RankedOrders AS (
  SELECT
    c.CustomerID, -- Выбираем ID клиента
    c.FirstName, -- Выбираем имя клиента
    c.LastName, -- Выбираем фамилию клиента
    o.OrderID, -- Выбираем ID заказа
    o.TotalAmount, -- Выбираем суммарную стоимость заказа
    RANK() OVER (PARTITION BY c.CustomerID ORDER BY o.TotalAmount) AS OrderRank -- Пронумеровываем заказы для каждого клиента в порядке возрастания стоимости и называем столбец OrderRank
  FROM
    Customers c -- Выбираем данные из таблицы Customers и используем псевдоним "c"
  LEFT JOIN
    Orders o ON c.CustomerID = o.CustomerID -- Используем LEFT JOIN для соединения таблиц Customers и Orders по CustomerID
),
TopCustomers AS (
  SELECT
    c.CustomerID, -- Выбираем ID клиента
    c.FirstName, -- Выбираем имя клиента
    c.LastName, -- Выбираем фамилию клиента
    COALESCE(SUM(o.TotalAmount), 0) AS TotalOrderAmount -- Считаем суммарную стоимость заказов с учетом возможных отсутствующих значений и называем столбец
  FROM
    Customers c -- Выбираем данные из таблицы Customers и используем псевдоним "c"
  LEFT JOIN
    Orders o ON c.CustomerID = o.CustomerID -- Используем LEFT JOIN для соединения таблиц Customers и Orders по CustomerID
  GROUP BY
    c.CustomerID, c.FirstName, c.LastName -- Группируем результат по ID, имени и фамилии клиента
  ORDER BY
    TotalOrderAmount DESC -- Сортируем результат по убыванию суммарной стоимости заказов
  LIMIT 1 -- Ограничиваем результат одной записью (наибольшей суммарной стоимостью заказов)
)
SELECT
  ro.CustomerID,
  ro.FirstName,
  ro.LastName,
  ro.OrderID,
  ro.TotalAmount
FROM
  TopCustomers tc
JOIN
  RankedOrders ro ON tc.CustomerID = ro.CustomerID -- Соединяем результаты двух предыдущих запросов по ID клиента
ORDER BY
  ro.TotalAmount; -- Сортируем результат по суммарной стоимости заказа

--12

WITH CustomerOrderTotals AS (
  SELECT
    c.CustomerID, -- Выбираем ID клиента
    c.FirstName, -- Выбираем имя клиента
    c.LastName, -- Выбираем фамилию клиента
    COALESCE(SUM(o.TotalAmount), 0) AS TotalOrderAmount -- Считаем суммарную стоимость заказов с учетом возможных отсутствующих значений и называем столбец
  FROM
    Customers c -- Выбираем данные из таблицы Customers и используем псевдоним "c"
  LEFT JOIN
    Orders o ON c.CustomerID = o.CustomerID -- Используем LEFT JOIN для соединения таблиц Customers и Orders по CustomerID
  GROUP BY
    c.CustomerID, c.FirstName, c.LastName -- Группируем результат по ID, имени и фамилии клиента
),
AverageOrderAmount AS (
  SELECT
    AVG(TotalOrderAmount) AS AvgOrderAmount -- Считаем среднюю суммарную стоимость заказов
  FROM
    CustomerOrderTotals
)
SELECT
  cot.CustomerID,
  cot.FirstName,
  cot.LastName,
  cot.TotalOrderAmount,
  aoa.AvgOrderAmount
FROM
  CustomerOrderTotals cot
JOIN
  AverageOrderAmount aoa ON 1 = 1 -- Используем CROSS JOIN для соединения результатов двух предыдущих запросов
WHERE
  cot.TotalOrderAmount > aoa.AvgOrderAmount -- Фильтруем результаты, оставляя только тех клиентов, у которых суммарная стоимость заказов больше средней
ORDER BY
  cot.TotalOrderAmount DESC, cot.LastName, cot.FirstName; -- Сортируем результат по убыванию суммарной стоимости заказов, а затем по фамилии и имени клиента


