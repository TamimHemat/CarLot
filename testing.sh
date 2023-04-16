#!/bin/bash

test_reports_exist=$(ls test-reports/*.xml 2> /dev/null | wc -l)
if [ $test_reports_exist -gt 0 ]; then
    rm test-reports/*.xml || true
fi
  
api_reports_exist=$(ls api-test-reports/*.xml 2> /dev/null | wc -l)
if [ $api_reports_exist -gt 0 ]; then
    rm api-test-reports/*.xml || true
fi

for file in test*.py; do
    coverage run --omit */site-packages/*,*/dist-packages/* $file
done
coverage report

test_reports_exist=$(ls test-reports/*.xml 2> /dev/null | wc -l)
if [ $test_reports_exist -gt 0 ]; then
    #junit test-reports/*.xml
    echo "test reports exist. can't run junit tho"
fi

api_reports_exist=$(ls api-test-reports/*.xml 2> /dev/null | wc -l)
if [ $api_reports_exist -gt 0 ]; then
    #junit api-test-reports/*.xml
    echo "api reports exist. can't run junit tho"
fi
