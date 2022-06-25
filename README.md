# Bokeh Apache Websocket Issue Reproduction

Because the issue has something to do with the specific combination of embedding
from a server with HTTPS, I haven't managed to reproduce it on a single machine.

What I've done to set up Apache on an Ubuntu 20.04 cloud machine:

1. `sudo apt install apache2`
1. `sudo a2enmod ssl`
1. `sudo a2enmod rewrite`
1. `sudo a2enmod proxy`
1. `sudo a2enmod proxy_http`
1. `sudo a2enmod proxy_wstunnel`
1. [Set up Let's Encrypt and got an SSH certificate for `constellate.dev`](https://certbot.eff.org/instructions?ws=apache&os=ubuntufocal)

Then, edited the files in the `/etc/` folder to match the ones in the `/etc/` folder on my server. After `sudo systemctl restart apache2` those changes are live.

Running the Bash file `bokeh-server/server.sh` from its directory then starts running the server. At this point `https://constellate.dev/sliders` shows the sliders and everything works as it should.

Then, to reproduce the issue, we use the code in `embed.py` to generate an embed script and put that embed script in `embed.html` as I've done. Serving this file by, for instance,

`python -m http.server --directory . --port 3001`

and then navigating to `http://0.0.0.0:3001/embed.html` shows a blank page and WebSocket connection errors. The terminal that's running `server.sh` should error out as such:

```python-console
HTTPServerRequest(protocol='http', host='localhost:5006', method='GET', uri='/sliders/ws', version='HTTP/1.1', remote_ip='107.137.157.121')
Traceback (most recent call last):
  File "/home/nicholas/anaconda3/lib/python3.9/site-packages/tornado/websocket.py", line 954, in _accept_connection
    open_result = handler.open(*handler.open_args, **handler.open_kwargs)
  File "/home/nicholas/anaconda3/lib/python3.9/site-packages/tornado/web.py", line 3173, in wrapper
    return method(self, *args, **kwargs)
  File "/home/nicholas/anaconda3/lib/python3.9/site-packages/bokeh/server/views/ws.py", line 137, in open
    raise ProtocolError("Subprotocol header is not 'bokeh'")
bokeh.protocol.exceptions.ProtocolError: Subprotocol header is not 'bokeh'
```

### Versions

The Bokeh version on both the server (to run the server) and my machine (to generate the embed) is 2.4.3. Apache is 2.4.41 from the Ubuntu 20.04 (Focal) package repo.
