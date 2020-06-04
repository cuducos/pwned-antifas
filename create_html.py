from hashlib import sha512
from itertools import zip_longest
from json import dumps
from pathlib import Path

import click
from tika import parser


INDEX_HTML = """<html>
<head>
  <meta charset="UTF-8">
  <title>pwned-antifas</title>
  <script src="app.js"></script>
</head>
<body>
  <div id="pwned-antifas"></div>
  <script>
  var app = Elm.Main.init({
    node: document.getElementById('pwned-antifas'),
    flags: /* hashes */
  });
  </script>
</body>
</html>"""


@click.command()
@click.argument(
    "pdf_path", type=click.Path(exists=False, dir_okay=False, readable=True)
)
def create_json(pdf_path):
    """Parse the PDF with sensitive information generating the index.html with
    hashes of the names of the people listed in the document. The index.html
     comes with the basic Elm app structure."""
    click.echo(f"Parsing to {pdf_path}.")
    parsed = parser.from_file(pdf_path)
    lines = [line for line in parsed["content"].split("\n") if line.strip()]

    hashes = []
    click.echo("Filtering and hashing names.")
    for label, value in zip_longest(lines, lines[1:]):
        if "nome" not in label.lower():
            continue

        hashed = sha512(value.encode("utf8"))
        hashes.append(hashed.hexdigest())

    index = Path() / "dist" / "index.html"
    contents = INDEX_HTML.replace("/* hashes */", dumps(hashes))
    index.write_text(contents)
    click.echo(f"Saved to {index}.")


if __name__ == "__main__":
    create_json()
