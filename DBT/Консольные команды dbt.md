# Консольные команды DBT
[Документация](https://docs.getdbt.com/reference/node-selection/syntax)

#### dbt run
- `dbt run` - запускает все модели в текущем проекте.
- `dbt run --models +customerrevenue` - выполнит все предыдущие модели, на которые ссылкается customerrevenue, а потом саму модель `customerrevenue`.
- `dbt run -s +model_a` - пересчитает или создаст таблицу `model_a`.
- `dbt run -s +model_a` - пересчитает все модели до `model_a` и саму модель `model_a`.
- `dbt run -s model_a+` - пересчитает текущую модель `model_a` и все модели, которые от неё зависят выше по цепочке.
- `dbt run -s sourse: source_name+` - пересчитает всё, что зависит от таблиц в источнике `source_name`. (Вместо run жно compile.)
- `dbt run -s sourse: source_name.table_name+` - пересчитает всё, что зависит от таблицы `table_name` в источнике source_name.
- `dbt run -s имя модели -d` - запуск модели с `debug`.
- - `dbt run --vars '{load_id: "ваше_значение"}'` - Запуск модели с определенным значением переменной.
- `dbt run --vars '{load_id: "ваше_значение", source: "ваше_значение"}'` - Запуск модели с определенными значениями нескольких переменных.
#### dbt compile
- `dbt compile` - скомпилирует sql-файл.
#### dbt seed
- `dbt seed` - создаёт таблицу из csv-файла `seeds`.
#### dbt test
- `dbt test` - проверка результатов теста.
- `dbt test --select customers` - запуск теста одной модели за раз.
- `dbt source freshness` - обновление источников.
- `dbt test --select "source:*"` Запуск тестов для всех источников. (Здесь также можно использовать сокращение -s вместо --select)
- `dbt test --select source:jaffle_shop` Запуск тестов для одного источника (и всех его таблиц).
- `dbt test --select source:jaffle_shop.orders`Запуск тестов только на одной исходной таблице.
#### dbt docs
- `dbt docs generate` - объединяет всю настроенную документацию в рамках проекта, включая информацию, извлечённую как из хранилища, так и из кода dbt и создаёт документацию.
- `dbt docs serve` - делает документацию доступной для всех.
- `dbt deps` - импортирует код из репозиториев пакетов. (При добавлении, удалении, обновлении версий пакетов.)
- `dbt snapshot` - запуск `snapshots`.
#### dbt build
- `dbt build` - запускает всё в проекте.
#### dbt clean
- `dbt clean` - это служебная функция, которая удаляет все папки, указанные в списке `clean-targets`, указанном в `dbt_project.yml`. Вы можете использовать ее для удаления dbt_packages и целевых каталогов.
#### db ls
- `dbt ls --select "path/to/my/models"` Перечисляет все модели в определенном каталоге.
- `dbt ls --select "source_status:fresher+"` Показывает источники, обновленные с момента последнего запуска dbt source freshness.
- `dbt ls --select state:modified+` Отображает узлы, измененные по сравнению с предыдущим состоянием.
- `dbt ls --select "result:<status>+" state:modified+ --state ./<dbt-artifact-path>` Список узлов, которые соответствуют определенным статусам результатов и изменены.
- Также можете установить переменную окружения `DBT_ARTIFACT_STATE_PATH` вместо флага `--state`.
- `dbt source freshness` Необходимо запустить снова, чтобы сравнить текущее состояние с предыдущим `dbt build --select "source_status:fresher+" --state path/to/prod/artifacts`