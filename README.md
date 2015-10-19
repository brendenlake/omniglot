# omniglot
Omniglot data set for one-shot character recognition.

This dataset contains 1623 handwritten characters from 50 different alphabets. 
Each of the 1623 characters was drawn online via Amazon's Mechanical Turk by 20 different people. 
Each image is paired with stroke data (formatted as [x,y,time in milliseconds]).

MATLAB: 
Learn about the structure of the data set by running 'demo.m'. 
There are two main data files: 'data_background.mat' (30 alphabets) and 'data_evaluation.mat' (20 alphabets). The one-shot learning results we report involve only characters from 'data_evaluation', while 'data_background' can be used by algorithms to learn general knowledge about characters.

To compare with the one-shot classification results in our paper, use 'demo_classification.m' in the 'one-shot-classification' folder to run the baseline Modified Hausdorff Distance.

PYTHON:
Coming soon

To cite this data set, please cite the following paper:

Human-level concept learning through probabilistic program induction
By Brenden Lake, Ruslan Salakhutdinov, and Joshua Tenenbaum
Email: brenden at-sign nyu dot edu

We are grateful for the www.omniglot.com encyclopedia of writing systems for helping to make this data set possible.
