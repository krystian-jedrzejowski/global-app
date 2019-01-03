##### To run tests locally execute following commands (assume chromedriver is installed)
```
bundle install
rspec
```

---

##### To run tests remotely execute following commands:
```
bundle install
docker-compose up -d
DRIVER=remote_chrome rspec
```
---

##### Supported drivers
```
DRIVER=chome|remote_chrome|remote_firefox
```
---

##### After test execution allure report is generated under reports/ directory. To generate pretty html report install [allure command line tool](https://docs.qameta.io/allure/#_installing_a_commandline) and execute following command:
```
allure serve reports/allure-results
```

There is also [jenkins allure plugin](https://wiki.jenkins.io/display/JENKINS/Allure+Plugin 'Allure Plugin') to generate allure report.