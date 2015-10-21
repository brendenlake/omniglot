# Omniglot data set for one-shot learning

This dataset contains 1623 different handwritten characters from 50 different alphabets.   
Each of the 1623 characters was drawn online via Amazon's Mechanical Turk by 20 different people.   
Each image is paired with stroke data, a sequences of [x,y,t] coordinates with time (t) in milliseconds. Stroke data is available in MATLAB files only.

### CONTENTS
The Omniglot data set contains 50 alphabets total.

Here is the split:   
	background : 30 alphabets   
	evaluation : 20 alphabets   

To compare with the results in our paper, only the background set should be used by algorithms to learn general knowledge about characters (e.g., hyper-parameter inference or feature learning). One-shot learning results are reported using alphabets from the evaluation set.

For a smaller and more challenging background set, the sets "background small 1"  and "background small 2" contain just 5 alphabets each.


### MATLAB

Learn about the structure of the data set by running the script 'demo.m'.   

Key data files:   
data_background.mat   
data_evaluation.mat   
data_background_small1.mat   
data_background_small2.mat   

To compare with the one-shot classification results in our paper, run 'demo_classification.m' in the 'one-shot-classification' folder to demo a baseline model using Modified Hausdorff Distance.


### PYTHON

Python 2.7.*   
Requires scipy and numpy   

Key data files:   
images_background.zip   
images_evaluation.zip   
images_background_small1.zip   
images_background_small2.zip   

To compare with the one-shot classification results in our paper, enter the 'one-shot-classification' directory and unzip 'all_runs.zip' and place all the folders 'run01',...,'run20' in the current directory. Run 'demo_classification.py' to demo a baseline model using Modified Hausdorff Distance.


### Citing this data set
Please cite the following paper:

Human-level concept learning through probabilistic program induction
By Brenden Lake, Ruslan Salakhutdinov, and Joshua Tenenbaum 

We are grateful for the [Omniglot](http://www.omniglot.com/) encyclopedia of writing systems for helping to make this data set possible.