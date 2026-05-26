from main import say_hello

def test_say_hello(capsys):
    # 1. Call the function
    say_hello()
    
    # 2. Read the captured standard output and standard error
    captured = capsys.readouterr()
    
    # 3. Assert the output matches (print() adds a newline character by default)
    assert captured.out == "Hello\n"