#!/bin/bash

rbd create foo --size 5120
rbd map foo
rbd showmapped
