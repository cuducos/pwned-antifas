# Pwned Antifas

## Requirements

* [Python 3.8](https://python.org) with [https://python-poetry.org/](https://python-poetry.org/) to read the names and generates the hashes from the PDF source
* [https://nodejs.org/en/](https://nodejs.org/en/) with `npm` for the front-end
* `java` available in your system Path (since we use [Apache Tika](https://tika.apache.org/) to convert PDF to text)

## Installing dependencies

```console
$ poetry install
$ npm install
```

## Creating the HTML

```console
$ poetry run python create_html.py <PATH TO PDF FILE>
```

## Creating the JS

```
$ npm run build
```

## Loading the app

```console
$ open dist/index.html
```

