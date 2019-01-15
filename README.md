#### To run tests locally execute following commands (assume chromedriver is installed)
```
bundle install
rspec
```

#### After test execution allure report is generated under reports/ directory. To generate pretty html report install [allure command line tool](https://docs.qameta.io/allure/#_installing_a_commandline) and execute following command:
```
allure serve reports/allure-results
```

There is also [jenkins allure plugin](https://wiki.jenkins.io/display/JENKINS/Allure+Plugin 'Allure Plugin') to generate allure report.
---

#### To run tests on docker container execute following command:
```
docker-compose run -e TESTS_TO_RUN=sign_in_spec.rb -p 5000:5000 tests
```

#### After test execution allure report is generated. Navigate to [localhost:5000](http://localhost:5000)
---

#### Supported drivers
```
DRIVER=chome|remote_chrome|remote_firefox
```
