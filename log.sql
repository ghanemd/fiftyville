
-- Find the id of the crime and its descpition : it happened at 10:15am

SELECT *
FROM crime_scene_reports
WHERE year = 2024 AND month = 7 AND day = 28 AND street = 'Humphrey Street' AND description LIKE '%duck%';

-- Find the witnesses of the crime
SELECT *
FROM interviews
WHERE year = 2024 AND month = 7 AND day = 28 AND transcript LIKE '%bakery%';

-- Use the info from the first witness: the thief drove away within ten minutes of the theft

-- Ids of the suspects according to the first witness:          
SELECT id
FROM people 
WHERE  license_plate IN (
    SELECT license_plate 
    FROM bakery_security_logs 
    WHERE year = 2024 AND month = 7 AND day = 28 AND hour = 10 AND activity = 'exit' AND minute >= 15 AND minute <= 25
);

-- Use the info from the second witness: the thief withdrew some money on Leggett Street in the morning

-- Ids of the suspects according to the second witness:   
SELECT person_id
FROM bank_accounts
WHERE account_number IN(
    SELECT account_number 
    FROM atm_transactions
    WHERE year = 2024 AND month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Leggett Street'
);

-- Use the info from the third witness: 
SELECT '--------------------city-----------------' AS info_message;

-- Find the destination of the theft: he is planning to take the earliest flight out of Fiftyville 
SELECT city
FROM airports
WHERE id = (
    SELECT destination_airport_id
    FROM flights
    WHERE origin_airport_id = (
        SELECT id 
        FROM airports
        WHERE city = 'Fiftyville'
    ) AND year = 2024 AND month = 7 AND day = 29 ORDER BY hour LIMIT 1
);


-- The thief called the accomplice for less than one minute
SELECT id
FROM people
WHERE phone_number IN (
    SELECT caller
    FROM phone_calls
    WHERE year = 2024 AND month = 7 AND day = 28 and duration <= 60
);


-- The thief is taking the flight
SELECT id 
FROM people
WHERE passport_number IN(
    SELECT passport_number
    FROM passengers
    WHERE flight_id = (
        SELECT id
        FROM flights
        WHERE origin_airport_id = (
            SELECT id 
            FROM airports
            WHERE city = 'Fiftyville'
        ) AND year = 2024 AND month = 7 AND day = 29 ORDER BY hour LIMIT 1
    )
);

SELECT '--------------------thief-----------------' AS info_message;
-- Find the thief by combining all the previous sections
SELECT name
FROM people 
WHERE id In(
    SELECT id
    FROM people 
    WHERE  license_plate IN (
        SELECT license_plate 
        FROM bakery_security_logs 
        WHERE year = 2024 AND month = 7 AND day = 28 AND hour = 10 AND activity = 'exit' AND minute >= 15 AND minute <= 25
    )
) AND id In (
    SELECT person_id
    FROM bank_accounts
    WHERE account_number IN(
        SELECT account_number 
        FROM atm_transactions
        WHERE year = 2024 AND month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Leggett Street'
    )
) AND id In (
    SELECT id
    FROM people
    WHERE phone_number IN (
        SELECT caller
        FROM phone_calls
        WHERE year = 2024 AND month = 7 AND day = 28 and duration <= 60
    )
) AND id In (
    SELECT id 
    FROM people
    WHERE passport_number IN(
        SELECT passport_number
        FROM passengers
        WHERE flight_id = (
            SELECT id
            FROM flights
            WHERE origin_airport_id = (
                SELECT id 
                FROM airports
                WHERE city = 'Fiftyville'
            ) AND year = 2024 AND month = 7 AND day = 29 ORDER BY hour LIMIT 1
        )
    )
);



SELECT '--------------------accomplice-----------------' AS info_message;

SELECT name
FROM people
WHERE phone_number IN (
    SELECT receiver
    FROM phone_calls
    WHERE year = 2024 AND month = 7 AND day = 28 and duration <= 60 and caller = '(367) 555-5533'
);

