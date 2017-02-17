# gwascatalog-pg

PostgreSQL schema for NHGRI-EBI GWAS Catalog


## How to use

Eg.

```
=> SELECT
       snp_id, mapped_trait, broad_ancestral_category
   FROM
       gwascatalogassociations LEFT JOIN gwascatalogancestry USING (study_accession);

  snp_id  |           mapped_trait           | broad_ancestral_category
----------+----------------------------------+--------------------------
   380390 | age-related macular degeneration | European
  7702187 | Parkinson's disease              | Asian unspecified
  7702187 | Parkinson's disease              | Other
  7702187 | Parkinson's disease              | European
  7702187 | Parkinson's disease              | Asian unspecified
  7702187 | Parkinson's disease              | Other
  7702187 | Parkinson's disease              | European
 10494366 | QT interval                      | European
 10494366 | QT interval                      | European
  1480597 | Parkinson's disease              | European
...
```

## How to install

Eg.

```
$ createuser gwas
$ createdb gwas --owner=gwas

$ ./00_drop_create_table.sh gwas gwas $PWD
$ ./01_import_latest_data.sh gwas gwas $PWD ~/Downloads/gwas
```


## References

- *NHGRI-EBI GWAS Catalog data*

> Burdett T (EBI), Hall PN (NHGRI), Hasting E (EBI) Hindorff LA (NHGRI), Junkins HA (NHGRI), Klemm AK (NHGRI), MacArthur J (EBI), Manolio TA (NHGRI), Morales J (EBI), Parkinson H (EBI) and Welter D (EBI).
> The NHGRI-EBI Catalog of published genome-wide association studies.
> Available at: www.ebi.ac.uk/gwas. Accessed [date of access], version [version number].
> version number only applies to the download spreadsheet - v1.0 for the traditional version of the spreadsheet, v1.0.1 for the version with added EFO terms
