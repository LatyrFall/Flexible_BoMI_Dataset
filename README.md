# Flexible Body-Machine Interface 

C. L. Fall, U. Côté-Allard, Q. Mascret, A. Campeau-Lecours, M. Boukadoum, C. Gosselin and B. Gosselin, "Toward a Flexible and Modular Body-Machine Interface for Individuals Living with Severe Disabilities : a Feasibility Study", IEEE Transaction on Neural Systems and Rehabilitation Engineering (Under Review 2018).

## 1. Description

This dataset has been recorded as part of a research project aiming at developing a flexible control interface for individuals with severe disabilities. It uses a wearable and wireless body sensor network, reading motion patterns through IMU nodes, from different body parts (head, shoulder, finger, foot, ...). Five participants (three able-bodied individuals [P1, P2, P3] and two with upper-body disabilities [P4,P5]) were recruited and asked to perform up to nine motion classes. The recorded dataset was used to conduct motion pattern recognition experiments, using a Linear Discriminant Analysis (LDA).

## 2. Dataset Content 

* The data recorded from the 5 participants is stored in .csv files labeled with the participants reference name :
    
    - P1.csv, P2.csv, P3.csv : 9 DoFs, 3 sensors used (head, 2 shoulders)
    
              o  Neutral position (1 class) + 3D head motion (6 classes) + Right and Left shoulder motions (2 classes)
              
              o  Sensor1 --> Pitch, Roll, Yaw, Gyrox, Gyroy, Gyroz
              
              o  Sensor2 --> Pitch, Roll, Gyrox, Gyroy, Gyroz
              
              o  Sensor3 --> Pitch, Roll, Gyrox, Gyroy, Gyroz
                
    - P4.csv :  6 DoFs, 2 sensors used (head + right foot)
    
              o  Neutral position (1 class) + 2D head motion (4 classes) + Right Foot Elevation (1 classes)
              
              o  Sensor1 --> Pitch, Roll, Yaw, Gyrox, Gyroy, Gyroz
              
              o  Sensor2 --> Pitch, Roll, Gyrox, Gyroy, Gyroz
                
    - P5.csv :  6 DoFs, 2 sensors used (left thumb + head)
    
              o  Neutral position (1 class) + 2D left thumb motion (4 classes) + head (1 classes)
              
              o  Sensor1 --> Pitch, Roll, Yaw, Gyrox, Gyroy, Gyroz
              
              o  Sensor2 --> Pitch, Roll, Gyrox, Gyroy, Gyroz
             
* The recording sessions with single and multiple amplitude examples (SAE and MAE) performed by P1 :
  
    - P1_MAE.csv : 9 DoFs, 3 sensors used (head, 2 shoulders)
    
    - P1_SAE.csv : 9 DoFs, 3 sensors used (head, 2 shoulders)
              
* Data recording during 5 consecutive days :

    - Train sets : P1_train_day1.csv, P1_train_day2.csv, P1_train_day3.csv, P1_train_day4.csv, P1_train_day5.csv
    
    - Test  sets : P1_test_day1.csv,  P1_test_day2.csv,  P1_test_day3.csv,  P1_test_day4.csv,  P1_test_day5.csv

## 3. Matlab script

Matlab scripts used to extract the measured performance described in the Section IV-C of the submitted paper are also provided :

     - Section IV-C-1) / Classification Performance : motion_recognition_perf.m
     
     - Section IV-C-2) / Proportional Control & Reliability : motion_recognition_perf.m
     
     - Section IV-C-3) / Reliability over days : normalized_perf_over_days.m
