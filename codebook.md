# Codebook
The R script run_analysis.R and the downloaded data folder "UCI HAR Dataset" should be in the same working directory. Please do not change the folder name.

To make the code work, please amend the file path to the `setwd()` function.

## Variables and their treatment
### Initial data
The data corresponds to the results of an experiment carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a Samsung Galaxy S II. For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

The relevant information about the files follows:

- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

And for both the train and test data the following files are given:

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and - - - 'total_acc_z_train.txt' files for the Y and Z axis.
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

Additional descriptions regarding the physical meaning of the data can be found in README.txt within the data folder "UCI HAR Dataset".


### Processed data
Following the instrucions of the project the following additional datasets were created and transformed:


- 'test': Contains the merged data for 'subject_test', 'Y_test' and 'X_test'.
- 'train': Contains the merged data for 'subject_train', 'Y_train' and 'X_train'.
- 'fulldata': Contains the merged data for 'test' and 'train.
- 'fulldata.ss': Contains a subset of the data from 'fulldata', only extracting out mean and standard deviations for each measurement.
- 'tidyData': Contains an independent tidy data set with the average of each variable for each activity and each subject, using data taken from 'fulldata.ss'.

In order to use more intuitive names, the built-in funcion gsub() has been repeatedly used in order to make changes to the variables. The variable names are made more intuitive by makeing the following replacements:

- t -> time
- f -> frequency
- Acc -> Accelerometer
- Gyro -> Gyroscope
- Mag -> Magnitude
- BodyBody -> Body

## Output
The R script run_analysis.R generates the following two data files:

'processeddata.txt': Contains the desired data (10,299 observations of the 68 variables). The first two variables contain the subject ID number and the specific activity. The other 66 variables correspond to the different values of the mean and standard deviation obtained for the different features.
'tidydata.txt': Contains the desired data of averages (180 observations of the 68 variables). The first two variables contain the subject ID number and the specific activity. The other 66 variables correspond to the average of each variable for each subject and each activity, as specified by the project instructions.
