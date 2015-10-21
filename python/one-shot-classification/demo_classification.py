import numpy as np
import copy
from scipy.ndimage import imread
from scipy.spatial.distance import cdist

# Parameters
nrun = 20 # number of classification runs
fname_label = 'class_labels.txt' # where class labels are stored for each run

def classification_run(folder,f_load,f_cost,ftype='cost'):
	# Compute error rate for one run of one-shot classification
	#
	# Input
	#  folder : contains images for a run of one-shot classification
	#  f_load : itemA = f_load('file.png') should read in the image file and process it
	#  f_cost : f_cost(itemA,itemB) should compute similarity between two images, using output of f_load
	#  ftype  : 'cost' if small values from f_cost mean more similar, or 'score' if large values are more similar
	#
	# Output
	#  perror : percent errors (0 to 100% error)
	# 
	assert ((ftype=='cost') | (ftype=='score'))

	# get file names
	with open(folder+'/'+fname_label) as f:
		content = f.read().splitlines()
	pairs = [line.split() for line in content]
	test_files  = [pair[0] for pair in pairs]
	train_files = [pair[1] for pair in pairs]
	answers_files = copy.copy(train_files)
	test_files.sort()
	train_files.sort()	
	ntrain = len(train_files)
	ntest = len(test_files)

	# load the images (and, if needed, extract features)
	train_items = [f_load(f) for f in train_files]
	test_items  = [f_load(f) for f in test_files ]

	# compute cost matrix
	costM = np.zeros((ntest,ntrain),float)
	for i in range(ntest):
		for c in range(ntrain):
			costM[i,c] = f_cost(test_items[i],train_items[c])
	if ftype == 'cost':
		YHAT = np.argmin(costM,axis=1)
	elif ftype == 'score':
		YHAT = np.argmax(costM,axis=1)
	else:
		assert False

	# compute the error rate
	correct = 0.0
	for i in range(ntest):
		if train_files[YHAT[i]] == answers_files[i]:
			correct += 1.0
	pcorrect = 100 * correct / ntest
	perror = 100 - pcorrect
	return perror

def ModHausdorffDistance(itemA,itemB):
	# Modified Hausdorff Distance
	#
	# Input
	#  itemA : [n x 2] coordinates of "inked" pixels
	#  itemB : [m x 2] coordinates of "inked" pixels
	#
	#  M.-P. Dubuisson, A. K. Jain (1994). A modified hausdorff distance for object matching.
	#  International Conference on Pattern Recognition, pp. 566-568.
	#
	D = cdist(itemA,itemB)
	mindist_A = D.min(axis=1)
	mindist_B = D.min(axis=0)
	mean_A = np.mean(mindist_A)
	mean_B = np.mean(mindist_B)
	return max(mean_A,mean_B)

def LoadImgAsPoints(fn):
	# Load image file and return coordinates of 'inked' pixels in the binary image
	# 
	# Output:
	#  D : [n x 2] rows are coordinates
	I = imread(fn,flatten=True)
	I = np.array(I,dtype=bool)
	I = np.logical_not(I)
	(row,col) = I.nonzero()
	D = np.array([row,col])
	D = np.transpose(D)
	D = D.astype(float)
	n = D.shape[0]
	mean = np.mean(D,axis=0)
	for i in range(n):
		D[i,:] = D[i,:] - mean
	return D

if __name__ == "__main__":
	#
	# Running this demo should lead to a result of 38.8 percent errors.
	#
	#   M.-P. Dubuisson, A. K. Jain (1994). A modified hausdorff distance for object matching.
	#     International Conference on Pattern Recognition, pp. 566-568.
	#
	# ** Models should be trained on images in 'images_background' directory to avoid 
	#  using images and alphabets used in the one-shot evaluation **
	#
	print 'One-shot classification demo with Modified Hausdorff Distance'
	perror = np.zeros(nrun)
	for r in range(1,nrun+1):
		rs = str(r)
		if len(rs)==1:
			rs = '0' + rs		
		perror[r-1] = classification_run('run'+rs, LoadImgAsPoints, ModHausdorffDistance, 'cost')
		print " run " + str(r) + " (error " + str(	perror[r-1] ) + "%)"		
	total = np.mean(perror)
	print " average error " + str(total) + "%"