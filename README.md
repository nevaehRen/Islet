# Islet
It included GUI for Islet Ca data analysis based on t-SNE and NMF algorithm

## t-SNE for Islet Ca traces analysis
- t-SNE (t-Distributed Stochastic Neighbor Embedding) is a technique that visualize high-dimensional data by mapping the cells in a low dimensional space, and keeps the global structure within the high-dimensional data.

- For Ca2+ images obtained during 10G glucose stimulation, we first manually selected centroids of individual cells, and obtained the mean Ca2+ traces over the regions of 10 × 10 pixels  (3 um × 3 um) surrounding the centroids. Here we provided 3 .mat files which are slow, fast and mixed oscillation islet cell traces. You can find the data in  Folder "Figure3 slow fast mixed  Glu-GCaMP6f Ins2-RCaMP1.07 islet". It included .png masks as well as a matlab data file. Each of file included  5 minutes Ca2+ traces that included 200 time-points (the sampling interval was 3 seconds).

- To clustered cells purely on their time dependent activity fluctuations but not the amplitudes, we first normalized the Ca2+ traces as values varied between 0 to 1. Next, we used the spearman correlation coefficient to quantify the similarity between any two traces of different cells. Therefore, each cell displayed a vector of similarity with other cells, although the topological structure in the high-dimensional correlation space cannot be directly visualized.  Therefore, by projecting all cellular correlation vectors to a 2-dimensional space with the t-SNE algorithm, we reduced the dimension to visualize underlying structures in the 2D t-SNE space. Because two close cells conferred similar activities of Ca2+, we used CLA (Clustering by Local Gravitation), a distribution density-based classification algorithm to cluster cells of similar activities in the two-dimensional t-SNE space . 

- Run the IsletSNE.m file, then click "Load Ca mat" and load the .mat file to GUI. Then click t-SNE button, you will see the beautiful classification results. Two type of cells are alpha and beta cells. Moreover, they are phase-locked during oscillation. 

- We also provide a teaching video at https://www.bilibili.com/video/BV14A411Y7X7 Enjoy ! 
