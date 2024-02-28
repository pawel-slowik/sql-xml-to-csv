# Convert MySQL / MariaDB XML into CSV

This is a XSLT 1.0 transformation that converts MySQL / MariaDB XML output into
CSV format.

It can be useful for dumping database contents into CSV files when you can't use
the `SELECT ... INTO OUTFILE ...` syntax.


## Usage

    echo 'SELECT * FROM table' | \
    mariadb --batch --xml --host localhost --user user --password=password db | \
    xsltproc xml2csv.xslt - > output.csv


## TODO

* parametrize:
    - column separators
    - column enclosing characters
    - escaping for column enclosing characters
    - row separators / newlines
    - escaping for row separators / newlines

* add support for `mysqldump` XML format
