### Metryki Wydajności Gracza:

1. **Liderzy W Punktacji**: Określamy, kto jest najlepszym strzelcem na podstawie kolumny `pts`.
``` sql
SELECT player_name, AVG(pts) as avg_points
FROM all_seasons
GROUP BY player_name
ORDER BY avg_points DESC
LIMIT 10;
```
2. **Liderzy Asyst**: Identyfikujemy graczy, którzy mają najwięcej asyst na podstawie kolumny `ast`.
``` sql
SELECT player_name, AVG(ast) as avg_assists
FROM all_seasons
GROUP BY player_name
ORDER BY avg_assists DESC
LIMIT 10;
```
3. **Liderzy Zbiórek**: Analizujemy, kto dominuje w zbiórkach, używając kolumny `reb`.
``` sql
SELECT player_name, AVG(reb) as avg_rebounds
FROM all_seasons
GROUP BY player_name
ORDER BY avg_rebounds DESC
LIMIT 10;
```
4. **Wskaźnik Efektywności Gracza (WEG)**: Analizujemy efektywność graczy kożystając z kolumn, takich jak `pts`, `reb`, `ast`, aby wygenerować Wskaźnik Efektywności Gracza (WEG).
``` sql
SELECT player_name, AVG((pts + reb + ast) / gp) as per
FROM all_seasons
GROUP BY player_name
ORDER BY per DESC
LIMIT 10;
```

### Metryki na Poziomie Drużyny:

1. **Średni Wiek Drużyny**: Obliczamy średni wiek graczy w każdej drużynie.
``` sql
SELECT team_abbreviation, AVG(age) as avg_age
FROM all_seasons
GROUP BY team_abbreviation
ORDER BY avg_age DESC;
```
2. **Poziom Umiejętności Drużyny**: Uśredniamy statystyki gracza, takie jak punkty, zbiórki i asysty dla każdej drużyny, aby uzyskać wynik wydajność zespołu.
``` sql
SELECT team_abbreviation, AVG(pts) as avg_points, AVG(reb) as avg_rebounds, AVG(ast) as avg_assists
FROM all_seasons
GROUP BY team_abbreviation;
```
3. **Różnorodność w Drużynach**: Mierzymy różnorodność w drużynach na podstawie kolumn `country`.
``` sql
SELECT team_abbreviation, COUNT(DISTINCT country) as num_countries
FROM all_seasons
GROUP BY team_abbreviation
ORDER BY num_countries DESC;
```

4. **Różnorodność w Drużynach**: Mierzymy różnorodność w drużynach na podstawie kolumn `college`.
``` sql
SELECT team_abbreviation, COUNT(DISTINCT college) as colleges
FROM all_seasons
GROUP BY team_abbreviation
ORDER BY num_countries DESC;
```

### Analiza Czasowa:

1. **Postęp w Karierze Gracza**: Analizujemy zmiany w statystykach gracza przez wiele sezonów.
``` sql
SELECT player_name, season, AVG(pts) AS avg_points, AVG(reb) AS avg_rebounds, AVG(ast) AS avg_assists
FROM all_seasons
GROUP BY player_name, season
ORDER BY player_name, season;
```
2. **Wyniki zespołu w poszczególnych sezonach**: Analizujemy, jak różne drużyny radziły sobie w różnych sezonach.
``` sql
SELECT team_abbreviation, season, AVG(pts) AS avg_points
FROM all_seasons
GROUP BY team_abbreviation, season
ORDER BY team_abbreviation, season;
```

### Zaawansowane Metryki:

1. **Efektywność Wykorzystania Oddanych Strzałów**: Porównujemy `usg_pct` (Procent Zagrań Zespołowych Wykorzystanych Przez Gracza) z `ts_pct` (Miara skuteczności strzeleckiej zawodnika), aby zobaczyć, kto jest bardziej efektywny z piłką.
``` sql
SELECT player_name, AVG(usg_pct) AS avg_usage, AVG(ts_pct) AS avg_true_shooting
FROM all_seasons
GROUP BY player_name;
```
2. **Wkład Zadowdnika W Grę w Zespołąch**: Użyjemy `net_rating`, aby zidentyfikować graczy, którzy pozytywnie lub negatywnie wpływają na grę, gdy są na boisku.
``` sql
SELECT player_name, AVG(net_rating) AS avg_net_rating
FROM all_seasons
GROUP BY player_name
ORDER BY avg_net_rating DESC;
```

### Porównania Statystyczne:

1. **Wiek a Wydajność**: Analizujemy czy wiek znacząco wpływa na metryki takie jak punkty, zbiórki i asysty.
``` sql
SELECT age, AVG(pts) AS avg_points, AVG(reb) AS avg_rebounds, AVG(ast) AS avg_assists
FROM all_seasons
GROUP BY age
ORDER BY age;
```
2. **Wpływ Uczelni**: Analizujemy czy gracze z niektórych uczelni radzą sobie lepiej niż inni..
``` sql
SELECT college, AVG(pts) AS avg_points
FROM all_seasons
GROUP BY college
ORDER BY avg_points DESC;
```

### Analiza Geograficzna:

1. **Międzynarodowy Talent**: Na podstawie kolumny `country` analizujemy wkład międzynarodowych graczy.
``` sql
SELECT country, COUNT(*) AS num_players
FROM all_seasons
GROUP BY country
ORDER BY num_players DESC;
```

### Metryki Jakości Danych:

1. **Brakujące Wartości**: Sprawdzamy, czy są jakiekolwiek brakujące lub niespójne dane i jaki jest ich wpływ na analizę.
``` sql
-- W tym zapytaniu zakłądamy, że NULL reprezentuje brakujące wartości
SELECT COUNT(*) - COUNT(age) AS missing_age, COUNT(*) - COUNT(pts) AS missing_points
FROM all_seasons;

```
2. **Outliery**: Szukamy statystycznych wartości odstających, które mogą być błędnymi danymi lub oznaczać wyjątkową wydajność.
``` sql
-- Przykład dla punktów aby znaleźć w nich wartości odstające
SELECT player_name, pts
FROM all_seasons
WHERE pts > (SELECT AVG(pts) + 3 * STDDEV(pts) FROM all_seasons)
OR pts < (SELECT AVG(pts) - 3 * STDDEV(pts) FROM all_seasons);

```

