import sys

def main(**kw):
    # print('foo {}'.format(foo))
    # print('bar {}'.format(bar))
    for k, v in kw.items():
        print('{} = {}'.format(k,v))

if __name__ == "__main__":
    try:
        main (**dict(arg.split('=') for arg in sys.argv[1:]))
    except ValueError:
        print('Internal Error.')
    except Exception as e: 
        print('Unknown Error, ',e)
    # my_string = "blah, lots  ,  of ,  spaces, here "
    # result = [x.strip() for x in my_string.split(',')]