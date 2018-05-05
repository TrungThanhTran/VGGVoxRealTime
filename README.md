# VGGVoxRealTime
Thanks VGGVox Oxford Model for the Speaker Recognition model generation. We would like to port to Python for realtime running

1>	Overview
•	VGGVox is an end-to-end speaker verification model based on the VGG-M network architecture, trained on the VoxCeleb dataset. The code is based on the paper “VoxCeleb: a large-scale speaker identification dataset” by Nagrani et al and the MatLab verification evaluation script: https://github.com/a-nagrani/VGGVox. 
•	The pretrained model weights are converted from the Matlab version downloaded from: https://www.robots.ox.ac.uk/~vgg/data/voxceleb/
•	The project currently only contains evaluation code, not training. It supports 3 evaluation modes: offline (pre-recorded test samples), batch_offline (pre-recorded test samples, against a large number of enroll samples), online (real-time test sample). In the online mode, the script runs a loop that records a voice sample, computes score against all enrolled speakers, and outputs  identification result. 


2>	Directory structure
└── data/: data folder
	└── model_weights/model_0.h5: pretrained model weights 
	└── wav/: contains wav files, each set organized in a folder
└── lst/: contains index/list files
	└── test_list.csv: list of test utterances
	└── enroll_list.csv: list of enroll utterances
└── res/: contains scoring results
└── utils/: contains utility scripts
└── compute_tests.py: main evaluation script
└── constants.py: contains changeable parameters
└── model.py: contains model architecture definition
└── … 


3>	Instructions
•	Configurations
◦	Change list of test and enroll utterances in lst/. Each line has form: 			“filename speaker”
◦	Change parameters in constants.py. Notable ones are
▪	TEST_MODE: “online”, “offline”, or “batch_offline”
▪	COST_METRIC: scoring metric; “cosine” or “euclidean”
▪	MAX_SEC_ENROLL: maximum length of enroll samples
▪	ONLINE_RECORD_SEC: duration of real-time record 
•	To start evaluation script: python3 compute_tests.py
◦	For offline and batch_offline test modes, results are stored in res/OFFLINE_RESULT_FILE. Results have form:
[test utterance] [correct speaker] [scores against all enrolled speakers] [5 speakers with highest scores] [accuracy of top 1, top 1%, top 5%, top 10%]
◦	For online test mode, results will be printed to the console. 
