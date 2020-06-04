from hashlib import sha512
from itertools import zip_longest
from json import dumps
from pathlib import Path

import click
from tika import parser


@click.command()
@click.argument(
    "pdf_path", type=click.Path(exists=False, dir_okay=False, readable=True)
)
def create_html(pdf_path):
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
        hashes.append(hashed.hexdigest()[:100])

    template = Path() / "index.template.html"
    index = Path() / "dist" / "index.html"
    contents = template.read_text().replace("/* insert hashes here */", dumps(hashes))
    index.write_text(contents)
    click.echo(f"Saved to {index}.")


if __name__ == "__main__":
    create_html()
