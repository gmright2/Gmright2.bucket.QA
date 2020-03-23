steps:
      - run:
          command: |
            yarn add ava tap-xunit --dev # or you could use npm
            mkdir -p ~/reports
            ava --tap | tap-xunit > ~/reports/ava.xml
          when: always
      - store_test_results:
          path: ~/reports
      - store_artifacts:
          path: ~/reports          
