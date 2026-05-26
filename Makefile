hello:
	echo "This is the first command"
install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt
lint:
	pylint --disable=R,C hello.py
test:
	python -m test -vv test_hello.py
