suffix=$1
for dir in $(ls -d */)
do
	echo $dir
	docker build -t lamdang/${dir: :-1}${suffix} ${dir}
done
