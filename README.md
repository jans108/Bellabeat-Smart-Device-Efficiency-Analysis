# Bellabeat Smart Trends: Analiza Aktywności i Spalania Kalorii

## Opis projektu
Celem tego projektu było przeprowadzenie kompleksowej analizy danych dotyczących użytkowania urządzeń smart, aby wyłonić kluczowe trendy w zakresie aktywności fizycznej i spalania kalorii. W efekcie zidentyfikowano, że wysoki poziom intensywności ćwiczeń ma największy wpływ na spalanie kalorii, co stanowi cenny insight dla optymalizacji strategii marketingowej produktu Bellabeat.

## Cel biznesowy (wymyślony)
Projekt został zlecony w celu:
- Zrozumienia, jak użytkownicy korzystają z urządzeń smart nieprodukowanych przez Bellabeat.
- Wyłonienia trendów, które można zastosować w strategii marketingowej jednego z produktów Bellabeat.


## Dane
- **Źródło danych:** FitBit Fitness Tracker Data z Kaggle.
- **Okres:** Dane z 2016 roku.
- **Opis:** Zestaw danych zawiera informacje dotyczące aktywności fizycznej, takie jak kroki, czas aktywności (podzielony na lekką, umiarkowaną i bardzo intensywną) oraz liczbę spalonych kalorii.

## Etapy projektu

### 1. Przygotowanie danych
- **Pobranie i walidacja:** Dane zostały pobrane z Kaggle, a następnie zaimportowane do SQL Server.
- **Czyszczenie i transformacja:** Przeprowadzono konwersję typów danych, usunięcie wartości null oraz wykrywanie i eliminację outlierów (szczegółowy kod SQL znajduje się w pliku `DataPrepering.sql`).

### 2. Analiza danych
- **Korelacja:** Obliczono współczynniki korelacji pomiędzy czasem spędzonym na różnego rodzaju aktywnościach (bardzo intensywnych, umiarkowanych i lekkich) a liczbą spalonych kalorii przy użyciu funkcji `cor()` w języku R.
- **Wyniki:** Najwyższą korelację wykazują bardzo intensywne aktywności (r = 0.61).

### 3. Wizualizacja
- **Narzędzie:** Tableau.
- **Cel:** Utworzono wykresy rozrzutu, które wizualizują zależność między intensywnością aktywności a spalaniem kalorii, umożliwiając szybkie zrozumienie kluczowych trendów przez interesariuszy.

## Wnioski
Wyniki analizy wskazują, że promowanie wysokiej intensywności ćwiczeń może znacząco wpłynąć na efektywność produktów Bellabeat poprzez zwiększenie spalania kalorii oraz poprawę satysfakcji klientów.

## Technologie
- **SQL Server** – przygotowanie i czyszczenie danych.
- **R** – analiza statystyczna.
- **Tableau** – wizualizacja danych.
- **Kaggle** – źródło danych.

## Jak uruchomić projekt
1. **Pobierz dane** z repozytorium Kaggle: [FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit).
2. **Uruchom skrypty SQL** z pliku `DataPrepering.sql`, aby przygotować dane do analizy.
3. **Przeprowadź analizę korelacji** w R, korzystając z dostarczonych skryptów.
4. **Otwórz wizualizacje** w PowerPoint, aby zapoznać się z przedstawionymi trendami.

## Podsumowanie
Projekt ten jest przykładem podejścia opartego na danych, gdzie kompleksowa analiza oraz wizualizacja wyników przyczyniły się do sformułowania strategicznych rekomendacji marketingowych. Jest to idealny projekt, który prezentuje umiejętność pracy z danymi oraz zdolność do wyciągania istotnych wniosków wspierających decyzje biznesowe.
