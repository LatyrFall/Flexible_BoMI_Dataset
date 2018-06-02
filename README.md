# Flexible Body-Machine Interface 

C. L. Fall*, U. Côté-Allard*, Q. Mascret*, A. Campeau-Lecours+, M. Boukadoum^, C. Gosselin+ and B. Gosselin*, "Toward a Flexible and Modular Body-Machine Interface for Individuals Living with Severe Disabilities : a Feasibility Study", IEEE Transaction on Neural Systems and Rehabilitation Engineering (Under Review 2018).

## 1. Description

This dataset has been recorded as part of a research project aiming at developing a flexible control interface for individuals with severe disabilities. It uses a wearable and wireless body sensor network, reading motion patterns through IMU nodes, from different body parts (head, shoulder, finger, foot, ...). Five participants (three able-bodied individuals [P1, P2, P3] and two with upper-body disabilities [P4,P5]) were recruited and asked to perform up to nine motion classes. The recorded dataset was used to conduct motion pattern recognition experiments, using a Linear Discriminant Analysis (LDA).

## 2. The content 

###		- Classification Performance
####		o P1.csv, P2.csv, P3.csv, P4.csv, P5.csv
###		- Proportional Control & Reliability
####		o P1_SAE.csv, P1_MAE.csv
###		- Reliability over days
####		o Train set : P1_train_day1.csv, P1_train_day2.csv, P1_train_day3.csv, P1_train_day4.csv, P1_train_day5.csv
####		o Test  set : P1_test_day1.csv,  P1_test_day2.csv,  P1_test_day3.csv,  P1_test_day4.csv,  P1_test_day5.csv

## 3. Matlab script

Matlab scripts used to extract the measured performance described in the Section IV-C of the submitted paper are also provided :

###		- Classification Performance
####		o motion_recognition_perf.m
###		- Proportional Control & Reliability
####		o proportional_motion_perf.m
###		- Reliability over days
####		o normalized_perf_over_days.m