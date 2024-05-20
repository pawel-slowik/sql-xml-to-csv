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


## TODO

* parametrize:
    - row separators / newlines
    - escaping for row separators / newlines
