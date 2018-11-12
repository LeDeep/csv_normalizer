## CSV Normalizer
Takes a CSV file as input, reads the file, normalizes its contents, and writes to a new file with the normalized content.

### Instructions For Running the App
1. Clone the repo
2. Run following commands:

    ```
    bundle Install
    ruby csv_normalizer.rb "#{file-name.csv}" e.g. ruby csv_normalizer.rb "sample.csv"
    ```
A file named "normalized-#{file-name}.csv" (e.g. "normalized-sample.csv") will be created with the normalized contents.

### To Run Tests
```
rspec
```

### Next Steps
1. Error handling
2. Drop rows that contain unparseable data
