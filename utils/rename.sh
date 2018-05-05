for f in *.wav; do
	mv $f ${f/B_/''}
done