NOISE="84-121123-0002"

NOISE_DIR="data/wav/noises/"
NOISE_FILE="${NOISE_DIR}${NOISE}.wav"
SPEECH_DIR="data/wav/prdcv_test_clean/"
# SPEECH_DIR="data/wav/test/"

SPEECH_BEFORE_NOISE=false

# Mix template (clean) audios with specified noise
OUT_DIR="data/wav/prdcv_test_concat_${NOISE}"
if !($SPEECH_BEFORE_NOISE); then
	OUT_DIR="${OUT_DIR}_noise-first/"
fi

rm -rf $OUT_DIR
mkdir $OUT_DIR


for f in $(find $SPEECH_DIR -name '*.wav'); do 
	fn=`echo $f | rev | cut -d \/ -f 1 | rev`  # filename w/o path
	OUT_FILE="${OUT_DIR}/$fn"

	# convert to 16kHz mono
	sox $f -r 16k -c 1 temp_speech.wav
	sox $NOISE_FILE -r 16k -c 1 temp_noise.wav

	# middle 3s of speech sample
	sox temp_speech.wav temp_speech2.wav trim 0.5 3

	# random 1s of noise sample
	len_noise=`soxi -D temp_noise.wav | cut -d \. -f 1`  # drop decimal
	start_noise=$(( ( RANDOM % len_noise ) ))
	sox temp_noise.wav temp_noise2.wav trim $start_noise 1

	# concat 3s speech + 1s noise
	if $SPEECH_BEFORE_NOISE; then
		sox temp_speech2.wav temp_noise2.wav -r 16k -c 1 $OUT_FILE
	else
		sox temp_noise2.wav temp_speech2.wav -r 16k -c 1 $OUT_FILE
	fi

	# clean up
	rm -f temp*

done
