--
-- Table for `associations download files`
--
DROP TABLE IF EXISTS GwasCatalogAssociations;
CREATE TABLE GwasCatalogAssociations (
                                                        -- File headers for catalog version 1.0
                                                        -- ====================================
                                                        --
                                                        -- http://www.ebi.ac.uk/gwas/docs/fileheaders#_file_headers_for_catalog_version_1_0
                                                        --
                                                        -- Last updated: 12 January 2016
                                                        --
    date_added_to_catalog           date,               -- DATE ADDED TO CATALOG: Date a study is published in the catalog
    pubmed_id                       integer  not null,  -- PUBMEDID: PubMed identification number
    first_author                    varchar  not null,  -- FIRST AUTHOR: Last name and initials of first author
    "date"                          date     not null,  -- DATE: Publication date (online (epub) date if available)
    journal                         varchar  not null,  -- JOURNAL: Abbreviated journal name
    link                            varchar  not null,  -- LINK: PubMed URL
    study                           varchar  not null,  -- STUDY: Title of paper
    disease_or_trait                varchar  not null,  -- DISEASE/TRAIT: Disease or trait examined in study
    initial_sample_description      varchar  not null,  -- INITIAL SAMPLE DESCRIPTION:
                                                        --   Sample size and ancestry description for stage 1 of GWAS
                                                        --   (summing across multiple Stage 1 populations, if applicable)
    replication_sample_description  varchar,            -- REPLICATION SAMPLE DESCRIPTION:
                                                        --   Sample size and ancestry description for subsequent replication(s)
                                                        --   (summing across multiple populations, if applicable)
    region                          varchar,            -- REGION: Cytogenetic region associated with rs number
    chr_id                          varchar,            -- CHR_ID: Chromosome number associated with rs number
    chr_pos                         varchar,            -- CHR_POS: Chromosomal position associated with rs number
    reported_gene                   varchar,            -- REPORTED GENE(S): Gene(s) reported by author
    mapped_gene                     varchar,            -- MAPPED GENE(S):
                                                        --   Gene(s) mapped to the strongest SNP. If the SNP is located within a gene,
                                                        --   that gene is listed. If the SNP is intergenic, the upstream and downstream
                                                        --   genes are listed, separated by a hyphen.
    upstream_gene_id                varchar,            -- UPSTREAM_GENE_ID: Entrez Gene ID for nearest upstream gene to rs number, if not within gene
    downstream_gene_id              varchar,            -- DOWNSTREAM_GENE_ID: Entrez Gene ID for nearest downstream gene to rs number, if not within gene
    snp_gene_ids                    varchar,            -- SNP_GENE_IDS: Entrez Gene ID, if rs number within gene; multiple genes denotes overlapping transcripts
    upstream_gene_distance          real,               -- UPSTREAM_GENE_DISTANCE: distance in kb for nearest upstream gene to rs number, if not within gene
    downstream_gene_distance        real,               -- DOWNSTREAM_GENE_DISTANCE: distance in kb for nearest downstream gene to rs number, if not within gene
    strongest_snp_risk_allele       varchar,            -- STRONGEST SNP-RISK ALLELE:
                                                        --   SNP(s) most strongly associated with trait  risk allele
                                                        --   (? for unknown risk allele). May also refer to a haplotype.
    snps                            varchar,            -- SNPS:
                                                        --   Strongest SNP; if a haplotype it may include more than one rs number
                                                        --   (multiple SNPs comprising the haplotype)
    merged                          boolean,            -- MERGED: denotes whether the SNP has been merged into a subsequent rs record (0 = no; 1 = yes;)
    snp_id_current                  varchar,            -- SNP_ID_CURRENT: current rs number (will differ from strongest SNP when merged = 1)
    context                         varchar,            -- CONTEXT: SNP functional class
    intergenic                      boolean,            -- INTERGENIC: denotes whether SNP is in intergenic region (0 = no; 1 = yes)
    risk_allele_frequency           varchar,            -- RISK ALLELE FREQUENCY:
                                                        --   Reported risk/effect allele frequency associated with strongest SNP in controls
                                                        --   (if not available among all controls, among the control group with the largest sample size).
                                                        --   If the associated locus is a haplotype the haplotype frequency will be extracted.
    p_value                         numeric,            -- P-VALUE:
                                                        --   Reported p-value for strongest SNP risk allele (linked to dbGaP Association Browser).
                                                        --   Note that p-values are rounded to 1 significant digit
                                                        --   (for example, a published p-value of 4.8 x 10-7 is rounded to 5 x 10-7).
    p_value_mlog                    real,               -- PVALUE_MLOG: -log(p-value)
    p_value_text                    varchar,            -- P-VALUE (TEXT): Information describing context of p-value (e.g. females, smokers).
    or_or_beta                      real,               -- OR or BETA:
                                                        --   Reported odds ratio or beta-coefficient associated with strongest SNP risk allele.
                                                        --   Note that if an OR <1 is reported this is inverted, along with the reported allele,
                                                        --   so that all ORs included in the Catalog are >1.
                                                        --   Appropriate unit and increase/decrease are included for beta coefficients.
    ninety_five_percent_ci          varchar,            -- 95% CI (TEXT):
                                                        --   Reported 95% confidence interval associated with strongest SNP risk allele,
                                                        --   along with unit in the case of beta-coefficients. If 95% CIs are not published,
                                                        --   we estimate these using the standard error, where available.
    platform                        varchar,            -- PLATFORM (SNPS PASSING QC):
                                                        --   Genotyping platform manufacturer used in Stage 1;
                                                        --   also includes notation of pooled DNA study design or imputation of SNPs, where applicable
    cnv                             varchar,            -- CNV: Study of copy number variation (yes/no)

                                                        -- File headers for catalog version 1.0.1
                                                        -- ======================================
                                                        --
                                                        -- http://www.ebi.ac.uk/gwas/docs/fileheaders#_file_headers_for_catalog_version_1_0_1
                                                        --
                                                        -- Last updated: 16 September 2016
                                                        --
                                                        -- As for version 1.0 plus
                                                        --
    mapped_trait                    varchar,            -- MAPPED_TRAIT: Mapped Experimental Factor Ontology trait for this study
    mapped_trait_uri                varchar,            -- MAPPED_TRAIT_URI: URI of the EFO trait
    study_accession                 varchar,            -- STUDY ACCESSION: Accession ID allocated to a GWAS Catalog study

    -- Utility columns
    snp_id                          integer
);
CREATE INDEX associations_study_accession ON GwasCatalogAssociations (study_accession);
CREATE INDEX associations_snp_id ON GwasCatalogAssociations (snp_id);

--
-- Table for `studies download files`
--
-- GwasCatalogStudies() is a subset of GwasCatalogAssociations() + only `association_count` column, so skip creating.

--
-- Table for `ancestry download`
--
DROP TABLE IF EXISTS GwasCatalogAncestry;
CREATE TABLE GwasCatalogAncestry (
                                                        -- File headers for ancestry download
                                                        -- ==================================
                                                        --
                                                        -- http://www.ebi.ac.uk/gwas/docs/fileheaders#_file_headers_for_ancestry_download
                                                        --
                                                        -- Added: 16 September 2016
                                                        --
    study_accession                 varchar  not null,  -- STUDY ACCESSION: Accession ID allocated to a GWAS Catalog study
    pubmed_id                       integer  not null,  -- PUBMEDID: PubMed identification number
    first_author                    varchar  not null,  -- FIRST AUTHOR: Last name and initials of first author
    "date"                          date     not null,  -- DATE: Publication date (online (epub) date if available)
    initial_sample_description      varchar  not null,  -- INITIAL SAMPLE DESCRIPTION:
                                                        --   Sample size and ancestry description for stage 1 of GWAS
                                                        --   (summing across multiple Stage 1 populations, if applicable)
    replication_sample_description  varchar,            -- REPLICATION SAMPLE DESCRIPTION:
                                                        --   Sample size and ancestry description for subsequent replication(s)
                                                        --   (summing across multiple populations, if applicable)
    stage                           varchar,            -- STAGE: Stage of the GWAS to which the sample description applies, either initial or replication
    number_of_indivduals            integer,            -- NUMBER OF INDIVDUALS: Number of individuals in this sample
    broad_ancestral_category        varchar,            -- BROAD ANCESTRAL CATEGORY: Broad ancestral category to which the individuals in the sample belong
    country_of_origin               varchar,            -- COUNTRY OF ORIGIN: Country of origin of the individuals in the sample
    country_of_recruitment          varchar,            -- COUNTRY OF RECRUITMENT: Country of recruitment of the individuals in the sample
    additonal_ancestry_description  varchar             -- ADDITONAL ANCESTRY DESCRIPTION: Any other information relevant to the sample description
);
CREATE INDEX ancestry_study_accession ON GwasCatalogAncestry (study_accession);
