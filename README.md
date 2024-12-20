# Convert MySQL / MariaDB XML into CSV

This is a XSLT 1.0 transformation that converts MySQL / MariaDB XML output into
CSV format.

It can be useful for dumping database contents into CSV files when you can't use
the `SELECT ... INTO OUTFILE ...` syntax.


## Usage

With the CLI client:

    echo 'SELECT * FROM table' | \
    mariadb --batch --xml --host localhost --user user --password=password db | \
    xsltproc xml2csv.xslt - > output.csv

With the `mysqldump` CLI utility:

    mysqldump --xml --host localhost --user user --password=password db table | \
    xsltproc xml2csv.xslt - > output.csv

Using `;` instead of the default `,` as column separators:

    mysqldump --xml --host localhost --user user --password=password db table | \
    xsltproc --stringparam column_separator ';' xml2csv.xslt - > output.csv


### Parameters

- `column_separator` - string used to separate columns. This is the equivalent
  of the `TERMINATED BY ...` option for `SELECT ... INTO OUTFILE ...`. Default
  is `,`.
- `column_enclosed_by` - string used to quote column values. This is meant to be
  the equivalent of the `ENCLOSED BY ...` option, but its handling may be
  slightly different. Default is `"`. Can be empty.
- `column_escaped_by` - string used to escape the `column_enclosed_by`
  character.  This is roughly equivalent to the `ESCAPED BY ...` option.
  Default is `\`.


## End of line processing

The XML engine does not distinguish between various [newline
representations](https://en.wikipedia.org/wiki/End_of_line). Therefore any
required end of line processing should be performed separately. This could be
implemented either before any XML processing, e.g. in SQL queries, or after
finishing it, with tools like `sed`, `tr`, `dos2unix` etc.

`xsltproc`'s internal representation of a newline can be verified like this:

    printf '<?xml version="1.0"?><root>a\nb</root>' | xsltproc test_newlines.xslt -

    printf '<?xml version="1.0"?><root>a\rb</root>' | xsltproc test_newlines.xslt -

The output is the same for both cases, even though they contain data with
different line endings.


## TODO

* parametrize:
    - escaping for row separators / newlines
