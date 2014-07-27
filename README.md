<p><markdown>
#Markdown Live Editor#
## Tidy data processing description 

The main data set is made by appending the test and train data sets ( "X_test.txt" and "Y_text.txt"). Before joining them, I read the features.txt file. It contains the list of attributes that will be used as column names of the main data set. The features list is cleaned up a bit to remove empty spaces and illegal characters such as "-" and applied as column headings to the main data set. 

I also read the activity lists ("x_test" and "y_text"). These will be added as columns to the main data set. 

The last couple of files to be read are the subject files.

Now we join all the data sets: main data set with the features as its column heading, the subject data set and the activity data set. We do this for train and test data sets. Then the train and test data sets are joined. 

From this large data set, I extracted only columns with "Mean()" or "std()" in their headings to in addition to the first three columns for subject, activity number and activity name. That gives 82 columns (3 + 79 measurement columns). 

Finally, the tidy data is created by aggregating the data set such that the mean of each measurement is given for each subject (30) and each activity (3), resulting in 180 rows.  



</markdown></p>