# Pwned Antifas

The app works off-line and is just two files: `dist/index.html` and `dist/app.js`.

## Requirements

* [Python 3.8](https://python.org) with [Poetry](https://python-poetry.org/) to read the names and generates the hashes from the PDF source
* `java` available in your system Path (since we use [Apache Tika](https://tika.apache.org/)'s Python wrapper to convert PDF to text)
* [NodeJS](https://nodejs.org/en/) with `npm` for the front-end

## Installing dependencies

```console
$ poetry install
$ npm install
```

## Creating `dist/index.html`

```console
$ poetry run python create_html.py [<PATH TO PDF FILE>]
```

## Creating `dist/app.js`

```
$ npm run build
```

## Loading the app

```console
$ open dist/index.html
```

## For Elm developers

```console
$ npm start
```
