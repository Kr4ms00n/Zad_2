# Zadanie 2: Weather App z GitHub Actions CI/CD

---

## Wstęp

To repozytorium zawiera aplikację pogodową Flask i zaimplementowany potok **Continuous Integration/Continuous Deployment (CI/CD)** z wykorzystaniem **GitHub Actions**. Zadanie polegało na zautomatyzowaniu procesu budowania, skanowania bezpieczeństwa i publikowania obrazów Docker.

---

## Opis Projektu

**Weather App** to prosta aplikacja Flask, która pozwala użytkownikom sprawdzać pogodę w wybranych miastach, pobierając dane z API OpenWeatherMap.

---

## Kluczowe Elementy Implementacji

* **`app.py`**: Aplikacja Flask z endpointem `/health` do healthchecków.
* **`Dockerfile`**: Zoptymalizowany pod kątem bezpieczeństwa, tworzy nieuprzywilejowanego użytkownika (`appuser`) i zawiera `HEALTHCHECK`.
* **Sekrety GitHub**: Bezpieczne przechowywanie `DOCKERHUB_USERNAME` i `DOCKERHUB_TOKEN` dla operacji Docker.
* **`.github/workflows/build-and-deploy.yml`**: Główne repozytorium CI/CD, które:
    * Loguje się do GitHub Container Registry i DockerHub (do cache).
    * Generuje automatyczne tagi dla obrazów.
    * **Buduje obraz testowy (AMD64)**.
    * **Skanuje obraz za pomocą Trivy** pod kątem podatności (zatrzymuje pipeline przy CRITICAL/HIGH).
    * Wysyła wyniki skanowania do GitHub Security.
    * **Buduje i wypycha obraz multi-arch** (`linux/amd64`, `linux/arm64`) do GitHub Container Registry.
    * Aktualizuje cache obrazów na DockerHub.
    * Podsumowuje przebieg builda.

---

## Potwierdzenie Działania

Potok GitHub Actions został pomyślnie uruchomiony i zakończył się sukcesem. Możesz to zweryfikować tutaj:https://github.com/Kr4ms00n/Zad_2/actions/runs/15400611599

Obraz Docker został zbudowany dla obu architektur i opublikowany w GitHub Container Registry.
