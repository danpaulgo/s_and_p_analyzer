# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application

      The bin/analyzer file opens up to a CLI application. Upon opening, the user is presented with a menu of 7 options to view or analyze stock market data. The user is able to choose an option and enter additional information in order to retrieve information.

- [x] Pull data from an external source

      All data is pulled from "www.multpl.com" which includes a table that provides S&P 500 pricing data dating back to 1871. Each row of data is scraped from the webpage and then used to create a "datapoint" object.

- [x] Implement both list and detail views

      The main menu contains a list of 7 options. The user may choose from these options in order to retrieve more detailed information on individual dates, ranges, or the market in its entirety.
