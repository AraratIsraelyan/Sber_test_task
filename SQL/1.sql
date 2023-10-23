/*

Требуется составить расписание случайных проверок. Создайте оператор выбора,
который выдаст 100 дат, начиная с текущей, при этом каждая дата отличается от
предыдущей на 2-7 дней.
Пример:
25.02.2023
28.02.2023
04.03.2023
06.03.2023
13.03.2023
16.03.2023
..........

*/

-- Создаем временную таблицу для хранения дат
CREATE TEMPORARY TABLE IF NOT EXISTS temp_dates (check_date DATE);

-- Устанавливаем начальную дату
SET @current_date = CURDATE();

-- Заполняем таблицу случайными датами
INSERT INTO temp_dates (check_date) VALUES (@current_date);
SET @counter = 1;

WHILE @counter < 100 DO
    -- Генерируем случайное количество дней от 2 до 7
    SET @random_days = FLOOR(2 + RAND() * 6);

    -- Выбираем последнюю дату из временной таблицы
    SELECT MAX(check_date) INTO @last_date FROM temp_dates;

    -- Добавляем случайное количество дней к последней дате
    SET @next_date = DATE_ADD(@last_date, INTERVAL @random_days DAY);

    -- Вставляем новую дату в таблицу
    INSERT INTO temp_dates (check_date) VALUES (@next_date);

    SET @counter = @counter + 1;
END WHILE;

-- Выводим 100 случайных дат
SELECT check_date FROM temp_dates;

-- p.s. было сложно