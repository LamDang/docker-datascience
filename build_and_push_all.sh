registry=$1
tag=$2
for dir in $(ls -d */)
do
	echo $dir
	docker build -t ${registry}/${dir: :-1} ${dir}
	docker tag ${registry}/${dir: :-1} ${registry}/${dir: :-1}:${tag}
	docker tag ${registry}/${dir: :-1}:${tag} ${dir: :-1}
	docker push ${registry}/${dir: :-1}:${tag}
done
