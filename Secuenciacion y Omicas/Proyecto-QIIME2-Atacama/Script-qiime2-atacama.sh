## Preparación del entorno
conda activate qiime2-amplicon-2023.9
mkdir qiime2-atacama
cd qiime2-atacama

## Descarga de datos necesarios
wget -O "sample-metadata.tsv" https://data.qiime2.org/2023.9/tutorials/atacama-soils/sample_metadata.tsv
mkdir emp-paired-end-sequences
wget -O "emp-paired-end-sequences/forward.fastq.gz" https://data.qiime2.org/2023.9/tutorials/atacama-soils/10p/forward.fastq.gz
wget -O "emp-paired-end-sequences/reverse.fastq.gz" https://data.qiime2.org/2023.9/tutorials/atacama-soils/10p/reverse.fastq.gz
wget -O "emp-paired-end-sequences/barcodes.fastq.gz" https://data.qiime2.org/2023.9/tutorials/atacama-soils/10p/barcodes.fastq.gz

## Crear artefacto de qiime2 con las secuencias
qiime tools import --type EMPPairedEndSequences --input-path emp-paired-end-sequences --output-path emp-paired-end-sequences.qza

## Demultiplexar las reads
qiime demux emp-paired --m-barcodes-file sample-metadata.tsv --m-barcodes-column barcode-sequence --p-rev-comp-mapping-barcodes --i-seqs emp-paired-end-sequences.qza --o-per-sample-sequences demux-full.qza --o-error-correction-details demux-details.qza

## Crear una submuestra 
# (Importante tener en cuenta que no se coloca semilla por lo que los resultados varían cada vez que se ejecute)
# Generar submuestra
qiime demux subsample-paired --i-sequences demux-full.qza --p-fraction 0.3 --o-subsampled-sequences demux-subsample.qza
# Visualizar subconjunto para explorar datos restantes (https://view.qiime2.org/)
qiime demux summarize --i-data demux-subsample.qza --o-visualization demux-subsample.qzv

## Filtrar muestras con menos de 100 reads
# Exportar información de la submuestra
qiime tools export --input-path demux-subsample.qzv --output-path ./demux-subsample/
# Filtrar muestras con menos de 100 reads
qiime demux filter-samples --i-demux demux-subsample.qza --m-metadata-file ./demux-subsample/per-sample-fastq-counts.tsv --p-where 'CAST([forward sequence count] AS INT) > 100' --o-filtered-demux demux.qza

## Revisar calidad y realizar denoising
# Aplicar DADA2
qiime dada2 denoise-paired --i-demultiplexed-seqs demux.qza --p-trim-left-f 13 --p-trim-left-r 13 --p-trunc-len-f 150 --p-trunc-len-r 150 --o-table table.qza --o-representative-sequences rep-seqs.qza --o-denoising-stats denoising-stats.qza
# Generar resúmenes de resultados
qiime feature-table summarize --i-table table.qza --o-visualization table.qzv --m-sample-metadata-file sample-metadata.tsv
qiime feature-table tabulate-seqs --i-data rep-seqs.qza --o-visualization rep-seqs.qzv

## Generar un árbol para el análisis de diversidad filogenética
# Construcción del árbol
qiime phylogeny align-to-tree-mafft-fasttree --i-sequences rep-seqs.qza --o-alignment aligned-rep-seqs.qza --o-masked-alignment masked-aligned-rep-seqs.qza --o-tree unrooted-tree.qza --o-rooted-tree rooted-tree.qza
# Exportación del árbol en formato Newick
qiime tools export --input-path rooted-tree.qza --output-path Visualización/

## Cálculo de diversidad alfa
# Profundidad de muestreo seleccionada: 950 
qiime diversity core-metrics-phylogenetic --i-phylogeny rooted-tree.qza --i-table table.qza --p-sampling-depth 950 --m-metadata-file sample-metadata.tsv --output-dir core-metrics-results
# Cálculo de diversidad alfa - Características observadas
qiime diversity alpha-group-significance --i-alpha-diversity core-metrics-results/observed_features_vector.qza --m-metadata-file sample-metadata.tsv --o-visualization core-metrics-results/observed_features-group-significance.qzv

## Análisis taxonómico
# Descarga GreenGenes
wget -O "gg-13-8-99-515-806-nb-classifier.qza" "https://data.qiime2.org/2023.9/common/gg-13-8-99-515-806-nb-classifier.qza"
# Clasificación taxonómica y tabla
qiime feature-classifier classify-sklearn --i-classifier gg-13-8-99-515-806-nb-classifier.qza --i-reads rep-seqs.qza --o-classification taxonomy.qza
qiime metadata tabulate --m-input-file taxonomy.qza --o-visualization taxonomy.qzv
# Gráfico de abundancia taxonómica
qiime taxa barplot --i-table table.qza --i-taxonomy taxonomy.qza --m-metadata-file sample-metadata.tsv --o-visualization taxa-bar-plots.qzv

## Análisis diferencial de abundancia microbiana (ANCOM)
# Preparación tabla y ejecución ANCOM - Se toma la variable "vegetation"
qiime composition add-pseudocount --i-table table.qza --o-composition-table comp-table.qza
qiime composition ancom --i-table comp-table.qza --m-metadata-file sample-metadata.tsv --m-metadata-column vegetation --o-visualization ancom-vegetation.qzv
# Agregar taxonomía - Nivel taxonómico seleccionado: 5 (familia)
qiime taxa collapse --i-table table.qza --i-taxonomy taxonomy.qza --p-level 5 --o-collapsed-table table-l5.qza 
qiime composition add-pseudocount --i-table table-l5.qza --o-composition-table comp-table-l5.qza
qiime composition ancom --i-table comp-table-l5.qza --m-metadata-file sample-metadata.tsv --m-metadata-column vegetation --o-visualization l5-ancom-vegetation.qzv
