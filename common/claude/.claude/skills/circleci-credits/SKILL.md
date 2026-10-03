---
name: circleci-credits
description: Use when CircleCI credits or storage run out, CI is slow or expensive, or the user wants to optimize/cheapen a CircleCI pipeline in any project (Laravel/PHP + node especially). Checklist of what to measure and which levers actually pay off, learned on arzhub (Oct 2026).
---

# Экономия кредитов CircleCI

Опыт arzhub (октябрь 2026, PR #410, задача #409): Free-план, 30 000 кредитов в месяц
кончались за две недели. Сначала мерить, потом резать — интуиция врала не раз.

## 1. Замерить

- Кредиты по заданиям — Insights API (токен `CIRCLECI_TOKEN`, личный):
  `GET /api/v2/insights/gh/<org>/<repo>/workflows` → по workflow,
  `…/workflows/<wf>/jobs?all-branches=true` и `&branch=master` → по заданиям.
  Смотреть `total_credits_used`, медиану длительности, долю master.
- Шаги задания и их время — `GET /api/v1.1/project/github/<org>/<repo>/<build_num>` → `steps[].actions[].run_time_millis`.
- Тесты по времени — junit. Внимание: junit из `paratest --parallel` у нас был неполным
  (1064 из 1801) — для честных цифр гонять последовательно.
- Free: 2 ГБ·мес хранилища и 1 ГБ сети, сверх — **420 кредитов за ГБ** из тех же кредитов.
  **Сроки хранения на Free не настраиваются** (Plan → Usage Controls есть только у платных):
  workspace и кэши 15 дней, артефакты 30. Экономить можно только тем, что кладёшь.
- CircleCI MCP (`@circleci/mcp-server-circleci`, user scope) — логи, flaky, usage CSV.

## 2. Рычаги по убыванию эффекта (arzhub)

1. **Xdebug в тестах выключить: `-e XDEBUG_MODE=off`** в `docker run` шага тестов.
   Образ разработки держал Xdebug в `develop` — весь PHP вдвое медленнее. Вместе с п. 3
   (лишний сид) шаг тестов на CI 213 → 64 с. Проверять **эффективный** режим:
   `php -r 'var_dump(xdebug_info("mode"));'` — `ini_get` врёт, env его не показывает.
   Локально: `composer test` со `"@putenv XDEBUG_MODE=off"`, в `docker compose exec` — `-e XDEBUG_MODE=off`.
2. **Покрытие не считать, если цифру никто не смотрит** (clover лежал артефактом
   без потребителя; с xdebug coverage прогон +50%).
3. **Тесты, гоняющие тяжёлый импорт/сид в каждом методе** — главная статья CPU.
   Лечение: общий снимок базы раз на процесс. SQLite `:memory:` + RefreshDatabase:
   первый тест пишет импортированные таблицы в файл, остальные `ATTACH` +
   `DELETE`/`INSERT INTO main.t SELECT * FROM snap.t` внутри своей транзакции
   (18 мс против 2–6 с). `DETACH` в транзакции падает — держать подключённым.
   Тесты, проверяющие сам импорт, оставить честными.
4. **Не гонять пайплайн на коммитах только с документацией** — dynamic config
   (`setup: true` + орб `circleci/continuation`; галка Project Settings → Advanced →
   «Enable dynamic config using setup workflows»). Setup-задание на `cimg/base`,
   `resource_class: small`, ~7 с: на master `git diff pipeline.git.base_revision..HEAD`,
   на ветке — от `merge-base` с master; только `docs/**`, `*.md` → `circleci-agent step halt`
   без continuation. Проверять `grep` в чистом bash (обёртки шелла врут).
5. **Без workspace**: каждое задание само делает checkout и берёт зависимости из кэша.
   `persist_to_workspace ./*` с `vendor` на каждый прогон — главный расход хранилища.
6. **Кэш npm — `~/.npm`, не `node_modules`**: `npm ci` сносит `node_modules`.
7. **Blade + paratest на холодном кэше**: шаблон компилируется не атомарно, воркеры
   читают недописанный файл («Unclosed '('» в случайном тесте). `php artisan view:cache`
   перед тестами.

## 3. Что почти не даёт

- **`resource_class` и docker вместо machine.** Тесты упираются в CPU: large в 2× дороже
  и в ~2× быстрее — кредиты те же. Docker экономит только накладные (~20 с из 230).
- **Двойной вызов дешёвой команды** — мерить, прежде чем чинить (у нас 0,01 с).
- **Замеры, снятые с Xdebug, врут о пропорциях.** Агент насчитал 35–40 с на «пороге
  каталога» (5000 строк-заглушек в фейках HTTP); без Xdebug это 3 с — не стали делать.
  Сначала выключить Xdebug, потом мерить остальное.
- **Лишний сид перед импортом** может превращать первый прогон из базовой линии в
  правку (журнал изменений на десятки тысяч строк) — искать устаревшие тестовые хелперы.

## 4. Открытое решение

Гонять ли тесты на master после вливания PR (половина прогонов — master, код уже
проверен на ветке). Риск — ветка отстала от master. Решать после ускорения тестов.
