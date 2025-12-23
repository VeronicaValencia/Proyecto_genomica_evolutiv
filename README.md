# Estudio Genómico de Domesticación en Banano: Análisis de Diversidad y Estructura

## Descripción del Proyecto

Este proyecto analiza los patrones de diversidad genética, estructura poblacional y relaciones filogenéticas en accesiones de banano (*Musa* spp.). El estudio se centra en comparar ancestros silvestres diploides (*Silvestre_2x*) con cultivares diploides y triploides (*Cultivado_2x*, *Cultivado_3x*).

Utilizando un dataset de SNPs, buscamos cuantificar el impacto del "cuello de botella" de la domesticación y el efecto de la poliploidía sobre la variabilidad genética. El repositorio contiene un flujo de trabajo bioinformático reproducible en R que abarca desde el control de calidad (QC) hasta el escaneo de genoma para la detección de genes bajo selección.

## Hipótesis

1.  **Estructura:** Las poblaciones de banano cultivado exhibirán una diferenciación genética clara ($F_{ST}$) respecto a sus ancestros silvestres.
2.  **Modo Reproductivo:** Los grupos cultivados (especialmente los triploides) presentarán un exceso significativo de heterocigosidad ($H_o > H_e$, $F_{IS} < 0$) debido a la propagación clonal vegetativa prolongada, en contraste con los silvestres que mostrarán equilibrio o endogamia.
3.  **Filogenia:** Los cultivares formarán clados monofiléticos derivados de un subconjunto de la diversidad silvestre.

## Objetivos

1.  **Control de Calidad:** Implementar un filtrado robusto de muestras y variantes (SNPs) para asegurar la fiabilidad de los datos genómicos.
2.  **Evaluar Estructura Poblacional:** Visualizar la relación genética y agrupamientos mediante Análisis de Componentes Principales (PCA).
3.  **Reconstrucción Filogenética:** Inferir las relaciones evolutivas y el origen de los cultivares mediante árboles *Neighbor-Joining* enraizados.
4.  **Estimar Diversidad y Modo Reproductivo:** Calcular Heterocigosidad ($H_o$ vs $H_e$) e Índice de Fijación ($F_{IS}$) para diagnosticar patrones de clonalidad vs. reproducción sexual.
5.  **Detección de Selección:** Identificar *loci* candidatos a domesticación mediante un escaneo genómico de diferenciación ($G_{ST}$ outliers).

## Datos y Muestras

El estudio utiliza datos genómicos en formato VCF y metadatos asociados.

* **Especie:** *Musa* spp. (Banano y Plátano).
* **Archivos de entrada:**
    * `data/dataset_tesis_banano.vcf.gz`: Genotipos (SNPs).
    * `data/popmap_tesis.txt`: Metadatos poblacionales.
* **Grupos de Estudio:**
    * **Silvestre_2x:** Ancestros diploides (Referencia/Outgroup).
    * **Cultivado_2x:** Cultivares diploides.
    * **Cultivado_3x:** Cultivares triploides.

## Metodología y Herramientas

El análisis se realiza íntegramente en el entorno **R**. El flujo de trabajo está automatizado para garantizar la reproducibilidad.

### Librerías Principales

* **vcfR:** Lectura, manipulación y control de calidad de archivos VCF.
* **adegenet:** Análisis multivariado (PCA) y manejo de objetos genéticos (`genlight`/`genind`).
* **hierfstat:** Estimación de estadísticos F de Wright ($F_{ST}$, $F_{IS}$) y diversidad básica.
* **ggtree / ape:** Visualización avanzada y cálculo de árboles filogenéticos.
* **tidyverse (ggplot2, dplyr):** Manipulación de datos y visualización gráfica de alto nivel.
* **poppr:** Análisis de genética de poblaciones y clonlidad.

### Flujo de Trabajo (Workflow)

El script principal ejecuta los siguientes pasos secuenciales:

1.  **Configuración y QC Visual:** Diagnóstico de profundidad de lectura (DP) y datos faltantes (Missingness) por muestra.
2.  **Filtrado de Datos:** Limpieza automática de muestras con >50% de datos faltantes y SNPs con baja frecuencia (MAF < 0.03).
3.  **Análisis de Estructura (PCA):** Visualización de la dispersión genética con elipses de confianza para validar la separación biológica.
4.  **Filogenia:** Construcción de árbol *Neighbor-Joining* enraizado con un *outgroup* silvestre (*M. balbisiana*) para trazar la historia evolutiva.
5.  **Estadísticas de Diversidad:**
    * Comparación de Heterocigosidad Esperada ($H_e$) vs Observada ($H_o$).
    * Cálculo de $F_{IS}$ para inferir clonalidad (valores negativos) o endogamia (valores positivos).
6.  **Diferenciación Genética:** Cálculo de matriz de distancias $F_{ST}$ (Weir & Cockerham) global y por pares.
7.  **Genome Scan:** Identificación de SNPs bajo selección positiva (Top 1% $G_{ST}$) comparando silvestres vs. cultivados.

## Instrucciones de Ejecución

1.  **Clonar el repositorio:**

2.  **Estructura de Carpetas:**
    Asegúrate de que los archivos de datos estén en la carpeta correcta:
    * `data/dataset_tesis_banano.vcf.gz`
    * `data/popmap_tesis.txt`

3.  **Ejecutar el Análisis:**
    Abrir el archivo `.Rmd` (R Markdown) en RStudio y ejecutar los chunks secuencialmente o realizar un "Knit" para generar el reporte HTML completo.
