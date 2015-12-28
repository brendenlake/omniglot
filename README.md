# Omniglot data set for one-shot learning

This dataset contains 1623 different handwritten characters from 50 different alphabets.   
Each of the 1623 characters was drawn online via Amazon's Mechanical Turk by 20 different people.   
Each image is paired with stroke data, a sequences of [x,y,t] coordinates with time (t) in milliseconds. Stroke data is available in MATLAB files only.

### Citing this data set
Please cite the following paper:


[Lake, B. M., Salakhutdinov, R., and Tenenbaum, J. B. (2015). Human-level concept learning through probabilistic program induction.](http://www.sciencemag.org/content/350/6266/1332.short) _Science_, 350(6266), 1332-1338.


We are grateful for the [Omniglot](http://www.omniglot.com/) encyclopedia of writing systems for helping to make this data set possible, and for [Jason Gross](https://people.csail.mit.edu/jgross/) who was essential to the development and collection of this data set.


### CONTENTS
The Omniglot data set contains 50 alphabets total. We generally split these into a background set of 30 alphabets and an evaluation set of 20 alphabets.  

To compare with the results in our paper, only the background set should be used to learn general knowledge about characters (e.g., hyperparameter inference or feature learning). One-shot learning results are reported using alphabets from the evaluation set.

A more challenging representation learning task uses the smaller background sets "background small 1" and "background small 2". Each of these contains just 5 alphabets, more similar to the experience that a human adult might have in learning about characters in general.  Our paper reports a large set of results on the 30 background alphabets, as well as results for several models on these smaller, more challenging background sets.


### MATLAB

Learn about the structure of the data set by running the script 'demo.m'.   

Key data files (images and strokes):   
data_background.mat   
data_evaluation.mat   
data_background_small1.mat   
data_background_small2.mat   

To compare with the one-shot classification results in our paper, run 'demo_classification.m' in the 'one-shot-classification' folder to demo a baseline model using Modified Hausdorff Distance.


### PYTHON

Python 2.7.*   
Requires scipy and numpy   

Key data files (images only):   
images_background.zip   
images_evaluation.zip   
images_background_small1.zip   
images_background_small2.zip   

To compare with the one-shot classification results in our paper, enter the 'one-shot-classification' directory and unzip 'all_runs.zip' and place all the folders 'run01',...,'run20' in the current directory. Run 'demo_classification.py' to demo a baseline model using Modified Hausdorff Distance.