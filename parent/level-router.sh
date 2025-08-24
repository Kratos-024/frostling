#!/bin/bash
LEVEL_NUM=${USER#level}
exec docker exec -it level${LEVEL_NUM}-container /bin/bash
