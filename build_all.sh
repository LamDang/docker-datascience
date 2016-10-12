for dir in $(ls -d */)
do
	echo $dir
	docker build -t ${dir: :-1} ${dir}
done
