--1. Tableau

SELECT sum(new_cases) as total_cases, sum(CAST(new_deaths as int)) as total_deaths, Sum(CAST(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
FROM Port..CovidDeaths
--where location like '%india%'
WHERE continent is not null
--GROUP BY date
ORDER BY 1,2

--2. Tableau

--European union,world,international we don't consider

SELECT location, SUM(cast(total_deaths as int)) as totaldeathcount
From  Port..CovidDeaths
--where location like '%india%'
WHERE continent is null
and location not in ('World','European Union','International')
GROUP BY location
ORDER BY totaldeathcount desc

--3.Tableau

--looking at countires with highest infection rate compared to population

SELECT location, population, Max(total_cases) as HighestInfectioncount, Max((total_cases/population))*100 as 
 PercentPopulationInfected
From  Port..CovidDeaths
--where location like '%india%'
--WHERE continent is not null
GROUP BY location, population
ORDER BY PercentPopulationInfected desc

--4.Tableau

SELECT location, population, date, Max(total_cases) as HighestInfectioncount, Max((total_cases/population))*100 as 
 PercentPopulationInfected
From  Port..CovidDeaths
--where location like '%india%'
--WHERE continent is not null
GROUP BY location, population, date
ORDER BY PercentPopulationInfected desc

--5

SELECT dea.continent, dea.location, dea.date, dea.population, SUM(CAST(vac.new_vaccinations as int)) as RollingPeopleVaccinated
--OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM Port..CovidDeaths dea 
Join Port..CovidVacc vac
    on dea.location=vac.location
	and dea.date=vac.date
WHERE dea.continent IS  NOT NULL
and dea.location not in ('World','European Union','International') and dea.location like '%india%'
group by  dea.location, dea.date, dea.population
ORDER BY 1,2,3


