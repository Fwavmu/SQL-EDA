-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

-- Maximum layoffs and highest layoff percentage
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Companies that laid off 100% of staff
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Total layoffs by company
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Total layoffs by industry
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Total layoffs by country
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Total layoffs by year
SELECT YEAR (`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR (`date`)
ORDER BY 1 DESC;

-- Earliest and latest dates in the dataset
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Rolling totals 

SELECT SUBSTRING(`date` ,6,2) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `MONTH`;

-- Monthly layoffs
SELECT SUBSTRING(`date` ,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date` ,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

-- Monthly rolling total of layoffs
WITH Rolling_Total AS (
SELECT SUBSTRING(`date` ,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date` ,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC)
SELECT `MONTH`,total_off, SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

-- Company layoffs per year
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- Rank company

-- Ranking companies per year
WITH Company_year (company, years, total_laoid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *
FROM Company_year;
