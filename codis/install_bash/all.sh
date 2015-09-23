!#/bin/bash

./zookkeeper-compile-step.sh zkServer $1

./codis-compile-step.sh codis_server $1

./ha_keep_compile-step.sh  ha_ke_server $1



