-- Semua data yang ada di dataset
SELECT * 
FROM covid_data


--Rentang waktu di dataset
SELECT MIN(TO_DATE(date, 'YYYY-MM-DD')), MAX(TO_DATE(date, 'YYYY-MM-DD'))
FROM covid_data

--Data covid Indonesia
SELECT *
FROM covid_data
WHERE location = 'Indonesia'

--Tren kasus baru dari waktu ke waktu
SELECT TO_CHAR(TO_DATE(date, 'YYYY-MM-DD'), 'YYYY-MM') as date, SUM(CAST(new_cases as DECIMAL(20, 2))) as total_new_cases
FROM covid_data
WHERE continent is not null
GROUP BY date
ORDER BY date

-- Total cases VS Total Deaths di Indonesia
SELECT location, date, total_cases, total_deaths, ROUND((CAST(total_deaths as DECIMAL(20, 2))/CAST(total_cases as DECIMAL(20, 2)))*100 , 2)as death_pecentage
FROM covid_data
WHERE continent is not null
AND iso_code = 'IDN'
ORDER BY location, date


-- Total Cases VS Population di Indonesia
SELECT location, date, total_cases, population, ROUND((CAST(total_cases as DECIMAL(20, 2))/CAST(population as DECIMAL(20, 2)))*100 , 2)as cases_pecentage
FROM covid_data
WHERE continent is not null
AND iso_code = 'IDN'
ORDER BY location, date

-- Negara dengan infection rate yan tinggi
SELECT location, population, MAX(CAST(total_cases as DECIMAL(20, 2))), MAX(ROUND((CAST(total_cases as DECIMAL(20, 2))/CAST(population as DECIMAL(20, 2)))*100, 2)) AS infection_rate
FROM covid_data
WHERE continent is not null
GROUP BY location, population
ORDER BY infection_rate DESC

-- Negara dengan total kematian terbanyak
SELECT location, MAX(CAST(total_deaths as DECIMAL(20, 2))) AS highest_deaths
FROM covid_data
WHERE continent is not null
GROUP BY location
ORDER BY highest_deaths DESC

-- Benua dengan total kematian terbanyak
SELECT location, MAX(CAST(total_deaths as DECIMAL(20, 2))) AS highest_deaths
FROM covid_data
WHERE continent is null
AND location <> 'Upper middle income'
AND location <> 'World'
AND location <> 'High income'
AND location <> 'Lower middle income'
AND location <> 'Low income'
AND location <> 'International'
AND location <> 'European Union'
GROUP BY location
ORDER BY highest_deaths DESC

-- Persentase kematian karena covid di setiap benua
SELECT location, date, total_deaths, total_cases, ROUND(CAST(total_deaths as DECIMAL(20, 2))/CAST(total_cases as DECIMAL(20, 2))*100, 2) AS death_percentage
FROM covid_data
WHERE continent is null
AND location <> 'Upper middle income'
AND location <> 'World'
AND location <> 'High income'
AND location <> 'Lower middle income'
AND location <> 'Low income'
AND location <> 'International'
AND location <> 'European Union'
ORDER BY location, date



