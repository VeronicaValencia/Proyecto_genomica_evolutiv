# -----------------------------
# 0. Instalar y cargar paquetes
# -----------------------------
packages <- c("vcfR", "adegenet", "pegas", "hierfstat", "poppr", "SNPRelate")
new_packages <- packages[!(packages %in% installed.packages()[, "Package"])]
if (length(new_packages)) install.packages(new_packages)

lapply(packages, library, character.only = TRUE)

# -----------------------------
# 1. Inputs del usuario
# -----------------------------
vcf_file <- "data/tu_archivo.vcf.gz"      # <-- CAMBIA ESTO
meta_file <- "data/metadatos.txt"         # <-- 2 columnas: sample, grupo

# -----------------------------
# 2. Leer VCF y metadatos
# -----------------------------
vcf <- read.vcfR(vcf_file, verbose = FALSE)
meta <- read.table(meta_file, header = TRUE, stringsAsFactors = FALSE)

# -----------------------------
# 3. Convertir VCF a objetos R
# -----------------------------
gen <- vcfR2genind(vcf)
gl <- vcfR2genlight(vcf)

# Alinear metadatos con muestras del VCF
samples <- indNames(gen)
meta <- meta[match(samples, meta$sample), ]
pop(gen) <- as.factor(meta$grupo)
pop(gl) <- as.factor(meta$grupo)

# -----------------------------
# 4. Diversidad nucleotídica por grupo
# -----------------------------
dna <- vcfR2DNAbin(vcf)
meta$grupo <- as.factor(meta$grupo)

cat("\n--- Diversidad nucleotídica promedio (π) por grupo ---\n")
for (grp in unique(meta$grupo)) {
  grp_samples <- meta$sample[meta$grupo == grp]
  grp_dna <- dna[rownames(dna) %in% grp_samples, ]
  pi_val <- nuc.div(grp_dna)
  cat(grp, ":", pi_val, "\n")
}

# -----------------------------
# 5. PCA con colores por grupo
# -----------------------------
pca <- glPca(gl, nf = 3)

colors <- ifelse(meta$grupo == "cultivada", "tomato", "steelblue")
plot(pca$scores[,1], pca$scores[,2], col = colors, pch = 19,
     xlab = "PC1", ylab = "PC2", main = "PCA de SNPs")
legend("topright", legend = unique(meta$grupo), col = unique(colors), pch = 19)

# -----------------------------
# 6. FST entre grupos
# -----------------------------
fst <- genet.dist(gen, method = "WC84")  # método Weir & Cockerham
cat("\n--- FST entre grupos ---\n")
print(fst)