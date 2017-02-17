#!/usr/bin/env bash

set -e
set -o pipefail

PG_DB=$1
PG_USER=$2
BASE_DIR=$3
DATA_DIR=$4

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <PG_DB> <PG_USER> <BASE_DIR> <DATA_DIR>" >&2
    exit 1
fi

echo "[contrib/gwascatalog] [INFO] `date +"%Y-%m-%d %H:%M:%S"` Fetching data..."

TODAY=$(date +"%Y-%m-%d")
mkdir -p ${DATA_DIR}/${TODAY}
cd ${DATA_DIR}/${TODAY}

wget -c "ftp://ftp.ebi.ac.uk/pub/databases/gwas/releases/latest/gwas-catalog-associations_ontology-annotated.tsv" -O gwascatalog-associations.tsv
wget -c "ftp://ftp.ebi.ac.uk/pub/databases/gwas/releases/latest/gwas-catalog-ancestry.tsv"                        -O gwascatalog-ancestry.tsv

echo "[contrib/gwascatalog] [INFO] `date +"%Y-%m-%d %H:%M:%S"` Importing data..."

table=GwasCatalogAssociations
filename=gwascatalog-associations.tsv
${BASE_DIR}/script/cleanup_associations.py ${filename}| \
    psql $PG_DB $PG_USER --no-psqlrc --single-transaction -c "TRUNCATE ${table}; COPY ${table} FROM stdin DELIMITERS '	' WITH NULL AS ''"

table=GwasCatalogAncestry
filename=gwascatalog-ancestry.tsv
${BASE_DIR}/script/cleanup_ancestry.py ${filename}| \
    psql $PG_DB $PG_USER --no-psqlrc --single-transaction -c "TRUNCATE ${table}; COPY ${table} FROM stdin DELIMITERS '	' WITH NULL AS ''"

echo "[contrib/gwascatalog] [INFO] `date +"%Y-%m-%d %H:%M:%S"` Done"
