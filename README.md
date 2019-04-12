# sdo-matlab
*FIV Dec 2017*

SDO (Sparse Data Observers): outlier detection based on low density models

SDO is an algorithm that scores data samples with estimations of distance-based outlierness. 
Alike other outlier detection algorithms, SDO is an eager learner that creates a low-density model 
of the dataset during a training phase and later compares new samples with the created model. 
Such scheme allows lightening the computational load during application phases, not requiring 
to recall old data samples again.

SDO is devised to be embedded in systems or frameworks that operate autonomously and must process 
large amounts of data in a continuos manner. SDO is a machine learning solution for Big Data and 
stream data applications.

## Included files
- "sdos.m" analyzes an input dataset and outputs oulierness scores (safe version, time demanding, with "for loops").

- "sdof.m" analyzes an input dataset and outputs oulierness scores (fast version, vectorized, memory demanding).

- "sdos_apply_model.m" applies a model obtained with "sdo.m" on new samples not used for training the model (safe version).

- "sdof_apply_model.m" applies a model obtained with "sdo.m" on new samples not used for training the model (fast version).

- "sample_size.m" calculates the number of samples to match the mean for a case of finite population (optional).

- "hbdiscret.m" discretizes a dataset based on histograms (optional).

## Reference

F. Iglesias, T. Zseby, A. Zimek. *Outlier Detection Based on Low Density Models*. Workshop on Data Science and Big Data Analytics (DSBDA), IEEE International Conference on Data Mining (ICDM), Singapore; 11-17-2018 – 11-20-2018. IEEE Computer Society Press, 2018. 

For more information, experiments and datasets, please go to:
https://www.cn.tuwien.ac.at/data-analysis/outliers-sdo/

