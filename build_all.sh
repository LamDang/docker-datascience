for dir in $(ls -d */):
do
	docker build -t lamdang/${dir: :-1} ${dir}
done
