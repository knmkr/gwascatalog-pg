#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import csv
import argparse
from pg_type import *


def _main():
    parser = argparse.ArgumentParser()
    parser.add_argument('ancestry')
    args = parser.parse_args()

    cols_map = [
        ('STUDY ACCCESSION',               str),
        ('PUBMEDID',                       int),
        ('FIRST AUTHOR',                   str),
        ('DATE',                           date),
        ('INITIAL SAMPLE DESCRIPTION',     str),
        ('REPLICATION SAMPLE DESCRIPTION', str),
        ('STAGE',                          str),
        ('NUMBER OF INDIVDUALS',           int),
        ('BROAD ANCESTRAL CATEGORY',       str),
        ('COUNTRY OF ORIGIN',              str),
        ('COUNTRY OF RECRUITMENT',         str),
        ('ADDITONAL ANCESTRY DESCRIPTION', str),
    ]

    reader = csv.DictReader(open(args.ancestry), delimiter='\t')
    writer = csv.writer(sys.stdout, delimiter='\t')

    for record in reader:
        row = []
        for name, col_type in cols_map:
            value = record[name].strip()
            value = {'NR': '', 'NS': ''}.get(value, value)   # null symbols

            if value != '':
                try:
                    value = col_type(value)
                except (ValueError, KeyError):
                    msg = '[WARN] {}? key:{}, value:{}'.format(col_type, name, record[name])
                    print >>sys.stderr, msg

                    value = ''

            row.append(value)

        writer.writerow(row)


if __name__ == '__main__':
    import doctest
    doctest.testmod()
    _main()
