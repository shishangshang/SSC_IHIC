# SSC_IHIC
This is the code for paper "Semi-supervised Learning based on Intra-view Heterogeneity and Inter-view Compatibility for Image Classification"

To whom it may concern,

For the purpose of reproducibility, we released our SSC_IHIC algorithm here. The simple way is to run the corresponding startup, i.e.
Demo.m.

#### Some notes:
1. If the multi-view data set has same sample number for each class, it is regarded as a balanced data set. Please 
set  'test_SSC_IHIC_balance.m'  as a subfunction in 'demo.m'; For example, the MSRC-v1 and HW belong to balanced data sets.

2. If the multi-view data set is unbalanced, please set 'test_SSC_IHIC_unbalance.m' as a subfunction in 'demo.m'; For instance, the 
Cal101-7 and Cal101-20 data sets belong to unbalanced data sets.

If there are any questions, please do not hesitate to contact me (Email: shaojunshi@mail.nwpu.edu.cn).

Sincerely yours,
Shaojun SHI
