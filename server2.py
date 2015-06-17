import sys
from bottle import static_file
from json import dumps
from bottle import route, run, template,post,request,get
import edx_dl
import re
import bottle
import lxml.html
from bs4 import BeautifulSoup
bottle.BaseRequest.MEMFILE_MAX = 1024 * 1024

@get('/<filename:re:.*\.js>')
def javascripts(filename):
    print filename
    return static_file(filename,  root='js/')


@route('/index')
def index():
    return template('template2')
@post('/hello/123')
def test():
    
    req =  request.json
    print repr(req)[:20]
    html = req['code']
    path = req['path']
    
    html = lxml.html.fromstring(html)
    elem = html.xpath(path)[0]
    elem.attrib['style'] = 'border: 5px solid red;'
    elem.attrib['class'] = 'specialsnowflake'
    for elem,n in [(path[:i[0]+1],i[1]) for i in reversed([(i.end(),n) for n,i in enumerate(re.finditer(re.compile('/'),path[2:]))]) ]:
        print n
        html.xpath(elem)[0].attrib['style'] = 'border: dotted %spx rgba(255, 0, 0, .5);' % (n*2+1)
        html.xpath(elem)[0].attrib['new'] = 'specialsnowflake'
    soup = BeautifulSoup(lxml.html.tostring(html))
    for i in soup.findAll('script'):
        i.extract()
    soup.html.head.style.append("""@-webkit-keyframes pulse-border {
from, to { box-shadow: 0 0 0 0 black;}
50% { box-shadow: 0 0 0 4px black; }
}
    div.line {  -webkit-transform-origin: 0 100%;            height: 3px; /* Line width of 3 */            background: #000; /* Black fill */        }""")
    return dumps({'html':soup.html.renderContents()})
@post('/hello/<id>')
def process(id):
    print id

run(host='localhost', port=8088,reloader=True,debug=True)