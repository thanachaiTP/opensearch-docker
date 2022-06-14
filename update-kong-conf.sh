#!/bin/bash
curl -F config=@conf.d/kong.yml 127.0.0.1:8002/config
