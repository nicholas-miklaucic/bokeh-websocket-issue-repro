#!/usr/bin/env python3
"""Shows the code used to generate the embed found in embed.html."""

from bokeh.embed import server_document

print(server_document("https://constellate.dev/sliders"))
