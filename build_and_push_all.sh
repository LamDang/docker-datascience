registry=$1
tag=$2
for dir in $(ls -d */)
do
	echo $dir
	docker build -t ${dir: :-1} ${dir}
	docker tag ${dir: :-1} ${registry}/${dir: :-1}:${tag}
	docker push ${registry}/${dir: :-1}:${tag}
done
