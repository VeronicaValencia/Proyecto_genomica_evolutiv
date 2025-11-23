# Estudio genómico de Domesticación: Análisis Comparativo de Diversidad entre Tomate Silvestre y Cultivado

## Descripción del Proyecto
Este proyecto analiza los patrones de diversidad genética y estructura poblacional en accesiones de tomate (*Solanum lycopersicum*) y sus parientes silvestres. Utilizando SNPs, buscamos cuantificar el impacto del "cuello de botella" de la domesticación sobre la variabilidad genética del cultivo moderno.

El repositorio contiene el flujo de trabajo bioinformático para el procesamiento de archivos VCF, cálculo de estadísticos de diversidad y visualización de estructura poblacional.

## Hipótesis
Las poblaciones de tomate cultivado exhibirán una reducción significativa en la diversidad nucleotídica ($\pi$) y heterocigosidad esperada ($H_e$) en comparación con sus ancestros silvestres, debido a la selección artificial y deriva genética asociada a la domesticación. Asimismo, se espera una diferenciación genética clara ($F_{ST}$) entre ambos grupos.

## Objetivos
1. **Estimar la diversidad genética:** Calcular y comparar la diversidad nucleotídica ($\pi$) y la heterocigosidad (observada vs. esperada) en grupos silvestres y cultivados.
2. **Evaluar la estructura poblacional:** Visualizar la relación genética entre las accesiones mediante un Análisis de Componentes Principales (PCA).
3. **Cuantificar la diferenciación:** Determinar el grado de diferenciación genética entre grupos mediante el índice de fijación ($F_{ST}$).

## Datos y Muestras
El estudio utiliza un dataset de SNPs en formato VCF y metadatos asociados.

* **Especies:** *Solanum lycopersicum* (Cultivado) y parientes silvestres.
* **Número total de muestras:** 65 accesiones.
    * **Grupo Cultivado:** 16 muestras (incluyendo accesiones HL, PCA, PPU).
    * **Grupo Silvestre:** 49 muestras (incluyendo accesiones PAMA, PAN, PCO, PLI, POX, etc.).
* **Formato de entrada:** Archivos `.vcf` (genotipos) y `.txt` (metadatos poblacionales).

## Metodología y Herramientas
El análisis se realiza íntegramente en el entorno **R**. El workflow actual abarca desde la carga de datos crudos hasta la estadística descriptiva poblacional.

### Librerías Principales
* **vcfR:** Lectura y manipulación de archivos VCF.
* **adegenet:** Análisis de datos genéticos (objetos `genind`/`genlight`) y PCA.
* **pegas:** Cálculo de diversidad nucleotídica.
* **hierfstat:** Estimación de estadísticos F (Weir & Cockerham).
* **poppr:** Análisis de genética de poblaciones.

### Flujo de Trabajo (Workflow)
El script principal (`scripts/Proyecto_final_gen_evol.R`) ejecuta los siguientes pasos:

1.  **Pre-procesamiento:** Conversión de formato VCF a objetos `genind` y `genlight` de R. Limpieza de nombres de muestras para coincidencia con metadatos.
2.  **Diversidad Nucleotídica ($\pi$):** Cálculo promedio por grupo poblacional.
3.  **Heterocigosidad:** Comparación de $H_o$ vs $H_e$ para evaluar endogamia o selección.
4.  **Análisis Multivariado:** Ejecución de PCA para visualizar agrupamientos genéticos.
5.  **Diferenciación Genética:** Cálculo de $F_{ST}$ por pares (pairwise Weir & Cockerham).

## Instrucciones de Ejecución
1. Clonar este repositorio.
2. Asegurarse de tener los archivos `mi_archivo.vcf` y `metadatos.txt` en la carpeta `data/`.
3. Ejecutar el script desde la raíz del proyecto:
   ```R
   source("scripts/Proyecto_final_gen_evol.R")
