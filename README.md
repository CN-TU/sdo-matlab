# sdo-matlab, FIV Dec 2017
SDO (Sparse Data Observers): outlier detection based on low density models

SDO is an algorithm that scores data samples with estimations of distance-based outlierness. 
Alike other outlier detection algorithms, SDO is an eager learner that creates a low-density model 
of the dataset during a training phase and later compares new samples with the created model. 
Such scheme allows lightening the computational load during application phases, not requiring 
to recall old data samples again.

SDO is devised to be embedded in systems or frameworks that operate autonomously and must process 
large amounts of data in a continuos manner. SDO is a machine learning solution for Big Data and 
stream data applications.

For more information, experiments and datasets, please go to:
https://www.cn.tuwien.ac.at/data-analysis/outliers-sdo/

