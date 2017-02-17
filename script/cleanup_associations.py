#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import csv
import argparse
from pg_type import *


def _main():
    parser = argparse.ArgumentParser()
    parser.add_argument('associations')
    args = parser.parse_args()

    cols_map = [
        ('DATE ADDED TO CATALOG',          date),
        ('PUBMEDID',                       int),
        ('FIRST AUTHOR',                   str),
        ('DATE',                           date),
        ('JOURNAL',                        str),
        ('LINK',                           str),
        ('STUDY',                          str),
        ('DISEASE/TRAIT',                  str),
        ('INITIAL SAMPLE SIZE',            str),
        ('REPLICATION SAMPLE SIZE',        str),
        ('REGION',                         str),
        ('CHR_ID',                         str),
        ('CHR_POS',                        str),
        ('REPORTED GENE(S)',               str),
        ('MAPPED_GENE',                    str),
        ('UPSTREAM_GENE_ID',               str),
        ('DOWNSTREAM_GENE_ID',             str),
        ('SNP_GENE_IDS',                   str),
        ('UPSTREAM_GENE_DISTANCE',         int),
        ('DOWNSTREAM_GENE_DISTANCE',       int),
        ('STRONGEST SNP-RISK ALLELE',      str),
        ('SNPS',                           str),
        ('MERGED',                         boolean),
        ('SNP_ID_CURRENT',                 str),
        ('CONTEXT',                        str),
        ('INTERGENIC',                     boolean),
        ('RISK ALLELE FREQUENCY',          str),
        ('P-VALUE',                        probability),
        ('PVALUE_MLOG',                    float),
        ('P-VALUE (TEXT)',                 str),
        ('OR or BETA',                     float),
        ('95% CI (TEXT)',                  str),
        ('PLATFORM [SNPS PASSING QC]',     str),
        ('CNV',                            str),
        ('MAPPED_TRAIT',                   str),
        ('MAPPED_TRAIT_URI',               str),
        ('STUDY ACCESSION',                str),

        # Utility columns
        ('SNP_ID_CURRENT',                 rsid),
    ]

    reader = csv.DictReader(open(args.associations), delimiter='\t')
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
