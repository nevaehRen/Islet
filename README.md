# Islet
It included GUI for Islet Ca data analysis based on t-SNE and NMF algorithm

## NMF for Islet Ca image analysis

NMF (Non-negative Matrix Factorization) is a temporal-spatial clustering algorithm that is based on the activity of individual pixels, which was approximately decomposed into an additive linear, non-negative combination of images of different numbers of modes pre-defined. Because cell segmentation is not necessary, NMF analysis avoids effects of manual thresholding of images.

Here we provided a 2.5 minutes of islet Ca2+ images - "C57_Islet_10G.tif" (50 frames, under 10G stimulation), and used NMF to decompose the time-dependent stack into the combination of images of two modes. The algorithm started from two random modes of image stacks in combination with two random time-dependent coefficients.

Run Islet_NMF_RHX function, then you will find after ~100 iterations, two distinct group of cells emerged along with two anti-oscillatory time-dependent coefficients. We have proved they are alpha and beta cells.

We provide a teaching video at https://www.bilibili.com/video/BV1QC4y1b7BC?pop_share=1, Enjoy !
