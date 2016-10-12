registry=$1
tag=$2
for dir in $(ls -d */)
do
	echo $dir
	docker build -t ${dir: :-1} ${dir}
<<<<<<< HEAD
	docker tag ${dir: :-1} ${registry}/${dir: :-1}:${tag}
=======
	docker tag ${registry}/${dir: :-1}:${tag} ${dir: :-1}
>>>>>>> build_and_push
	docker push ${registry}/${dir: :-1}:${tag}
done
