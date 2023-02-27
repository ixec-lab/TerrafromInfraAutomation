# app.py
from wsgiref.simple_server import make_server
from socket import gethostname

def simple_app(environ, start_response):
    """Simplest possible application object"""
    status = '200 OK'
    response_headers = [('Content-type', 'text/plain')]
    start_response(status, response_headers)
    msg = "Hello world!, from {}\n".format(str(gethostname()))
    return [bytes(msg,'UTF-8')]
with make_server('', 80, simple_app) as httpd:
    print("Serving on port 80 ...")
    httpd.serve_forever()